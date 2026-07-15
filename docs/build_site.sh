#!/usr/bin/env bash
# =============================================================================
# build_site.sh — Build website giáo trình bằng MkDocs.
# Dùng chung cho CI (job "pages") và preview local.
#
#   Local preview:   pip install -r docs/requirements.txt
#                    bash docs/build_site.sh serve      # mở http://127.0.0.1:8000
#   Build tĩnh:       bash docs/build_site.sh build     # ra thư mục public/
#
# Cơ chế: các file governance ở gốc repo (ROADMAP, CONTRIBUTING, CODE_OF_CONDUCT,
# DESIGN) được COPY tạm vào docs/ để MkDocs đưa vào nav, kèm sửa nhẹ link
# (bỏ tiền tố "docs/"). Bản copy này được .gitignore, không commit.
# =============================================================================
set -euo pipefail
cd "$(dirname "$0")/.."   # về gốc repo

MODE="${1:-build}"
ROOT_DOCS=(ROADMAP.md CONTRIBUTING.md CODE_OF_CONDUCT.md DESIGN.md)

echo "==> Copy file governance vào docs/ và chuẩn hóa link..."
for f in "${ROOT_DOCS[@]}"; do
  if [ -f "$f" ]; then
    # bỏ tiền tố docs/ trong link để trỏ đúng khi file nằm trong docs/
    sed 's#](docs/#](#g' "$f" > "docs/$f"
  fi
done

case "$MODE" in
  serve)
    echo "==> mkdocs serve (Ctrl+C để dừng)"
    mkdocs serve
    ;;
  build)
    echo "==> mkdocs build → public/"
    # Không dùng --strict: một số link trỏ tới thư mục repo (assignments/, submissions/)
    # nằm ngoài site nên sẽ là cảnh báo, không nên làm fail deploy.
    mkdocs build --site-dir public
    echo "==> Xong. Mở public/index.html hoặc deploy qua GitLab Pages."
    ;;
  *)
    echo "Usage: build_site.sh [serve|build]" >&2
    exit 1
    ;;
esac
