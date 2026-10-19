# Verify content preservation and the generated site, rather than just a successful build.
require 'json'
require 'yaml'
require 'nokogiri'
require 'kramdown'
require 'uri'
require 'digest'

ROOT = File.expand_path('..', __dir__)
SITE = File.join(ROOT, '_site')
errors = []
checks = 0
check = lambda do |ok, message|
  checks += 1
  errors << message unless ok
end
baseline = JSON.parse(File.read(File.join(ROOT, 'docs/content-baseline.json')))
data = YAML.load_file(File.join(ROOT, '_data/publications.yml'))
audit = JSON.parse(File.read(File.join(ROOT, 'docs/publications-audit-20261018.json')))
followup = JSON.parse(File.read(File.join(ROOT, 'docs/publications-audit-20261019.json')))
resume = JSON.parse(File.read(File.join(ROOT, 'docs/publications-audit-20261019-followup.json')))
additions = followup.fetch('operations') + resume.fetch('operations')
check.call(additions.all? { |op| op['kind'] == 'add' }, 'Unrecognized follow-up operation')
known_ids = data.values.flatten.map { |p| p['id'] }
crosswalk = resume.fetch('scholar_crosswalk')
check.call(crosswalk.size == resume['scholar_rows_read'] && crosswalk.size == 216, 'Complete Scholar coverage missing')
crosswalk.each do |row|
  if row['disposition'] == 'withheld'
    check.call(row['target_id'].nil? && !row['reason'].to_s.empty?, 'Unexplained withheld Scholar record')
  else
    check.call(known_ids.include?(row['target_id']), 'Scholar crosswalk points to absent record')
  end
end
updates = audit.fetch('paper_updates')
check.call(updates.map { |op| op['before']['citation'] } == baseline['citations']['publications'], 'Paper audit does not preserve the frozen original bibliography')
expected_papers = updates.map { |op| op['after'] } + audit['new_records'].select { |op| op['collection'] == 'publications' }.map { |op| op['after'] } + additions.select { |op| op['collection'] == 'publications' }.map { |op| op['after'] }
confirmations = JSON.parse(File.read(File.join(ROOT, 'docs/publications-confirmations-20261019.json')))
confirmations.fetch('paper_updates').each do |op|
  index = expected_papers.index { |p| p['id'] == op['before']['id'] }
  check.call(index && expected_papers[index] == op['before'], 'Year confirmation lacks preserved before record')
  expected_papers[index] = op['after'] if index
end
check.call(data['publications'].sort_by { |p| p['id'] } == expected_papers.sort_by { |p| p['id'] }, 'Papers differ from documented corrections and public additions')
check.call(data['talks'].map { |p| p['citation'] } == baseline['citations']['talks'], 'Original invited talks lost')
check.call(audit['book_updates'].map { |op| op['before']['citation'] } == baseline['citations']['books'], 'Chapter audit does not preserve originals')
check.call(data['books'] == audit['book_updates'].map { |op| op['after'] }, 'Chapter corrections differ from audit')
patent_ops = audit.fetch('patent_updates')
legacy_patents = patent_ops.flat_map { |op| op['legacy_records'] }.sort_by { |op| op['index'] }
check.call(legacy_patents.map { |op| op['index'] } == (1..29).to_a, 'An original patent entry was omitted from the audit')
check.call(legacy_patents.map { |op| op['record']['citation'] } == baseline['citations']['patents'], 'Patent audit does not preserve original entries')
check.call(data['patents'].sort_by { |p| p['id'] } == (patent_ops.map { |op| op['after'] } + additions.select { |op| op['collection'] == 'patents' }.map { |op| op['after'] }).sort_by { |p| p['id'] }, 'Patents differ from document-backed corrections')
check.call(data['patents'].map { |p| [p['jurisdiction'], p['application_number']] }.uniq.size == data['patents'].size, 'Duplicate patent application')
check.call(data['patents'].count { |p| p['jurisdiction'] == 'CN' } == 26 && data['patents'].count { |p| p['jurisdiction'] == 'US' } == 6, 'Patent jurisdiction counts differ')
['preprints', 'conference_programs'].each do |kind|
  expected = (audit['new_records'] + additions).select { |op| op['collection'] == kind }.map { |op| op['after'] }
  if kind == 'conference_programs'
    confirmations.fetch('program_updates').each do |op|
      index = expected.index { |p| p['id'] == op['before']['id'] }
      check.call(index && expected[index] == op['before'], 'Program confirmation lacks preserved prior record')
      expected[index] = op['after'] if index
    end
  end
  check.call(data[kind].sort_by { |p| p['id'] } == expected.sort_by { |p| p['id'] }, "#{kind} differ from documented public records")
