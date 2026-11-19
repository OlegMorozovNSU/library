#!/usr/bin/env bash
# Закоммитить и (если указан --push) отправить обновлённый экспорт библиотеки.
# Использование: scripts/commit-export.sh [--push]
# Можно запускать вручную или из cron после автоэкспорта Zotero.
set -euo pipefail
cd "$(dirname "$0")/.."

if git diff --quiet -- library.bib collections notes && [ -z "$(git ls-files --others --exclude-standard -- library.bib collections notes)" ]; then
  echo "Изменений нет."
  exit 0
fi
n=$(grep -c '^@' library.bib || true)
git add library.bib collections notes
git commit -m "Update library export ($n entries, $(date +%F))"
if [ "${1:-}" = "--push" ]; then
  git push
fi
