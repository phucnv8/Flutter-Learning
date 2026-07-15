#!/usr/bin/env bash
# =============================================================================
# setup.sh — Bootstrap nhanh bộ khóa học vào GitLab repository.
#
# Chạy script này TỪ BÊN TRONG thư mục flutter-and-dart-course/ (đã giải nén).
# Nó sẽ: khởi tạo git (nếu cần) → gắn remote → commit → push lên nhánh main.
#
# Cách dùng:
#   REMOTE_URL="https://gitlab-new.vndirect.com.vn/ipas-fe/rnd/flutter-and-dart-course.git" \
#   bash setup.sh
#
# Hoặc chạy tương tác (script sẽ hỏi URL nếu chưa set REMOTE_URL).
# =============================================================================
set -euo pipefail

BRANCH="${BRANCH:-main}"

# --- 1. Xác định remote URL --------------------------------------------------
if [ -z "${REMOTE_URL:-}" ]; then
  read -rp "Nhập GitLab remote URL (git): " REMOTE_URL
fi
[ -n "$REMOTE_URL" ] || { echo "❌ Cần REMOTE_URL"; exit 1; }

# --- 2. Kiểm tra công cụ -----------------------------------------------------
command -v git >/dev/null || { echo "❌ Chưa có git"; exit 1; }

# --- 3. Khởi tạo git repo ----------------------------------------------------
if [ ! -d .git ]; then
  echo "==> git init"
  git init -q
  git checkout -q -b "$BRANCH"
else
  echo "==> Đã là git repo, dùng nhánh hiện tại"
fi

# --- 4. Cho phép chạy script trong ci/ và docs/ ------------------------------
chmod +x ci/*.sh docs/build_site.sh setup.sh 2>/dev/null || true

# --- 5. Gắn remote -----------------------------------------------------------
if git remote get-url origin >/dev/null 2>&1; then
  git remote set-url origin "$REMOTE_URL"
else
  git remote add origin "$REMOTE_URL"
fi
echo "==> origin = $(git remote get-url origin)"

# --- 6. Commit ---------------------------------------------------------------
git add -A
if git diff --cached --quiet; then
  echo "==> Không có thay đổi để commit"
else
  git commit -q -m "chore: khởi tạo khóa học Flutter & Dart (KB, quy trình, CI, Pages)"
  echo "==> Đã commit"
fi

# --- 7. Push -----------------------------------------------------------------
echo "==> Push lên origin/$BRANCH ..."
if git push -u origin "$BRANCH"; then
  echo "✅ Push thành công."
else
  echo "⚠️  Push bị từ chối. Nếu repo đã có nội dung, cân nhắc:"
  echo "     git pull --rebase origin $BRANCH   rồi   git push -u origin $BRANCH"
  exit 1
fi

cat <<'NEXT'

──────────────────────────────────────────────────────────────
✅ ĐÃ PUSH XONG. Việc cần làm tiếp trên GitLab (một lần):

  1. Settings → Repository → Protected branches: bảo vệ `main`
     (chỉ Maintainer merge; bật "Pipelines must succeed" + "All threads resolved")
  2. Settings → Merge requests → Approvals: yêu cầu tối thiểu 1 approval
  3. Tạo labels tự động:
       export GITLAB_URL="https://<host>"; export PROJECT_ID="<id>"; export GITLAB_TOKEN="<token>"
       bash ci/create_labels.sh
  4. Tạo Milestones "Module 01".."Module 10" và 2 Boards (Knowledge Flow, Submissions)
  5. Settings → CI/CD → Test coverage parsing:  lines\.*:\s*(\d+\.\d+)%
  6. Settings → Pages: lấy URL website giáo trình (sau khi pipeline chạy)
  7. Thêm 20 thành viên (Developer) + Tech Lead/senior (Maintainer)

  Chi tiết đầy đủ: docs/guides/repo-setup-checklist.md
──────────────────────────────────────────────────────────────
NEXT