end
expected_applications = additions.select { |op| op['collection'] == 'patent_applications' }.map { |op| op['after'] }
check.call(data['patent_applications'] == expected_applications, 'Public applications differ from document-backed additions')
check.call(data['patent_applications'].all? { |p| p['status'] == 'application-publication' && p['publication_number'].end_with?('A1') && !p.key?('grant_date') }, 'Application publication conflated with grant')
check.call((data['patents'] + data['patent_applications']).map { |p| [p['jurisdiction'], p['application_number']] }.uniq.size == 36, 'Application duplicated across grant and application sections')
additions.select { |op| ['patents', 'patent_applications'].include?(op['collection']) }.each do |op|
  pn = op['after']['grant_publication'] || op['after']['publication_number']
  file = File.join(ROOT, '.local/research-scholar-20261019/patents', pn + '.pdf')
  check.call(op['evidence']['pdf_sha256'].match?(/\A[0-9a-f]{64}\z/), "Missing patent evidence hash: #{pn}")
  check.call(Digest::SHA256.file(file).hexdigest == op['evidence']['pdf_sha256'], "Patent evidence changed: #{pn}") if File.file?(file)
end
data['publications'].each do |paper|
  if paper['doi']
    check.call(paper['url'] == "https://doi.org/#{paper['doi']}", "Missing canonical DOI link: #{paper['id']}")
  else
    evidence = additions.find { |op| op['collection'] == 'publications' && op['after']['id'] == paper['id'] }&.fetch('evidence', nil)
    check.call(evidence && evidence['pdf_url'] == paper['url'] && evidence['pdf_sha256'].match?(/\A[0-9a-f]{64}\z/), "Missing primary proceedings evidence: #{paper['id']}")
    file = File.join(ROOT, '.local/research-scholar-20261019/crossref-resume/sispad2012.pdf')
    check.call(Digest::SHA256.file(file).hexdigest == evidence['pdf_sha256'], 'Primary SISPAD2012 evidence changed') if evidence && File.file?(file)
  end
  check.call(paper['authors'].include?('Peng Huang') && !paper['venue'].empty?, "Missing verified author/venue: #{paper['id']}")
  check.call(['published', 'early-access'].include?(paper['status']), "Preprint or program mixed into published papers: #{paper['id']}")
  check.call(paper['publication_date'] <= resume['cutoff'], "Future publication: #{paper['id']}")
