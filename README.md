# hk-demos — 23 bilingual preview sites, ready to publish

This folder IS the deployable site (static, portable, relative paths — no build step server-side).
- `/` = clickable catalog of all 23 demos
- `/<slug>/` = one business's preview site
- `.nojekyll` present (GitHub Pages: skips Jekyll processing)

## Option 1 — GitHub Pages (needs: free GitHub account + fine-grained PAT with Contents:Write)
```bash
GITHUB_TOKEN=<paste PAT> GITHUB_USER=<your gh username> ./publish-gh.sh
```
Done in ~2 minutes: creates repo `hk-demos` (public), pushes, enables Pages, prints the live URL.
URLs: `https://<user>.github.io/hk-demos/<slug>/`

## Option 2 — Netlify Drop (needs: any free Netlify account; fastest)
Zip this folder, drag the zip onto https://app.netlify.com/drop → live URL in ~60s, no git.
(Verified 2026-09-13: the keyless/anonymous deploy API returns 401 — a free account is required.)

## Option 3 — Cloudflare Pages (needs free CF account + API token)
Dashboard → Workers & Pages → Create → Pages → upload this folder as a direct upload.

## Before any PAID delivery (not needed for demos)
- Flip `demo:false` in that client's `content` build → removes the "unofficial preview" note.
- Move the site to its own repo/subdomain + a .com.hk domain + claim their Google Business Profile.
- Verify flagged facts first (see SITE-LINKS.md ⚠️ column).

## What changed vs the local viewer build
- La Forme Beauty Salon REMOVED (its record says permanently closed — do not send).
- Each page footer states it is an unofficial preview (honesty + reduces any "fake official site" risk).
- CJK folder names replaced with ASCII slugs (host-safe URLs).
