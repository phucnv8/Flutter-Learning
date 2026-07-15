# DESIGN — Thiết kế tổng thể quy trình Dạy · Học · Sharing

> Tài liệu này dành cho **Tech Lead & Senior**: giải thích *tại sao* khóa học được tổ chức như vậy và *cách vận hành* end-to-end trên GitLab. Nếu bạn chỉ muốn bắt đầu học, đọc `README.md` là đủ.

---

## 1. Mục tiêu thiết kế

Xây dựng một khóa học Flutter/Dart nội bộ cho ~20 dev (có kinh nghiệm, mới với Flutter) sao cho:

- **Khoa học & bài bản:** có lộ trình, chuẩn chung, quy trình rõ ràng.
- **Dễ tiếp cận cho người mới:** một cổng thông tin, biết ngay đọc gì trước.
- **Peer learning thật sự:** ai cũng vừa dạy vừa học, kiến thức được chuẩn hóa dần.
- **Tận dụng tối đa công cụ miễn phí của GitLab:** Repo, Wiki, Issues, MR, Boards, Milestones, CI/CD — không cần công cụ trả phí.

## 2. Vì sao chọn GitLab làm nền tảng (thay vì LMS/Notion...)

| Nhu cầu | Tính năng GitLab (Free) |
|---------|-------------------------|
| Giáo trình có version, review được | Repo + Merge Request |
| Nộp bài code + chấm tự động | MR + CI/CD Pipelines |
| Hỏi–đáp, thảo luận lưu vết | Issues + threads |
| Điều hướng, theo dõi trạng thái | Labels + Boards + Milestones |
| Phân quyền dạy/học | Roles (Maintainer/Developer) |

Toàn bộ vòng đời "học → làm → review → chuẩn hóa" nằm trong **một nơi**, tra cứu được, có lịch sử.

## 3. Mô hình vai trò

```
                       ┌─────────────────────┐
                       │     Maintainer      │  Tech Lead + 1–2 senior
                       │  (quản trị repo,    │  merge cuối, giữ nhịp
                       │   protect main)     │
                       └──────────┬──────────┘
                                  │
             ┌────────────────────┼────────────────────┐
             ▼                    ▼                     ▼
      ┌────────────┐       ┌────────────┐        ┌────────────┐
      │Module Owner│       │  Learner   │        │  Reviewer  │
      │ (senior,   │       │ (mọi người)│        │(mọi người, │
      │  luân phiên)│      │            │        │ peer)      │
      └────────────┘       └────────────┘        └────────────┘
```

Một người có thể mang nhiều vai (senior vừa là Module Owner của M04 vừa là Learner của M08). Vai trò gắn với **module**, không cố định cả khóa — đảm bảo mọi senior đều đóng góp và mọi người đều học.

## 4. Kiến trúc thông tin (Information Architecture)

Nguyên tắc: **một nguồn sự thật cho mỗi loại nội dung**, và **một cổng vào duy nhất** (`README.md`).

```
Cổng vào:        README.md  ──▶ chỉ đường tới mọi thứ
Lộ trình:        ROADMAP.md
Luật chơi:       CODE_OF_CONDUCT.md, CONTRIBUTING.md
Kiến thức chuẩn: docs/curriculum/     (chỉ sửa qua Docs MR có căn cứ)
Chuẩn & tham chiếu: docs/standards/   (coding, rubric, glossary, faq)
Hướng dẫn thao tác: docs/guides/      (setup, nộp bài, collaboration, labels)
Đề bài:          assignments/
Bài làm:         submissions/<username>/
Tự động hóa:     .gitlab-ci.yml, ci/
Templates:       .gitlab/issue_templates, .gitlab/merge_request_templates
```

Vì sao tách `curriculum` (kiến thức đã chốt) khỏi `guides` (thao tác) khỏi `standards` (quy ước)? Để người mới không bị ngợp: mỗi thư mục trả lời đúng một câu hỏi ("học gì" / "làm thế nào" / "chuẩn là gì").

## 5. Vòng đời một Module (chi tiết)

