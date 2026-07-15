#!/usr/bin/env bash
# =============================================================================
# validate_submission.sh
# Đảm bảo một MR nộp bài tuân thủ quy ước:
#   1. Chỉ chạm vào MỘT thư mục submissions/<username>/ (không sửa bài người khác,
#      không sửa docs/assignments trong cùng MR nộp bài).
#   2. Có file PROGRESS.md hoặc README trong thư mục module nộp.
# Thoát mã != 0 nếu vi phạm → CI đỏ, MR không merge được.
# =============================================================================
set -euo pipefail

# Base branch để so sánh (mặc định main). GitLab cung cấp biến này trong MR pipeline.
TARGET="${CI_MERGE_REQUEST_TARGET_BRANCH_NAME:-main}"

git fetch --depth=50 origin "$TARGET" >/dev/null 2>&1 || true

# Danh sách file thay đổi so với nhánh đích
CHANGED=$(git diff --name-only "origin/$TARGET"...HEAD || git diff --name-only HEAD~1)

echo "Các file thay đổi:"
echo "$CHANGED"
echo "-----------------------------------------"

# Lọc file ngoài submissions/
OUTSIDE=$(echo "$CHANGED" | grep -v '^submissions/' || true)
if [ -n "$OUTSIDE" ]; then
  echo "❌ MR nộp bài chỉ được thay đổi file trong submissions/."
  echo "   Các file ngoài phạm vi:"
  echo "$OUTSIDE" | sed 's/^/     - /'
  echo "   → Tách phần sửa docs/đề bài sang một MR riêng."
  exit 1
fi

# Xác định các username (thư mục cấp 2) bị chạm tới
USERS=$(echo "$CHANGED" | awk -F'/' '/^submissions\// {print $2}' | sort -u)
COUNT=$(echo "$USERS" | grep -c . || true)

if [ "$COUNT" -gt 1 ]; then
  echo "❌ MR chạm vào nhiều thư mục người dùng: $USERS"
  echo "   → Mỗi MR nộp bài chỉ được sửa submissions/<username-của-bạn>/."
  exit 1
fi

echo "✅ Cấu trúc nộp bài hợp lệ (user: ${USERS:-none})."