end
paper_dois = data['publications'].filter_map { |p| p['doi'] }
check.call(paper_dois.uniq.size == paper_dois.size, 'Duplicate paper DOI')
check.call(data['preprints'].all? { |p| p['status'] == 'preprint' && p['citation'].include?('not peer reviewed') }, 'Preprint status missing')
selection = YAML.load_file(File.join(ROOT, '_data/publication_selection.yml')).fetch('included_ids')
review = JSON.parse(File.read(File.join(ROOT, 'docs/publications-review.json')))
check.call(system(RbConfig.ruby, File.join(ROOT, 'scripts/select_publications.rb')), 'Publication selection audit is stale')
check.call(review['records'].size == 193 && selection.size == 100, 'Approved publication scope differs')
check.call(review['records'].select { |r| r['original_site'] }.all? { |r| r['included'] }, 'An original-site paper was excluded')
check.call(['paper-51', 'paper-54', 'paper-55'].all? { |id| selection.include?(id) }, 'Confirmed first-author papers missing')
papers = data.fetch('publications').select { |p| selection.include?(p['id']) }
check.call(papers.map { |p| p['id'] }.uniq.size == papers.size, 'Duplicate publication IDs')
check.call(papers.map { |p| p['url'] }.uniq.size == papers.size, 'Duplicate publication URLs')
normal = lambda { |text| text.gsub(/\s+/, ' ').strip }
html_files = Dir.glob(File.join(SITE, '**/*.html'))
check.call(!html_files.empty?, 'Build output missing')
routes = ['', 'publications', 'people', 'courses', 'service', 'chips', 'software']
routes.each { |route| check.call(File.file?(File.join(SITE, route, 'index.html')), "Missing route /#{route}/") }
if File.file?(File.join(SITE, 'publications/index.html'))
  pubs = Nokogiri::HTML(File.read(File.join(SITE, 'publications/index.html')))
  items = pubs.css('.publication-item')
  check.call(items.size == papers.size, 'Rendered publication count differs')
  check.call(items.map { |node| node['data-paper-id'] }.sort == selection.sort, 'Rendered IDs differ from approved selection')
  check.call(pubs.css('[data-corresponding], [data-first-author], .author-role, .corresponding-label').empty?, 'Identity labels must not be displayed')
  check.call(pubs.css('#preprints').empty?, 'Unreviewed preprints should remain source-only')
  expected = papers.map { |p| normal.call(Nokogiri::HTML.fragment(Kramdown::Document.new(p['citation'], input: 'GFM').to_html).text) }
  actual = items.map { |item| normal.call(item.text) }
  check.call(expected.sort == actual.sort, 'Rendered citations differ from source data')
  papers.each do |paper|
    item = pubs.at_css("[data-paper-id='#{paper['id']}']")
    check.call(item && item['data-year'].to_i == (paper['group_year'] || paper['year']), "Wrong confirmed year group: #{paper['id']}")
  end
  check.call(pubs.at_css('.publications-toolbar')&.key?('hidden'), 'Search controls should stay hidden without JavaScript')
  check.call(items.none? { |item| item.key?('hidden') }, 'Publications hidden before JavaScript')
  full_text = normal.call(pubs.text)
  ['conference_programs', 'talks', 'books', 'patents', 'patent_applications'].each do |kind|
    data[kind].each do |item|
      expected_text = normal.call(Nokogiri::HTML.fragment(Kramdown::Document.new(item['citation'], input: 'GFM').to_html).text)
      check.call(full_text.include?(expected_text), "Missing rendered #{kind} citation")
    end
  end
end
if File.file?(File.join(SITE, 'index.html'))
  home = Nokogiri::HTML(File.read(File.join(SITE, 'index.html')))
  check.call(home.css('h1').size == 1, 'Homepage needs one main heading')
  check.call(home.css('.news-list li').size == 16, 'Historical news lost')
  check.call(home.css('.group-gallery__slide').size == 4, 'Group photograph lost')
  check.call(home.css('.group-gallery__slide[hidden]').empty?, 'Photographs hidden before JavaScript')
