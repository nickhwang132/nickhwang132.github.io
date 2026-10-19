# Asset and content provenance

- Peking University logo: https://www.pku.edu.cn/Uploads/Picture/2019/12/26/s5e04176fbbfa3.png — referenced by the official homepage https://www.pku.edu.cn/ at capture on 2026-10-17. Copied unchanged to `images/identity/pku-alternate.png`; proportions and colors are preserved.
- Accent color `#94070A`: web color in the official VIS basic-system manual, https://www.pku.edu.cn/Uploads/Picture/2019/12/04/u5de7ad0c17491.pdf. This does not imply the site is an institutional portal.
- Portrait and all group photographs: pre-existing repository assets, retained unchanged. Responsive derivatives were already present among the original untracked assets.
- PH favicon: native SVG text/shape created for this preview; it is a personal monogram, not a university logo.
- Baseline publication source: `_pages/publications.md` at commit `e91e828ab1856bdd271f87c81fe1a454a00e74f8`. All 57 papers, 2 invited talks, 2 books/chapters and 29 patent records are preserved. Data migration and source preservation do not independently verify the external academic claims or current patent legal status.
- New data list previously contained 3 overlapping papers. Those entries were reconciled with the complete baseline rather than shown a second time.

## Content questions retained

1. The current title, biography, honors and recruiting availability need the maintainer's latest confirmation. Existing values are retained.
2. Shichao Zhong previously appeared in both current-member and alumni sections. The user explicitly confirmed he is an alumnus; the duplicate is merged. All 8 recently confirmed graduates await destination details; the prior Shanghai entry is preserved in the historical baseline and update ledger, not presented as newly confirmed.
3. Patent records 23 and 26 share normalized number `ZL201610648336.8` but give different dates. Both original records are preserved pending source reconciliation. No patent record was silently deleted.
4. The existing member list contains the placeholder `TBD` for Kaihuai Xie's research. This placeholder is suppressed in the visible listing; his name and photograph remain. The original record is retained in the source snapshot.
5. Courses, Service and Chips remain empty until actual approved content is supplied.

Legacy redirects `/md/` and `/markdown.html` were checked on the live site and point to `/software/`. The preview preserves that mapping and removes duplicate declarations from Chips and Service.

## Section migration, 2026-10-17

- All 24 member records and 12 alumni rows were parsed from the preserved table into `_data/people.yml`. Degree, admission year, co-advisor, research topic, photo and destination are preserved where present. The independent field baseline is `docs/people-baseline.json`; unknown fields stay absent. Original table source remains available for comparison.
- Software text was condensed around the project overview, three modules, code, installation guide, contacts and the existing publication citation. The full previous page is preserved in `docs/software-original.md` (excluded from site output). The bibliography entry comes from the existing publication data, rather than inferring updated author or page details.
- Official software reference checked: https://github.com/booniebears/CoMN and its `#get-started` README section. README currently labels the code V1.1; the website uses the unversioned project name to avoid implying a separately verified software release. No software installation or accelerator experiment was performed.
- A read-only request to the historical GUI URL returned an empty response (HTTP status unavailable) during this session. Its resource link remains in a collapsed disclosure, without a promise of current service availability. No account was created and no registration was submitted.
- All six secondary sections use `_layouts/academic.html`. Empty Courses, Service and Chips retain their URLs and share only the page heading, navigation and footer until genuine content is supplied. The unused old carousel style is no longer imported; original assets and historical source files are retained.

## User-supplied group introduction and confirmed changes

The 20-page PDF remains at its original Desktop path; its hash, relevant page numbers and source-to-website mapping are recorded in `docs/content-review-202609.json`. Pages 3-5 were visually inspected. The user approved all 9 additions and presentation of the joint group, and explicitly confirmed that 8 previous students have graduated. Current students total 25; alumni total 19 after merging Shichao Zhong. No graduation year or destination was invented. Unknown member photos are omitted; the 24 original portrait files and their member associations remain intact. Changes are recorded separately from the frozen baseline in `docs/people-updates-202609.json`.

Page 5 contains 8 named research outputs and counts for 6 other conference papers. These are maintained as private-to-the-build review candidates pending complete bibliographic and status evidence. Neither the source PDF, its internal policies, nor the candidate titles are included in generated pages. The user confirmed that the personal profile has no changes and explicitly deferred featured work and empty-section material.

## Superseding user-confirmed roster, 2026-10-18

The latest human confirmation supersedes the prior graduation assignments for Kefan Tao, Yonghao Jiao, Yang Song and Wenfu Hu; all four are 2024-entry current master students. Xiuqi Sui is also a 2024 master student. User-confirmed spellings are Yonghao Jiao and Yading Yi, with no duplicate identities created. Qin Xionghao and Zheng Zhou are excluded from the team page; Yulin Feng retains both faculty and alumnus roles by explicit confirmation. The roster now totals 29 current students (18 doctoral, 7 master, 4 undergraduate) and 16 alumni, including the newly supplied Haokai Guan. Alumni rows display only name and destination, grouped by user-supplied graduation year; prior metadata and old decisions remain in the frozen baseline and separate operation ledgers. No unsupported Chinese spelling was added. See `docs/people-review-20261018.json` for current fields and remaining gaps.

## Portrait, name and destination follow-up, 2026-10-18

- Haorun Lv: user-attached JPEG copied byte-for-byte to `images/people/31_LvHaorun.jpg`; SHA-256 `783eb50762cc1354f9bc8d3b001b825c6feaef06b1fc91d056b52d3abd53a65a`, 1280x1646, no EXIF. No crop, retouching or synthetic replacement. Original ~70 KiB asset is referenced directly without nonexistent responsive derivatives.
- Chinese names supplied by the user: 隋秀琦 (Xiuqi Sui), 管浩凯 (Haokai Guan). The user authorized direct pinyin for the four undergraduates: Lingxi Jin, Zhuoting Han, Siyuan Liu and Ziqi Wang. Original Chinese characters remain in each record.
- Shichao Zhong: old Git entry e91e828 and previous versions only say Shanghai Municipal People's Government. The user now specifies the Civil Affairs Bureau. Agency English wording was verified at https://english.shanghai.gov.cn/en-InnovationPolicies/20260629/a5299ae328074d50a633252b050f4016.html ; this validates the agency name, not an independent employment record.
- Yiyang Chen and Ruiqi Chen: user supplied Huawei Senior Researcher employment. Existing destination sentence style is used. No unverified Chinese characters were assigned to these two names.
