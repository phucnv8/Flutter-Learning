# Labels & Boards — Danh mục nhãn và cách dùng

> Copy danh sách này vào **Settings → Labels** (scoped labels dùng `::` — có ở GitLab Free). Nhãn giúp lọc, làm board, và điều hướng nhanh.

## Nhóm `type::` — loại nội dung (scoped, chỉ 1 giá trị)

| Label | Màu gợi ý | Dùng cho |
|-------|-----------|----------|
| `type::question` | xanh dương | Câu hỏi kiến thức |
| `type::topic-proposal` | tím | Đề xuất chủ đề mới |
| `type::discussion` | vàng | Thảo luận / tranh luận |
| `type::correction` | cam | Sửa lỗi giáo trình/đề bài |
| `type::submission` | xanh lá | MR nộp bài |

## Nhóm `module::` — thuộc module nào (scoped)

`module::01` … `module::10` — gắn cho mọi Issue/MR để lọc theo module. Màu đồng nhất (xám xanh).

## Nhóm `status::` — trạng thái xử lý (scoped, dùng làm cột Board)

| Label | Ý nghĩa |
|-------|---------|
| `status::open` | Mới, chưa ai nhận |
| `status::in-discussion` | Đang thảo luận |
| `status::answered` | Đã có câu trả lời được chấp nhận |
| `status::needs-standardization` | Chờ đưa vào giáo trình |
| `status::standardized` | Đã chuẩn hóa vào docs |

## Nhóm `level::` — độ khó / khuyến khích (không scoped)

| Label | Dùng cho |
|-------|----------|
| `good-first-question` | Câu hỏi dễ, khuyến khích người mới trả lời |
| `help-wanted` | Cần người hỗ trợ / nhận việc |
| `blocked` | Đang bị chặn bởi việc khác |

## Cấu hình Boards

**Board 1 — Knowledge Flow** (cột theo `status::`):
`open → in-discussion → answered → needs-standardization → standardized`

**Board 2 — Submissions** (lọc `type::submission`, cột theo trạng thái MR / `module::`):
Theo dõi bài nộp nào đang chờ review, đang sửa, đã merge.

## Tạo nhanh bằng file (tùy chọn)

GitLab không import label từ file trực tiếp qua UI, nhưng bạn có thể dùng API. Ví dụ script tạo label hàng loạt: xem [`../../ci/create_labels.sh`](../../ci/create_labels.sh).
