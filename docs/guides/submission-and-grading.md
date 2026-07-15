# Quy trình Nộp bài & Chấm điểm

> End-to-end: từ lúc bạn bắt đầu làm bài đến khi được merge và kiến thức được chuẩn hóa.

## Sơ đồ luồng

```
┌────────────┐   ┌─────────────┐   ┌──────────────┐   ┌───────────────┐
│ 1. Làm bài │──▶│ 2. Mở MR    │──▶│ 3. CI tự chấm │──▶│ 4. Peer review │
│  (local)   │   │ (template)  │   │ lint/fmt/test │   │  (≥1 người)    │
└────────────┘   └─────────────┘   └──────┬───────┘   └───────┬───────┘
                                          │ đỏ → tự sửa        │
                                          ▼                    ▼
                                   ┌─────────────┐    ┌──────────────────┐
                                   │ CI xanh     │    │ 5. Owner approve  │
                                   └─────────────┘    │    + merge        │
                                                      └────────┬─────────┘
                                                               ▼
                                              ┌────────────────────────────┐
                                              │ 6. Meeting chuẩn hóa cuối   │
                                              │    module → cập nhật docs/  │
                                              └────────────────────────────┘
```

## Bước 1 — Làm bài (local)

```bash
# Tạo branch
git checkout -b submit/m01/dart-basics-<username>

# Tạo thư mục bài của bạn
mkdir -p submissions/<username>/module-01
cd submissions/<username>/module-01
# ... code, tạo pubspec.yaml, thư mục lib/ và test/ ...

# Kiểm tra local trước khi nộp (đây chính là những gì CI sẽ chạy)
dart format .
dart analyze
dart test
```

## Bước 2 — Mở Merge Request

- Push branch, mở MR, **chọn template `Assignment Submission`**.
- Điền checklist, link tới Issue/Milestone của module (`Closes #...`).
- Tiêu đề: `submit(m01): Dart Fundamentals - <username>`.

## Bước 3 — CI tự động chấm

Pipeline chạy 4 cổng (xem `.gitlab-ci.yml`):

1. **validate** — bạn có chỉ sửa thư mục của mình không?
2. **format** — `dart format --set-exit-if-changed`
3. **analyze** — `dart analyze --fatal-warnings`
4. **test** — `dart test` (+ coverage hiển thị trên MR)

MR **không merge được** khi pipeline đỏ (nhờ *Merge check: Pipelines must succeed*). Tự sửa và push lại.

## Bước 4 — Peer review

- Tối thiểu **1 đồng đội** review theo [`../standards/review-rubric.md`](../standards/review-rubric.md).
- Ai cũng review được — đây là cách học hai chiều.
- Reviewer để lại comment cụ thể, dùng "Suggest changes" của GitLab khi muốn đề xuất sửa trực tiếp.

## Bước 5 — Module Owner duyệt & merge

- Module Owner kiểm tra lần cuối, đảm bảo feedback đã được xử lý.
- Approve → **Merge** vào `main` (squash commit khuyến nghị).
- Nếu bài có insight hay/cách hiểu cần thống nhất → gắn label `status::needs-standardization` để đưa vào meeting.

## Bước 6 — Chuẩn hóa kiến thức

Cuối mỗi module có buổi meeting (xem [`collaboration.md`](collaboration.md#buổi-chuẩn-hóa-standardization-meeting)). Kết luận được:

- Ghi biên bản trong Issue `type::discussion` của module.
- Đưa phần kiến thức đã chốt vào `docs/curriculum/` qua **Docs MR** (`status::standardized`).

## Cấu hình GitLab cần bật (một lần, do Maintainer)

Vào **Settings → Merge requests / Repository → Protected branches**:

- `main` protected: chỉ Maintainer merge; bật *Pipelines must succeed* và *All threads resolved*.
- Bật **Approvals**: yêu cầu tối thiểu 1 approval.
- **Settings → CI/CD → Test coverage parsing**: dán regex `lines\.*:\s*(\d+\.\d+)%` (khớp output coverage bạn dùng).

Xem đầy đủ ở [`repo-setup-checklist.md`](repo-setup-checklist.md).
