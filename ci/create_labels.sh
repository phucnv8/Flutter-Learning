#!/usr/bin/env bash
# =============================================================================
# create_labels.sh — Tạo hàng loạt label cho project qua GitLab API.
# Cách dùng:
#   export GITLAB_URL="https://gitlab-new.vndirect.com.vn"
#   export PROJECT_ID="123"                 # Settings → General → Project ID
#   export GITLAB_TOKEN="glpat-xxxxx"       # Personal Access Token, scope: api
#   bash ci/create_labels.sh
# =============================================================================
set -euo pipefail

: "${GITLAB_URL:?Set GITLAB_URL}"
: "${PROJECT_ID:?Set PROJECT_ID}"
: "${GITLAB_TOKEN:?Set GITLAB_TOKEN}"

API="$GITLAB_URL/api/v4/projects/$PROJECT_ID/labels"

create() {
  local name="$1" color="$2" desc="${3:-}"
  echo "Tạo label: $name"
  curl -sf --request POST "$API" \
    --header "PRIVATE-TOKEN: $GITLAB_TOKEN" \
    --data-urlencode "name=$name" \
    --data-urlencode "color=$color" \
    --data-urlencode "description=$desc" >/dev/null \
    && echo "  ✓" || echo "  (đã tồn tại hoặc lỗi, bỏ qua)"
}

# type::
create "type::question"        "#1f75cb" "Câu hỏi kiến thức"
create "type::topic-proposal"  "#6f42c1" "Đề xuất chủ đề mới"
create "type::discussion"      "#fca121" "Thảo luận / tranh luận"
create "type::correction"      "#e8710a" "Sửa giáo trình/đề bài"
create "type::submission"      "#2da160" "MR nộp bài"

# module:: (01..10)
for i in $(seq -w 1 10); do
  create "module::$i" "#428fdc" "Thuộc Module $i"
done

# status::
create "status::open"                  "#dcdcde" "Mới, chưa ai nhận"
create "status::in-discussion"         "#fca121" "Đang thảo luận"
create "status::answered"              "#2da160" "Đã có câu trả lời"
create "status::needs-standardization" "#ad4363" "Chờ chuẩn hóa vào giáo trình"
create "status::standardized"          "#217645" "Đã chuẩn hóa"

# level::
create "good-first-question" "#7f8c8d" "Dễ, khuyến khích người mới trả lời"
create "help-wanted"         "#0b5cad" "Cần người hỗ trợ"
create "blocked"             "#dd2b0e" "Đang bị chặn"

echo "Xong. Kiểm tra tại: $GITLAB_URL/<group>/<project>/-/labels"
