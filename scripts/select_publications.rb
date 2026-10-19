# Keep the complete audit in Git; generate only the selection used by the site.
require 'json'
require 'yaml'
require 'digest'
require 'csv'

root = File.expand_path('..', __dir__)
review = JSON.parse(File.read(File.join(root, 'docs/publications-review.json')))
bibliography_path = File.join(root, '_data/publications.yml')
papers = YAML.load_file(bibliography_path).fetch('publications')
records = review.fetch('records')
abort 'Audit bibliography hash differs' unless Digest::SHA256.file(bibliography_path).hexdigest == review.fetch('bibliography_sha256')
abort 'Audit must contain exactly one record per paper' unless records.map { |r| r['paper']['id'] }.sort == papers.map { |p| p['id'] }.sort && records.map { |r| r['paper']['id'] }.uniq.size == papers.size
by_id = papers.to_h { |p| [p['id'], p] }
records.each do |row|
  id = row.fetch('paper').fetch('id')
  abort "Bibliography differs: #{id}" unless row['paper'] == by_id[id]
  flags = [row['peng_huang_corresponding'], row['peng_huang_first_author']]
  abort "Identity still unreviewed: #{id}" unless flags.all? { |value| [true, false].include?(value) }
  abort "First-author flag differs: #{id}" unless row['peng_huang_first_author'] == (row['paper']['authors'].first == 'Peng Huang')
  abort "Selection differs from approved rule: #{id}" unless row['included'] == flags.any?
end
selected = records.select { |row| row['included'] }
expected_counts = { 'reviewed' => records.size, 'included' => selected.size, 'excluded' => records.size - selected.size, 'original_site_retained' => selected.count { |row| row['original_site'] } }
abort 'Audit counts differ' unless review['counts'] == expected_counts
selection = { 'review_file' => 'docs/publications-review.json', 'reviewed_on' => review['reviewed_on'], 'included_ids' => selected.map { |row| row['paper']['id'] } }
selection_path = File.join(root, '_data/publication_selection.yml')
if ARGV == ['--write']
  File.write(selection_path, JSON.pretty_generate(selection) + "\n")
  md = "# Publication review\n\nThe repository preserves all #{records.size} reviewed formal publication records. The website includes #{selected.size} where Peng Huang is a corresponding author or the first listed author; #{records.size - selected.size} remain in the audit. All 57 original-site records are retained. Identity labels are not displayed on the website. Full source citations, legacy citations and evidence are in [publications-review.json](publications-review.json).\n\nReviewed: #{review['reviewed_on']}. First author means first listed author; equal contribution is not inferred from order.\n\n| ID | Year | Title | Original site | Peng Huang corresponding | Peng Huang first author | Include |\n| --- | ---: | --- | --- | --- | --- | --- |\n"
  csv = CSV.generate do |output|
    output << ['ID', 'Year', 'Title', 'Original site', 'Peng Huang corresponding', 'Peng Huang first author', 'Include', 'Reason', 'DOI', 'Evidence URL']
    records.each do |row|
      p = row['paper']
      yes = lambda { |value| value ? 'Yes' : 'No' }
      values = [p['id'], p['year'], p['title'], row['original_site'], row['peng_huang_corresponding'], row['peng_huang_first_author'], row['included']]
      md << "| #{values.map { |v| v == true || v == false ? yes.call(v) : v.to_s.gsub('|', '\\|') }.join(' | ')} |\n"
      output << values + [row['retention_reason'], p['doi'], row['correspondence_evidence']['source_url']]
    end
  end
  File.write(File.join(root, 'docs/publications-review.md'), md)
  File.write(File.join(root, 'docs/publications-review.csv'), "\uFEFF" + csv)
else
  abort 'Selection is stale; run scripts/select_publications.rb --write' unless File.file?(selection_path) && YAML.load_file(selection_path) == selection
end
puts JSON.generate(expected_counts)