end
if File.file?(File.join(SITE, 'people/index.html'))
  people = Nokogiri::HTML(File.read(File.join(SITE, 'people/index.html')))
  member_baseline = JSON.parse(File.read(File.join(ROOT, 'docs/people-baseline.json')))
  expected_members = Marshal.load(Marshal.dump(member_baseline))
  member_updates = JSON.parse(File.read(File.join(ROOT, 'docs/people-updates-202609.json')))
  member_updates['updates'].each do |update|
    person = expected_members['people'].find { |item| item['name'] == update['name'] }
    check.call(person && update['before'].all? { |key, value| person[key] == value }, "Member update does not match baseline: #{update['name']}")
    person&.merge!(update['after'])
  end
  member_updates.fetch('additions', []).each do |person|
    check.call(expected_members['people'].none? { |item| item['name'] == person['name'] }, "Duplicate member addition: #{person['name']}")
    expected_members['people'] << person
  end
  member_updates.fetch('graduations', []).each do |update|
    person = expected_members['people'].find { |item| item['name'] == update['name'] }
    check.call(person == update['before'], "Graduation update does not match prior member: #{update['name']}")
    expected_members['people'].delete(person)
    alumnus = expected_members['alumni'].find { |item| item['name'] == update['name'] }
    check.call(alumnus == update['alumni_before'], "Graduate merge does not match prior record: #{update['name']}")
    if alumnus
      expected_members['alumni'][expected_members['alumni'].index(alumnus)] = update['alumni_after']
    else
      expected_members['alumni'] << update['alumni_after']
    end
  end
  latest_updates = JSON.parse(File.read(File.join(ROOT, 'docs/people-updates-20261018.json')))
  latest_updates['operations'].each do |op|
    case op['kind']
    when 'update'
      list = expected_members.fetch(op['collection'])
      old = list.find { |item| item['name'] == op['name'] }
      check.call(old == op['before'], "Latest update does not match prior record: #{op['name']}")
      list[list.index(old)] = op['after'] if old
    when 'move'
      old = expected_members.fetch(op['from']).find { |item| item['name'] == op['name'] }
      check.call(old == op['before'], "Student status change lacks prior record: #{op['name']}")
      expected_members.fetch(op['from']).delete(old)
      expected_members.fetch(op['to']) << op['after']
    when 'add'
      all_names = (expected_members['people'] + expected_members['alumni']).map { |p| p['name'] }
      check.call(!all_names.include?(op['after']['name']), "Duplicate newly added member: #{op['after']['name']}")
      expected_members.fetch(op['collection']) << op['after']
    when 'exclude'
      old = expected_members.fetch(op['collection']).find { |item| item['name'] == op['before']['name'] }
      check.call(old == op['before'], 'Explicit exclusion lacks preserved prior record')
      expected_members.fetch(op['collection']).delete(old)
    end
  end
  ['people', 'alumni'].each do |kind|
    expected_members[kind].sort_by! { |person| latest_updates.fetch(kind == 'people' ? 'people_order' : 'alumni_order').index(person['name']) }
  end
  member_data = YAML.load_file(File.join(ROOT, '_data/people.yml'))
  check.call(member_data == expected_members, 'Member data differs from frozen baseline plus user-confirmed updates')
  check.call(people.css('[data-member]').size == 29, 'Current student count differs from confirmed 29')
  check.call(people.css('[data-alumnus]').size == 16, 'Alumni count differs from confirmed 16')
  names = (member_data['people'] + member_data['alumni']).map { |p| p['name'] }
  check.call(names.uniq.size == names.size, 'Student appears in more than one current status')
  member_baseline['people'].each do |person|
    preserved = (member_data['people'] + member_data['alumni']).find { |p| p['name'] == person['name'] }
    check.call(preserved && preserved['img'] == person['img'] && File.file?(File.join(ROOT, person['img'])), "Original portrait association lost: #{person['name']}")
  end
  expected_members['people'].each do |person|
    card = people.css('[data-member]').find { |node| node['data-member'] == person['name'] }
    check.call(!card.nil?, "Missing student #{person['name']}")
    next unless card
    ['research', 'coadvisor', 'since', 'study_year'].each do |field|
      value = person[field]
      check.call(card.text.include?(value.to_s), "Missing #{field} for #{person['name']}") if value && value != ''
    end
    section = card.ancestors.find { |node| node['class'] == 'people-section' }
    check.call(section&.text&.include?(person['degree']), "Wrong degree for #{person['name']}")
    if person['img']
      check.call(!card.at_css('img').nil?, "Missing original portrait for #{person['name']}")
    else
      check.call(card.css('img').empty?, "Invented portrait for #{person['name']}")
    end
  end
  [['phd-students',18], ['master-students',7], ['undergraduate-students',4]].each do |id,count|
    check.call(people.css("##{id} [data-member]").size == count, "Wrong #{id} count")
  end
  check.call(people.css('#graduate-students').empty?, 'Unspecified degree category should be empty after confirmation')
  expected_members['alumni'].each do |person|
    row = people.css('[data-alumnus]').find { |node| node['data-alumnus'] == person['name'] }
    check.call(!row.nil?, "Missing alumnus #{person['name']}")
    next unless row
    expected_text = [person['name'],person['destination']].compact.join(' ')
    check.call(row.text.gsub(/\s+/, '') == expected_text.gsub(/\s+/, ''), "Alumni row must contain only name and destination: #{person['name']}")
    check.call(row.ancestors.any? { |node| node['data-graduation-year'] == person['graduation_year'].to_s }, "Wrong graduation year for #{person['name']}")
  end
  check.call(!people.text.include?('Zheng Zhou') && !people.text.include?('秦雄昊'), 'Explicitly excluded team member remains visible')
  check.call(people.at_css('.people-scope').text.include?('Yulin Feng') && !people.css('[data-alumnus="Yulin Feng"]').empty?, 'Confirmed dual faculty/alumni role lost')
  media = latest_updates.fetch('followup_media')
  check.call(Digest::SHA256.file(File.join(ROOT, media['file'])).hexdigest == media['sha256'], 'Supplied portrait bytes changed')
  haorun_image = people.at_css('[data-member="Haorun Lv"] img')
  check.call(haorun_image && haorun_image['src'].end_with?('/images/people/31_LvHaorun.jpg') && !haorun_image.key?('srcset'), 'Supplied Haorun Lv portrait missing or references nonexistent derivatives')
  blank_destinations = member_data['alumni'].select { |p| !p['destination'] }.map { |p| p['name'] }.sort
  check.call(blank_destinations.empty?, 'All 16 confirmed alumni destinations should now be filled')
  {'Hairuo Lu' => 'Joined China Mobile Research Institute', 'Haokai Guan' => 'Joined YMTC in Shanghai (Digital IC Design)'}.each do |name, destination|
    person = member_data['alumni'].find { |p| p['name'] == name }
    check.call(person && person['destination'] == destination, "New destination differs from user-supplied details: #{name}")
  end
  latest_updates.fetch('followup_media_batch').each do |portrait|
    check.call(Digest::SHA256.file(File.join(ROOT, portrait['file'])).hexdigest == portrait['sha256'], "Supplied portrait bytes changed: #{portrait['person']}")
    photo = people.at_css(%Q([data-member="#{portrait['person']}"] img))
    check.call(photo && photo['src'].end_with?('/' + portrait['file']) && !photo.key?('srcset'), "New portrait missing or invalid derivatives: #{portrait['person']}")
  end
  check.call(member_data['people'].select { |p| !p['img'] }.map { |p| p['name'] } == ['Siyuan Liu'], 'Remaining photo gap differs from supplied seven portraits')
  check.call(people.css('#undergraduate-students [data-member]').map { |node| node['data-member'] }.sort == ['Lingxi Jin', 'Zhuoting Han', 'Siyuan Liu', 'Ziqi Wang'].sort, 'Authorized undergraduate pinyin names differ')

