# Contributing Guide — Hướng dẫn tham gia dạy · học · sharing

> Đây là "luật chơi" của khóa học. Đọc một lần, tham gia trơn tru. Mọi thành viên đều có thể đóng góp theo **5 hình thức** dưới đây.

## Mục lục

- [Nguyên tắc chung](#nguyên-tắc-chung)
- [5 hình thức đóng góp](#5-hình-thức-đóng-góp)
- [Quy ước Git & Branch](#quy-ước-git--branch)
- [Quy ước Commit](#quy-ước-commit)
- [Nộp bài tập (Assignment MR)](#nộp-bài-tập-assignment-mr)
- [Đóng góp / sửa giáo trình (Docs MR)](#đóng-góp--sửa-giáo-trình-docs-mr)
- [Mở Issue: hỏi, đề xuất, báo lỗi](#mở-issue-hỏi-đề-xuất-báo-lỗi)
- [Trở thành Module Owner](#trở-thành-module-owner)

---

## Nguyên tắc chung

1. **Mọi thay đổi đi qua Merge Request** — không push trực tiếp lên `main`.
2. **Mọi thảo luận đi qua Issue** — để tra cứu lại được, không tan biến trong chat.
3. **Nhỏ và thường xuyên** hơn là to và hiếm. MR nhỏ dễ review.
4. **Liên kết mọi thứ** — MR link tới Issue, Issue gắn Milestone (module) và label.
5. Tôn trọng [Code of Conduct](CODE_OF_CONDUCT.md).

---

## 5 hình thức đóng góp

| # | Hình thức | Công cụ GitLab | Ai làm |
|---|-----------|----------------|--------|
| 1 | **Nộp bài tập** | Merge Request (template *Assignment Submission*) | Learner |
| 2 | **Đặt câu hỏi / thảo luận** | Issue (template *Question* / *Discussion*) | Tất cả |
| 3 | **Đề xuất topic học mới** | Issue (template *Topic Proposal*) | Tất cả (senior duyệt) |
| 4 | **Báo lỗi / sửa giáo trình** | Issue *Correction* + Docs MR | Tất cả |
| 5 | **Biên soạn giáo trình & đề bài** | Docs MR | Module Owner (senior) |

---

## Quy ước Git & Branch

Đặt tên branch theo pattern:

```
<loại>/<module>/<mô-tả-ngắn>-<username>

Ví dụ:
submit/m01/dart-basics-hungnv        ← nộp bài module 01
docs/m04/add-layout-examples         ← bổ sung giáo trình
fix/m02/typo-in-stream-section       ← sửa lỗi tài liệu
```

`main` được **protected**: chỉ Maintainer merge được, và bắt buộc CI pass + tối thiểu 1 approval.

---

## Quy ước Commit

Dùng [Conventional Commits](https://www.conventionalcommits.org/) để lịch sử dễ đọc:

```
feat: thêm ví dụ Stream cho module 02
docs: chuẩn hóa phần null safety sau buổi thảo luận
fix: sửa test case bị sai ở bài tập module 01
submit: nộp bài module 01 - hungnv
chore: cập nhật bảng module owners
```

Prefix thường dùng: `feat`, `docs`, `fix`, `submit`, `chore`, `refactor`, `test`.

---

## Nộp bài tập (Assignment MR)

1. Đọc đề trong `assignments/module-NN-.../README.md`.
2. Tạo thư mục `submissions/<username>/module-NN/` và làm bài trong đó.
3. Chạy kiểm tra local trước khi nộp:
   ```bash
   dart format .
   dart analyze
   dart test        # hoặc: flutter test
   ```
4. Commit, push branch `submit/mNN/...`, mở **Merge Request** chọn template **Assignment Submission**.
5. Điền checklist trong template. **Link tới Issue/Milestone của module.**
6. CI tự chạy (lint + format + test). Sửa đến khi pipeline **xanh**.
7. Chờ ≥1 **peer review** rồi **Module Owner** duyệt & merge.

Chi tiết + rubric chấm điểm: [`docs/guides/submission-and-grading.md`](docs/guides/submission-and-grading.md).

> ⚠️ **Không sửa bài của người khác** trong MR của bạn. Mỗi người chỉ đụng thư mục `submissions/<username-của-mình>/`. CI có kiểm tra điều này.

---

## Đóng góp / sửa giáo trình (Docs MR)

Thấy giáo trình sai, thiếu, hoặc muốn bổ sung ví dụ hay?

1. Mở Issue `type::correction` mô tả vấn đề (hoặc comment vào Issue có sẵn).
2. Branch `docs/mNN/...`, sửa file trong `docs/`.
3. Mở MR link tới Issue. Ghi rõ *lý do* thay đổi.
4. Kiến thức đến từ buổi chuẩn hóa: gắn thêm label `status::standardized` và tham chiếu biên bản meeting.

Giáo trình là **nguồn sự thật đã chuẩn hóa** — thay đổi cần có căn cứ (tài liệu chính thức Dart/Flutter, hoặc kết luận meeting).

---

## Mở Issue: hỏi, đề xuất, báo lỗi

Vào **Issues → New issue → chọn template**:

- **Question** — hỏi về kiến thức. Gắn `module::NN`. Nếu dễ, thêm `good-first-question` để khuyến khích người mới trả lời.
- **Topic Proposal** — đề xuất chủ đề/nội dung học mới. Senior sẽ đánh giá và đưa vào roadmap nếu phù hợp.
- **Discussion** — chủ đề mở, tranh luận cách tiếp cận (vd: Bloc vs Riverpod).
- **Correction** — báo lỗi hoặc đề xuất cải thiện giáo trình/đề bài.

**Trả lời câu hỏi của người khác được khuyến khích mạnh** — đó cũng là cách bạn học. Khi một Issue có câu trả lời tốt, Module Owner sẽ cân nhắc đưa vào FAQ/giáo trình và gắn `status::needs-standardization`.

---

## Trở thành Module Owner

Senior muốn nhận một module:

1. Đăng ký tên vào `docs/guides/module-owners.md` (mở MR).
2. Trách nhiệm: viết/hoàn thiện giáo trình module, soạn ≥1 bài tập + rubric, chuẩn bị 3–5 câu hỏi thảo luận, review bài nộp, và chủ trì buổi chuẩn hóa.
3. Sau buổi chuẩn hóa: tổng hợp kết luận, cập nhật `docs/` qua MR.

Xem quy trình đầy đủ trong [`DESIGN.md`](DESIGN.md).

---

*Cảm ơn bạn đã đóng góp. Mỗi Issue, mỗi review, mỗi dòng docs bạn thêm vào đều làm khóa học tốt hơn cho người tiếp theo.* 💙