```
        [Chuẩn bị]                    [Học & Làm]                  [Chuẩn hóa]
┌──────────────────────┐     ┌──────────────────────────┐   ┌────────────────────┐
│ Module Owner (senior)│     │ Learner tự nghiên cứu    │   │ Meeting cuối module │
│ • nghiên cứu tài liệu│──▶  │ • đọc curriculum         │──▶│ • đi qua các điểm   │
│ • viết curriculum    │     │ • làm bài → MR           │   │   needs-standardize │
│ • soạn đề + câu hỏi  │     │ • hỏi/thảo luận (Issue)  │   │ • chốt cách hiểu    │
│ • tạo Milestone      │     │ • CI chấm + peer review  │   │ • Docs MR cập nhật  │
└──────────────────────┘     │ • Owner approve & merge  │   │   curriculum        │
                             └──────────────────────────┘   └────────────────────┘
                                                                      │
                                             giáo trình tốt hơn ◀──────┘
                                             cho khóa/người sau
```

Đây là điểm mấu chốt bạn mô tả: **sau khi member học và nộp bài → meeting thảo luận → doc chuẩn hóa kiến thức vào giáo trình.** Cơ chế hóa bằng label `status::needs-standardization` → buổi meeting → Docs MR `status::standardized`.

## 6. Ba quy trình con

### 6.1 Nộp bài & Chấm điểm (có Automation)
- Chi tiết: `docs/guides/submission-and-grading.md`, `docs/standards/review-rubric.md`.
- **Tự động (CI):** validate cấu trúc → `dart format` → `dart analyze` → `dart test` (+coverage). CI đỏ thì không review, không merge (merge check *Pipelines must succeed*).
- **Con người:** peer review + Module Owner approve theo rubric định tính.
- Triết lý: máy lo "đúng máy móc", người lo "hiểu bản chất".

### 6.2 Tương tác & Thảo luận (Collaboration)
- Chi tiết: `docs/guides/collaboration.md`.
- Mọi thứ qua **Issue** (Question/Discussion/Topic/Correction), có Board & Milestone.
- Nguyên tắc "chốt về Issue": chat thoải mái nhưng kết luận phải ghi lại.
- Khuyến khích **mọi người trả lời**, không chỉ senior.

### 6.3 Đóng góp & Chuẩn hóa (Contribute)
- Chi tiết: `CONTRIBUTING.md`.
- 5 hình thức đóng góp, quy ước branch/commit, luồng Docs MR.
- Giáo trình chỉ đổi khi có **căn cứ** (tài liệu chính thức hoặc kết luận meeting).

## 7. Best practices được áp dụng

- **Everything-as-code + review:** kể cả tài liệu đi qua MR → có version, có thảo luận, rollback được.
- **Trunk-based nhẹ:** branch ngắn, MR nhỏ, merge nhanh vào `main` protected.
- **Definition of Done rõ ràng:** CI xanh + review approve + threads resolved.
- **Conventional Commits** cho lịch sử đọc được.
- **Scoped labels + Boards** cho khả năng nhìn xuyên trạng thái.
- **Docs-as-source-of-truth** với quy trình chuẩn hóa tường minh.
- **Psychological safety:** Code of Conduct đặt việc "hỏi tự do" làm trung tâm.

## 8. Lộ trình triển khai (gợi ý cho Tech Lead)

1. **Tuần 0:** Push repo, chạy `docs/guides/repo-setup-checklist.md` (protect branch, labels, milestones, boards, thêm 20 members).
2. **Tuần 0:** 2–3 senior nhận M01–M03, hoàn thiện curriculum (M01 đã có bản mẫu).
3. **Kickoff:** buổi 30 phút giới thiệu mô hình + demo luồng nộp bài bằng 1 MR mẫu.
4. **Chạy:** self-paced; mỗi module có meeting chuẩn hóa khi đủ số bài nộp.
5. **Cải tiến liên tục:** sau mỗi module, retro nhanh trong Issue để chỉnh quy trình.

## 9. Rủi ro & cách giảm thiểu

| Rủi ro | Giảm thiểu |
|--------|-----------|
| Self-paced → trôi, mất động lực | Weekly text check-in, milestone theo module, meeting điểm hẹn |
| Senior quá tải | Luân phiên Module Owner, có backup mỗi module |
| Thảo luận trôi trong chat | Nguyên tắc "chốt về Issue" |
| Giáo trình loãng, thiếu nhất quán | Khung bài giảng chuẩn (M01 làm mẫu), Docs MR có review |
| Người mới ngợp | Một cổng `README.md`, checklist Day-1, `good-first-question` |
| CI khó/nản | Hướng dẫn chạy local trùng CI, thông báo lỗi rõ, allow_failure cho check phụ |

---

*Thiết kế này ưu tiên tính bền vững: khóa học là "tài sản sống" — mỗi vòng học làm giáo trình tốt hơn cho vòng sau.*
