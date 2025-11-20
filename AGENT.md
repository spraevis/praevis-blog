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
