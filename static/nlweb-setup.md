# NLWeb AI Search Integration — Setup Guide

This file contains all code-side changes needed for the Cloudflare NLWeb AI Search
widget on praevis.blog. The Cloudflare dashboard steps must be completed first;
the code changes come after you have a worker URL.

---

## Part 1 — Cloudflare Dashboard Steps (manual)

Complete these in order before touching any code.

### 1. Enable R2

R2 is required for NLWeb to store the site index.

1. Open Cloudflare Dashboard → your account.
2. Navigate to **R2 Object Storage** in the left sidebar.
3. If not already enabled, click **Enable R2** and confirm billing consent.

### 2. Create the NLWeb Website

1. Navigate to **AI** → **AI Search** in the Cloudflare Dashboard.
2. Click **Create NLWeb Website**.
3. Fill in:
   - **Website URL**: `https://praevis.blog`
   - **Sitemap URL**: `https://praevis.blog/sitemap.xml`
   - **Name**: `praevis-blog` (or any identifier you prefer)
4. Click **Create**. Cloudflare will begin crawling and indexing the site.
5. Wait for indexing to complete. With ~30 pages this typically takes 5–15 minutes.
   The dashboard will show a page count when done.

### 3. Note the Worker URL

After creation, Cloudflare provisions a Worker that serves the chat API. Find it:

1. Navigate to **Workers & Pages** → **Overview**.
2. Look for a worker named something like `nlweb-praevis-blog` or similar.
3. Copy its URL — it will look like:
   `https://nlweb-praevis-blog.<your-subdomain>.workers.dev`
4. You will paste this URL into the HTML snippet in Part 2 below.

### 4. Enable AI Gateway Rate Limiting

This prevents runaway API costs from the underlying AI model calls.

1. Navigate to **AI** → **AI Gateway**.
2. Select the gateway that was auto-created for your NLWeb website (or create one
   manually and link it to the NLWeb worker).
3. Under **Rate Limits**, set:
   - **Requests per minute**: `50`
   - **Scope**: per IP or global, depending on preference
4. Save.

---

## Part 2 — Code Changes (apply after you have the worker URL)

### 2a. Add the NLWeb widget script to footer.html

File: `layouts/partials/footer.html`

Add the following block immediately before the closing `</footer>` tag
(i.e., after line 26, before `</footer>`).

Replace `YOUR_WORKER_URL_HERE` with the worker URL from Step 3 above.

```html
<!-- NLWeb AI Search widget -->
<script
  src="https://unpkg.com/@cloudflare/nlweb-embed@latest/dist/nlweb-embed.js"
  data-worker-url="YOUR_WORKER_URL_HERE"
  data-site-name="Praevis"
  data-placeholder="Ask about forecasts…"
  data-theme="custom"
  defer
></script>
```

The resulting footer.html should look like this:

```html
<footer class="footer">
  <div class="footer-inner">
    {{- $icons := site.Params.socialIcons -}}
    {{- if $icons }}
    <nav class="footer-social" aria-label="Social links">
      {{- range $icons }}
      {{- $name := .name | lower -}}
      <a class="social" href="{{ .url }}" target="_blank" rel="nofollow noopener noreferrer" title="{{ $name }}">
        {{- if or (eq $name "twitter") (eq $name "x") -}}
        <svg viewBox="0 0 24 24" width="22" height="22" aria-hidden="true" class="ico"><path fill="currentColor" d="M18.244 2H21l-6.56 7.49L22 22h-6.42l-5.02-6.54L4.6 22H2l7.02-8.01L2 2h6.58l4.62 6.08L18.244 2Zm-1.126 18.27h1.7L7.94 3.66H6.15l10.968 16.61Z"/></svg>
        {{- else if eq $name "telegram" -}}
        <svg viewBox="0 0 24 24" width="22" height="22" aria-hidden="true" class="ico"><path fill="currentColor" d="M9.04 15.32 8.8 19.9c.43 0 .62-.18.84-.4l2.02-1.94 4.18 3.06c.77.42 1.32.2 1.53-.7l2.77-12.99c.25-1.08-.41-1.5-1.16-1.24L3.32 9.78c-1.05.41-1.03 1-.18 1.27l4.97 1.55 11.54-7.27-10.61 9.99Z"/></svg>
        {{- else if eq $name "github" -}}
        <svg viewBox="0 0 24 24" width="22" height="22" aria-hidden="true" class="ico"><path fill="currentColor" d="M12 2a10 10 0 0 0-3.16 19.49c.5.09.68-.22.68-.48 0-.24-.01-.87-.01-1.71-2.78.6-3.37-1.17-3.37-1.17-.45-1.14-1.1-1.44-1.1-1.44-.9-.62.07-.61.07-.61 1 .07 1.53 1.03 1.53 1.03.89 1.52 2.34 1.08 2.91.83.09-.64.35-1.08.63-1.33-2.22-.25-4.56-1.11-4.56-4.95 0-1.09.39-1.98 1.03-2.68-.1-.25-.45-1.28.1-2.66 0 0 .84-.27 2.75 1.02A9.56 9.56 0 0 1 12 7.1c.85 0 1.71.12 2.51.34 1.9-1.29 2.74-1.02 2.74-1.02.56 1.38.21 2.41.1 2.66.64.7 1.03 1.59 1.03 2.68 0 3.85-2.34 4.7-4.57 4.95.36.31.68.92.68 1.85 0 1.34-.01 2.43-.01 2.76 0 .26.18.57.69.47A10 10 0 0 0 12 2Z"/></svg>
        {{- else if eq $name "email" -}}
        <svg viewBox="0 0 24 24" width="22" height="22" aria-hidden="true" class="ico"><path fill="currentColor" d="M20 4H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2V6a2 2 0 0 0-2-2Zm0 4.24-7.6 5.23a1 1 0 0 1-1.16 0L4 8.24V6l8 5.5L20 6v2.24Z"/></svg>
        {{- else -}}
        <span class="txt">{{ .name }}</span>
        {{- end }}
      </a>
      {{- end }}
    </nav>
    {{- end }}
    <div class="foot-info mono">© {{ now.Format "2006" }} {{ site.Title }}</div>
  </div>

  <!-- NLWeb AI Search widget -->
  <script
    src="https://unpkg.com/@cloudflare/nlweb-embed@latest/dist/nlweb-embed.js"
    data-worker-url="YOUR_WORKER_URL_HERE"
    data-site-name="Praevis"
    data-placeholder="Ask about forecasts…"
    data-theme="custom"
    defer
  ></script>
</footer>
```

### 2b. Add dark-theme CSS for the NLWeb widget

File: `assets/css/extended/custom.css`

Append the following block at the end of the file. These rules target the
custom elements and CSS custom properties exposed by the NLWeb embed script.

