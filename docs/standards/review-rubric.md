# Review Rubric — Tiêu chí chấm bài

> Kết hợp **chấm tự động (CI)** và **chấm người (peer + Module Owner)**. CI lo phần "đúng máy móc", con người lo phần "đúng tư duy".

## Phần 1 — Tự động (CI gate, bắt buộc pass mới review)

| Hạng mục | Công cụ | Điều kiện đạt |
|----------|---------|---------------|
| Cấu trúc nộp bài | `ci/validate_submission.sh` | Chỉ sửa thư mục của mình |
| Định dạng | `dart format` | Không còn thay đổi |
| Lint tĩnh | `dart analyze` | 0 warning/error |
| Test | `dart test` / `flutter test` | 100% test pass |

**CI đỏ = chưa review.** Người nộp tự sửa đến khi xanh.

## Phần 2 — Chấm người (thang điểm định tính)

Reviewer đánh giá theo 4 tiêu chí, mỗi tiêu chí 3 mức: 🟢 Đạt tốt · 🟡 Đạt / cần chỉnh · 🔴 Chưa đạt.

### 1. Tính đúng đắn (Correctness)
Bài giải quyết đúng yêu cầu đề? Xử lý edge case? Không có bug logic?

### 2. Chất lượng code (Code Quality)
Đặt tên rõ ràng, tách hàm hợp lý, không lặp code, dùng đúng idiom Dart (null safety, `const`, collection-if...).

### 3. Hiểu bản chất (Understanding)
Qua code + phần "tôi đã học được gì" + trả lời comment: người nộp *hiểu* hay chỉ copy? Reviewer có thể hỏi 1 câu để kiểm tra.

### 4. Tính giáo dục (Teachable moments)
Có insight/cách làm hay đáng chia sẻ cho cả nhóm không? Nếu có → đề xuất đưa vào giáo trình (`status::needs-standardization`).

## Kết luận review

- **Approve** khi cả 4 tiêu chí ≥ 🟡 và các 🟡 đã được comment hướng dẫn.
- **Request changes** khi có 🔴 — luôn kèm gợi ý cụ thể cách sửa.
- Ghi 1–2 câu tổng kết tích cực ("làm tốt phần X, để ý thêm Y").

## Nguyên tắc cho Reviewer

- Góp ý **code, không phải người** (xem Code of Conduct).
- Ưu tiên **hỏi** hơn **phán** ("Sao em chọn `late` ở đây?" thay vì "Chỗ này sai").
- Bài của người mới → kiên nhẫn, giải thích *tại sao*, kèm link giáo trình.
- Không review = không merge. Đừng để MR "mồ côi": Module Owner theo dõi board.

## Không dùng điểm số?

Khóa học ưu tiên **feedback định tính** hơn điểm số, để tránh áp lực thành tích và khuyến khích hỏi. Nếu tổ chức muốn có điểm, quy đổi gợi ý: mỗi tiêu chí 🟢=2, 🟡=1, 🔴=0 → tổng /8. Đạt module khi ≥5/8 **và** không có 🔴.
