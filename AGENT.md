# AGENT.md — S. Praevis Content Agents (Root)

Purpose: single entrypoint for all agents. Always start here.

## Minimal Load Order (token‑efficient)
1) Read TLDR: guides/style/TLDR.md
2) Load machine index: guides/style/INDEX.json
3) Select sections by task:
   - blog_post → [core, template, examples]
   - twitter → [twitter]
   - telegram → [telegram]

## Global Invariants (must hold)
- Short, anti‑noise, Bayesian updates
- 1–3 lines per block; 3–6 blocks per blog post
- Conclusion last; calm, precise, honest
- No metaphors, promotion, or performative tone

## Blog Post Skeleton
Headings: Observation → Update → Reasoning → Next  
Sign at the end: “— S. Praevis”

## Pre‑flight Checklist
- One thought per block?
- Noise removed?
- Probability change or rationale stated?

## Post‑flight Checklist
- Beliefs updated (or explicitly unchanged)?
- No emotional/promo wording?
- Conclusion is last?

Do not load entire guides unless explicitly requested.

---

# How to add a new blog post and deploy (step‑by‑step)

Prereqs
- Tools: hugo (extended), wrangler (logged in), git configured.
- Policies for this project:
  - Always publish in two languages with identical slug: EN at `content/posts/<slug>.md` and RU at `content/posts/<slug>.ru.md`.
  - Tags are English‑only, even in RU posts (e.g., `forecasting, markets, btc`).
  - Build locally without `--minify` (HTML minifier can break JSON‑LD).

1) Pick a slug and create files
- Slug: short latin kebab‑case (example: `why-forecasting-stocks-is-hard`).
- Create EN file:
  ```md
  ---
  title: "<English title>"
  date: YYYY-MM-DD
  tags: ["forecasting", "markets"]
  draft: false
  ---
  <English content>
  ```
- Create RU file (same slug, RU title, same date, same tags in English):
  ```md
  ---
  title: "<Русский заголовок>"
  date: YYYY-MM-DD
  tags: ["forecasting", "markets"]
  draft: false
  ---
  <Русский текст>
  ```

2) Commit the content
```bash
git add content/posts/<slug>.md content/posts/<slug>.ru.md
git commit -m "Add post: <Title> (EN/RU, YYYY-MM-DD)"
```

3) Build the site locally (no minify)
```bash
hugo
```

4) Deploy to Cloudflare Pages via wrangler
```bash
wrangler pages deploy public \
  --project-name praevis-blog \
  --branch main \
  --commit-message "Add post: <Title> (EN/RU)"
```
Wrangler will print a deployment URL like `https://<id>.praevis-blog.pages.dev`.

Optional: push to GitHub
```bash
git push origin main
```

Troubleshooting
- Deployment warns about "uncommitted changes": OK (we deploy built `public/`).
- If build fails due to minification: ensure you ran plain `hugo` (no `--minify`).
- Tags look inconsistent: in RU posts ensure tags remain English and that templates render post tags via PaperMod footer.

---

# Author Style & Voice (explicit)
- Voice: calm, precise, non‑promotional; show reasoning, not authority.
- Blocks: 1 idea per block, 1–3 lines; whole post 3–6 blocks + “Conclusion/Вывод”.
- Probabilities: state ranges or point estimates when relevant; avoid absolute claims.
- Avoid metaphors and rhetoric; prefer numbers, structure, and uncertainty notes.
- Sign at end: `— S. Praevis` (both EN/RU).
- Bilingual policy: always publish EN and RU versions with identical slug; tags stay in English in both.

---

# Forecasts — Publishing Playbook (EN/RU)

Overview
- Location: `content/forecasts/<slug>.md` (EN) and `content/forecasts/<slug>.ru.md` (RU).
- Use archetype: `hugo new -k forecasts forecasts/<slug>.md` then duplicate/translate to `.ru.md`.
- Tags: English only (e.g., `polymarket, forecast, btc`).

Front matter blueprint (mirror EN/RU)
```yaml
title: "…"
date: YYYY-MM-DD
status: open | resolved | canceled
position: yes | no | long | short | null
entry_prob: 0.65            # 0..1
forecast_prob: "0.70–0.75"  # number or range
market: { provider: "Polymarket", url: "…", market_id: "…" }
close_date: YYYY-MM-DD
resolution_criteria: "…"
stake: ""                  # optional
result: true | false | null # set on resolve
resolved_at: YYYY-MM-DD     # set on resolve
brier: 0.0                  # set on resolve
updates: [ { date: YYYY-MM-DD, note: "Opened No @65%", market_prob: "…" } ]
tags: ["polymarket", "forecast", "btc"]
draft: false
```

Body structure
- Market question (1–2 lines)
- Context & data snapshot (key stats)
- Analysis (structure, risks, scenarios)
- Position & rationale (why; probability)
- Monitoring plan (what would change your mind)
- Post‑mortem (add after resolution)

Lifecycle & operations
1) Create
```bash
hugo new -k forecasts forecasts/<slug>.md
cp content/forecasts/<slug>.md content/forecasts/<slug>.ru.md  # translate title/content
git add content/forecasts/<slug>.* && git commit -m "forecast: add <slug> (EN/RU)"
hugo && wrangler pages deploy public --project-name praevis-blog --branch main --commit-message "forecast: add <slug>"
```
2) Update while open (new note or probability)
```bash
# edit updates[] and/or forecast_prob
git commit -am "forecast: update <slug>: <short note>"
hugo && wrangler pages deploy public --project-name praevis-blog --branch main --commit-message "forecast: update <slug>"
```
3) Resolve and score
```bash
# set: status=resolved, result=true|false, resolved_at=YYYY-MM-DD
# compute Brier: (p - o)^2 where p is your probability (use entry_prob or final forecast_prob midpoint), o∈{0,1}
# set brier to the computed value, add Post‑mortem paragraph
git commit -am "forecast: resolve <slug> (result=<yes|no>, brier=…)"
hugo && wrangler pages deploy public --project-name praevis-blog --branch main --commit-message "forecast: resolve <slug>"
```

Linking posts ↔ forecasts
- In forecasts, link to the detailed blog post via `relref`.
- In blog posts, link back to the live forecast page.

Style for forecasts
- Keep the header concise; use the meta line (date · position · @p · range · close · provider).
- In body, prefer short sections with concrete stats; avoid narrative.
- Record every material change in `updates[]` with a date and a short note.