The FAB button uses the site accent gradient (violet → cyan). The chat panel
matches the dark background (#0D0D0D), border (#1D1D1D), and text (#F2F2F2)
already in use across the site.

```css
/* ─── NLWeb AI Search widget — dark theme ───────────────────────────────── */

/*
 * NLWeb exposes CSS custom properties on its host element.
 * Target the custom element name used by the embed script.
 * Adjust `nlweb-embed` if Cloudflare ships a different element name.
 */

nlweb-embed {
  /* FAB button */
  --nlweb-fab-bg: linear-gradient(135deg, var(--accent-1), var(--accent-2));
  --nlweb-fab-color: #061016;
  --nlweb-fab-size: 52px;
  --nlweb-fab-radius: 50%;
  --nlweb-fab-shadow: 0 4px 20px color-mix(in oklab, var(--accent-1) 30%, transparent),
                      0 0 0 1px rgba(255, 255, 255, 0.06) inset;

  /* Panel shell */
  --nlweb-panel-bg: #0D0D0D;
  --nlweb-panel-border: 1px solid #1D1D1D;
  --nlweb-panel-radius: 0.75rem;
  --nlweb-panel-shadow: 0 16px 48px rgba(0, 0, 0, 0.7),
                        0 0 0 1px rgba(255, 255, 255, 0.04) inset;
  --nlweb-panel-width: 360px;

  /* Header bar */
  --nlweb-header-bg: #111111;
  --nlweb-header-border: 1px solid #1D1D1D;
  --nlweb-header-color: #F2F2F2;
  --nlweb-header-font: Manrope, Inter, system-ui, sans-serif;

  /* Messages */
  --nlweb-msg-user-bg: #1a1a2e;
  --nlweb-msg-user-color: #F2F2F2;
  --nlweb-msg-user-border: 1px solid color-mix(in oklab, var(--accent-1) 25%, transparent);
  --nlweb-msg-bot-bg: #111111;
  --nlweb-msg-bot-color: #F2F2F2;
  --nlweb-msg-bot-border: 1px solid #1D1D1D;
  --nlweb-msg-font: Inter, system-ui, sans-serif;
  --nlweb-msg-font-size: 0.9rem;
  --nlweb-msg-line-height: 1.55;

  /* Links inside bot replies */
  --nlweb-link-color: #7DD3FC;

  /* Input area */
  --nlweb-input-bg: #111111;
  --nlweb-input-border: 1px solid #1D1D1D;
  --nlweb-input-color: #F2F2F2;
  --nlweb-input-placeholder-color: #606060;
  --nlweb-input-focus-border: 1px solid color-mix(in oklab, var(--accent-2) 50%, transparent);
  --nlweb-input-focus-shadow: 0 0 0 3px color-mix(in oklab, var(--accent-2) 12%, transparent);
  --nlweb-input-font: Inter, system-ui, sans-serif;
  --nlweb-input-font-size: 0.9rem;

  /* Send button */
  --nlweb-send-bg: linear-gradient(90deg, var(--accent-1), var(--accent-2));
  --nlweb-send-color: #061016;
  --nlweb-send-radius: 0.4rem;

  /* Source citation chips */
  --nlweb-source-bg: #111111;
  --nlweb-source-border: 1px solid #1D1D1D;
  --nlweb-source-color: #A8A8A8;
  --nlweb-source-hover-border: 1px solid #2A2A2A;
  --nlweb-source-font-size: 0.78rem;
  --nlweb-source-radius: 999px;

  /* Scrollbar (Webkit) */
  --nlweb-scrollbar-track: #111111;
  --nlweb-scrollbar-thumb: #2A2A2A;
  --nlweb-scrollbar-thumb-hover: #383838;

  /* Position: bottom-right, clear of footer */
  --nlweb-fab-bottom: 1.5rem;
  --nlweb-fab-right: 1.5rem;
}

/* Reduce FAB size on narrow viewports so it doesn't overlap content */
@media (max-width: 480px) {
  nlweb-embed {
    --nlweb-fab-size: 44px;
    --nlweb-fab-bottom: 1rem;
    --nlweb-fab-right: 1rem;
    --nlweb-panel-width: calc(100vw - 2rem);
  }
}
/* ─────────────────────────────────────────────────────────────────────────── */
```

---

## Part 3 — Verification Checklist

After applying both code changes and deploying:

- [ ] FAB button appears bottom-right with violet-to-cyan gradient.
- [ ] Clicking FAB opens the chat panel with dark (#0D0D0D) background.
- [ ] Typing a question returns a sourced answer with citations linking to
      praevis.blog posts.
- [ ] Links inside bot replies use the site link color (#7DD3FC).
- [ ] On mobile (< 480px) the FAB is 44px and the panel fills the viewport width.
- [ ] AI Gateway dashboard shows request counts (confirms routing through gateway).
- [ ] Exceeding 50 req/min triggers a 429 response (confirms rate limiting).

---

## Notes

- The `@cloudflare/nlweb-embed` package name is a placeholder. Verify the exact
  npm package name and CDN URL once Cloudflare publishes the official embed script.
  Check https://developers.cloudflare.com/ai-search/ for the current embed snippet.
- All CSS custom properties above are best-effort based on the typical NLWeb
  embed API. If the shipped widget uses different property names or a Shadow DOM
  without part selectors, the variables may need to be replaced with `::part()`
  selectors or a direct stylesheet injection approach.
- Do not commit this file to the repository after completing setup — it contains
  the placeholder `YOUR_WORKER_URL_HERE` which is easy to confuse with a real URL.
  Remove or archive it once the integration is live.