end
software = Nokogiri::HTML(File.read(File.join(SITE, 'software/index.html')))
check.call(software.at_css('.software-reference')&.text&.include?('CoMN:'), 'Missing CoMN reference')
check.call(software.css('a[href^="mailto:"]').size >= 3, 'Software contacts lost')
routes.drop(1).each do |route|
  doc = Nokogiri::HTML(File.read(File.join(SITE, route, 'index.html')))
  check.call(doc.css('main.academic-page h1').size == 1, "Section layout missing /#{route}/")
end
# Resolve internal HTML and stylesheet references, including responsive images and fragment IDs.
local_target = lambda do |value, from|
  return nil if value.nil? || value.empty? || value.start_with?('mailto:', 'tel:', 'data:', 'javascript:', '//')
  uri = URI.parse(value)
  return nil if uri.host && !['nickhwang132.github.io', '127.0.0.1', 'localhost'].include?(uri.host)
  pathname = URI::DEFAULT_PARSER.unescape(uri.path.to_s)
  target = if pathname.empty?
    from
  elsif pathname.start_with?('/')
    File.join(SITE, pathname.delete_prefix('/'))
  else
    File.expand_path(pathname, File.dirname(from))
  end
  target = File.join(target, 'index.html') if File.directory?(target) || pathname.end_with?('/')
  [target, uri.fragment]
