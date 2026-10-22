# Peng Huang — academic website

Academic website for Prof. Peng Huang, School of Integrated Circuits, Peking University. The existing public address is <https://nickhwang132.github.io/>. The site uses Jekyll / Academic Pages and retains the established section URLs.

## Run and check

Ruby 3.3, GitHub Pages gem 232 and locked dependencies are recorded in `.ruby-version`, `Gemfile` and `Gemfile.lock`.

```sh
scripts/site setup
scripts/site build
scripts/site check
scripts/site serve
```

The preview is available at <http://127.0.0.1:4173/>. It rebuilds on startup; restart after source changes. On macOS the script uses Homebrew Ruby 3.3 when available, without changing global Ruby settings. CI validates pull requests and `master`; GitHub Pages publishes from `master` using the repository's existing Pages configuration.

## Publication review and selection

**Preserve the complete review, including excluded records.** The approved rule is that Peng Huang must be a corresponding author or the first listed author. Author identity labels are not displayed on the website. First author means the first author in the verified author list; equal contribution must be checked separately.

- [`docs/publications-review.json`](docs/publications-review.json) is the maintained review: all 193 formal records, original-site membership, formal publication year, author roles, evidence, original citations where available, inclusion decision and reason.
- [`docs/publications-review.md`](docs/publications-review.md) and [CSV](docs/publications-review.csv) provide readable review tables.
- `_data/publications.yml` retains all 193 formal records and the separate preprint, conference-program, talk, chapter and patent source collections.
- `_data/publication_selection.yml` contains the 100 reviewed IDs used by the website. The 93 excluded records remain in the bibliography and review. All 57 original-site records are included, including papers 51, 54 and 55 as first-author work.

After changing bibliographic information or a verified role, update the matching review record and its evidence, then regenerate and check:

```sh
ruby scripts/select_publications.rb --write
scripts/site build
scripts/site check
```

The audit's bibliography hash must be updated after an intentional bibliography edit. Never infer a negative role from a missing field, and never remove an excluded paper from the review just to make counts match. Keep the original-site baseline and prior source citations. Preprints remain source-only. By explicit user approval, MBA appears in the 2026 list alongside the 100 selected formal papers; its source remains an official DAC conference-program record and it is not added to the formal-publication count. `_data/publication_display.yml` records this display decision, and the search counter reports entries.

## Content sources

| Content | Source |
| --- | --- |
| Biography and research | `_pages/about.md` |
| Homepage paper highlights | `_data/home.yml` |
| All publication and patent source records | `_data/publications.yml` |
| Approved public paper selection | `_data/publication_selection.yml` |
| All formal publication review records | `docs/publications-review.json` |
| News and group photographs | `_data/updates.yml`, `_data/news.yml` |
| Faculty, students and alumni | `_data/people.yml` |
| Chip descriptions, designers and paper associations | `_data/chips.yml` |
| Chip photographs | `images/chips/<chip-id>/` |
| Recent content changes and image hashes | `docs/content-updates-20261020.json` |
| Chip intake provenance and public-scope confirmation | `docs/chips/intake-20261020.json` |
| Course introductions, topics and resources | `_data/courses.yml` |
| Course provenance and withheld-field policy | `docs/courses/content-review-20261022.md` |
| Software | `_pages/software.md` |
| Layout and styles | `_layouts/`, `_sass/` |

Invited talks, two book chapters, 32 granted-patent records and four US application publications retain their separate categories. This is not an exhaustive patent portfolio or a current legal-status claim. Chips now presents three supplied chip records, with related papers linked to the existing reviewed bibliography. Raw intake Word/EMF documents are archived outside the checkout; only selected website images are public assets. Courses presents three supplied courses, with English introductions, official Chinese titles, topics and expandable learning goals. Course numbers, credits and semester details remain in the intake review and are not rendered pending confirmation. Source Word files, teaching evaluations and grading records are kept outside the published site. Service has been removed from navigation and publication; its source remains archived as an unpublished page. The remaining student photo and research-field gaps are intentionally omitted.

Documentation, maintenance scripts, historical theme archives and local evidence are excluded from the published website. Local licensed full texts, raw source materials, machine-specific handoffs and original user files are not release assets. Keep recovery snapshots outside the checkout and restore into a separate directory.

## Typography and visual checks

The shared scale lives in `_sass/_academic.scss`: 17px body, 16px citation details, 15px metadata and 19px item titles. Georgia headings and the system sans-serif body keep the approved academic style. Mobile layouts change columns and wrapping before reducing type; the fixed seal stays at 1% opacity.

Follow [AGENTS.md](AGENTS.md) for the visitor-facing content and typography contract. The reusable [academic website maintenance skill](docs/skills/academic-website-maintenance/SKILL.md) includes a read-only browser probe. Check all six primary sections at 320, 390, 768 and 1280px, review desktop/mobile screenshots, and exercise search, Index, native details and gallery controls. Content preservation, successful builds and browser checks are separate evidence; retain each in the review and HANDOFF. Internal documents and skills remain excluded from the published site.

## Attribution

Based on [Academic Pages](https://github.com/academicpages/academicpages.github.io) and [Minimal Mistakes](https://mmistakes.github.io/minimal-mistakes/), under the existing MIT license. Peking University asset provenance is recorded in [`docs/asset-sources.md`](docs/asset-sources.md).
