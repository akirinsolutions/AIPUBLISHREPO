#!/bin/bash
# publish-gh.sh — one-shot: create GitHub repo + push this bundle + enable Pages.
# Usage: GITHUB_TOKEN=ghp_xxx GITHUB_USER=name ./publish-gh.sh [repo-name]
set -euo pipefail
TOKEN="${GITHUB_TOKEN:-}"; USER="${GITHUB_USER:-}"; REPO="${1:-hk-demos}"
if [ -z "$TOKEN" ] || [ -z "$USER" ]; then
  echo "Need GITHUB_TOKEN + GITHUB_USER. Create a fine-grained PAT (Contents: Read&Write)"
  echo "at https://github.com/settings/tokens , then run with them set. Nothing was done."
  exit 1
fi
cd "$(dirname "$0")"
echo "→ creating repo $REPO (409 = exists, continuing)"
curl -sf -X POST https://api.github.com/user/repos \
  -H "Authorization: Bearer $TOKEN" -H "Accept: application/vnd.github+json" \
  -d "{\"name\":\"$REPO\",\"public\":true,\"description\":\"HK Website-in-a-Box demo previews (unofficial)\"}" >/dev/null || echo "  repo exists or created"
[ -d .git ] || { git init -q; git checkout -qb main; git add -A; git commit -qm "23 demo sites, ready to publish"; }
echo "→ pushing"
git push -q "https://$USER:$TOKEN@github.com/$USER/$REPO.git" HEAD:main --force
echo "→ enabling Pages"
curl -sf -X POST "https://api.github.com/repos/$USER/$REPO/pages" \
  -H "Authorization: Bearer $TOKEN" -H "Accept: application/vnd.github+json" \
  -d '{"source":{"type":"branch","branch":"main","path":"/"}}' >/dev/null || echo "  Pages may already be on"
echo "→ waiting for build"
for i in $(seq 1 30); do
  sleep 10
  CODE=$(curl -s -o /dev/null -w "%{http_code}" "https://$USER.github.io/$REPO/")
  [ "$CODE" = "200" ] && { echo "LIVE: https://$USER.github.io/$REPO/"; exit 0; }
done
echo "Pages not answering after 5min — check https://github.com/$USER/$REPO/settings/pages"
exit 1