rescue URI::InvalidURIError
  errors << "Invalid URL #{value.inspect} in #{from.delete_prefix(ROOT + '/')}"
  nil
end
html_files.each do |file|
  doc = Nokogiri::HTML(File.read(file))
  check.call(!doc.at_css('html head').nil? && !doc.at_css('body .academic-header').nil?, "Missing page layout in #{file.delete_prefix(SITE)}") unless doc.at_css('meta[http-equiv=refresh]')
  ids = doc.css('[id]').map { |node| node['id'] }
  check.call(ids.uniq.size == ids.size, "Duplicate element ID in #{file.delete_prefix(SITE)}")
  refs = doc.css('a[href], link[href], img[src], script[src], source[src]').map { |node| node['href'] || node['src'] }
  doc.css('[srcset]').each { |node| refs.concat(node['srcset'].split(',').map { |entry| entry.strip.split.first }) }
  refs.each do |value|
    pair = local_target.call(value, file)
    next unless pair
    target, fragment = pair
    check.call(File.file?(target), "Missing target #{value} in #{file.delete_prefix(SITE)}")
    if fragment && File.file?(target) && File.extname(target) == '.html'
      target_doc = target == file ? doc : Nokogiri::HTML(File.read(target))
      check.call(target_doc.css('[id]').any? { |node| node['id'] == fragment }, "Missing anchor #{value} in #{file.delete_prefix(SITE)}")
    end
  end
end
Dir.glob(File.join(SITE, '**/*.css')).each do |file|
  File.read(file).scan(/url\(\s*['"]?([^)'"\s]+)['"]?\s*\)/).flatten.each do |value|
    pair = local_target.call(value, file)
    check.call(File.file?(pair[0]), "Missing CSS target #{value}") if pair
  end
end
['archive', 'markdown_generator', 'scripts', 'docs', 'HANDOFF.md', 'README.md', 'Gemfile.lock', '.bundle', '.local', 'vendor'].each do |path|
  check.call(!File.exist?(File.join(SITE, path)), "Private or maintenance files published: #{path}")
end
public_text = html_files.map { |file| Nokogiri::HTML(File.read(file)).text }.join(' ')
audit['candidates'].reject { |candidate| candidate['included'] }.each do |candidate|
  check.call(!normal.call(public_text).include?(candidate['title_as_written']), 'Unverified source-only publication candidate leaked into public pages')
end
check.call(!public_text.include?(audit['withheld_public_record']['title']), 'Preprint with unverified byline leaked into public pages')
check.call(Dir.glob(File.join(SITE, '**/*')).none? { |file| File.basename(file).include?('2025-2026学年总结') }, 'Internal source PDF leaked into published output')
html_files.each do |file|
  check.call(!File.read(file).match?(%r{/Users/|/private/tmp/|127\.0\.0\.1:4173}), "Local information in production output #{file.delete_prefix(SITE)}")
end
result = { checks: checks, errors: errors.uniq, pages: html_files.size, baseline_counts: baseline['counts'] }
Dir.mkdir(File.join(ROOT, '.local')) unless Dir.exist?(File.join(ROOT, '.local'))
File.write(File.join(ROOT, '.local/verification.json'), JSON.pretty_generate(result) + "\n")
puts JSON.pretty_generate(result)
exit(errors.empty? ? 0 : 1)
