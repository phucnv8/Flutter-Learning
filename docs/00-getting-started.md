# Getting Started — Khóa học vận hành thế nào?

Chào mừng bạn đến với khóa học Flutter & Dart nội bộ. Trang này giải thích **mô hình vận hành** để bạn biết mình cần làm gì.

## 1. Triết lý: Peer Learning

Khóa học **không có giảng viên duy nhất**. Đây là mô hình học ngang hàng:

- **Senior** luân phiên làm *Module Owner*: nghiên cứu tài liệu, viết dàn ý, ra đề bài và câu hỏi thảo luận.
- **Mọi thành viên** tự nghiên cứu, làm bài, đặt câu hỏi, raise issue tự do — miễn liên quan kiến thức.
- Sau khi học & nộp bài, cả nhóm **họp thảo luận** để chốt cách hiểu đúng, rồi **chuẩn hóa** kiến thức đó vào giáo trình (`docs/`).

Kết quả: giáo trình ngày càng hoàn thiện, khóa sau học tốt hơn khóa trước.

## 2. Bốn hoạt động bạn sẽ làm

### a. Học (Learn)
Đọc bài giảng trong `docs/curriculum/`, tự thực hành theo lộ trình `ROADMAP.md`.

### b. Nộp bài (Submit)
Làm bài trong `submissions/<username>/module-NN/`, mở **Merge Request**. CI tự động chấm (lint/format/test), peer review, rồi Module Owner duyệt. Chi tiết: [`guides/submission-and-grading.md`](guides/submission-and-grading.md).

### c. Hỏi & Thảo luận (Ask & Discuss)
Mọi câu hỏi mở bằng **Issue** (dùng template). Đừng ngại hỏi — câu hỏi hay giúp cả nhóm. Chi tiết: [`guides/collaboration.md`](guides/collaboration.md).

### d. Chuẩn hóa (Standardize)
Sau mỗi module có buổi meeting. Kết luận được ghi lại và đưa vào giáo trình qua MR gắn label `type::correction`.

## 3. Bạn cần chuẩn bị gì?

1. Tài khoản GitLab nội bộ + quyền vào repo.
2. Môi trường dev: xem [`guides/environment-setup.md`](guides/environment-setup.md).
3. Đọc [`../CODE_OF_CONDUCT.md`](../CODE_OF_CONDUCT.md) và [`../CONTRIBUTING.md`](../CONTRIBUTING.md).

## 4. Luồng làm việc trong 1 phút

```
1. Xem ROADMAP → chọn module
2. Đọc bài giảng trong docs/curriculum/
3. Làm bài trong submissions/<username>/module-NN/
4. Mở Merge Request → CI chấm + peer review → Owner approve
5. Có thắc mắc? Mở Issue (Question)
6. Dự meeting chuẩn hóa cuối module
```

## 5. Cần giúp đỡ?

Mở Issue với label `type::question` và `good-first-question`, hoặc nhắn Maintainer. Không có câu hỏi nào là ngớ ngẩn.
