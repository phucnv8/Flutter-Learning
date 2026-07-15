# Bài tập — Module 01: Dart Fundamentals

> **Đây là đề bài mẫu.** Module Owner khác dùng khung này để soạn đề của mình.

## Mục tiêu

Vận dụng biến, kiểu, collection, hàm, control flow và null safety cơ bản.

## Yêu cầu bắt buộc

Tạo project Dart console trong `submissions/<username>/module-01/` và hoàn thành:

### Bài 1 — Word frequency counter
Viết hàm `Map<String, int> wordCount(String text)` đếm số lần xuất hiện mỗi từ (không phân biệt hoa/thường, bỏ dấu câu cơ bản).

### Bài 2 — Safe average
Viết hàm `double? average(List<num> values)` trả về trung bình cộng, trả `null` nếu list rỗng. Thể hiện đúng null safety.

### Bài 3 — Grade classifier
Viết hàm `String classify(int score)` dùng `switch` trả về xếp loại: `>=90` A, `>=80` B, `>=70` C, còn lại D. Ném `ArgumentError` nếu score ngoài 0–100.

## Yêu cầu kỹ thuật

- Có `pubspec.yaml` và `analysis_options.yaml` (copy từ `docs/standards/coding-standards.md`).
- Code trong `lib/`, test trong `test/`.
- **Viết test** cho cả 3 hàm (tối thiểu 2 case mỗi hàm, gồm edge case).
- `dart format`, `dart analyze`, `dart test` đều sạch/xanh.

## Phần mở rộng (tùy chọn, khuyến khích)

- Bài 1: hỗ trợ Unicode tiếng Việt đúng cách.
- Bài 2: nhận `Iterable<num>` thay vì `List`.
- Viết thêm ghi chú trong `README.md` của bài về quyết định thiết kế của bạn.

## Cách nộp

1. `git checkout -b submit/m01/dart-fundamentals-<username>`
2. Làm bài trong `submissions/<username>/module-01/`.
3. Kiểm tra local: `dart format . && dart analyze && dart test`.
4. Mở MR với template **Assignment Submission**, link Issue/Milestone Module 01.

## Chấm điểm

Theo [`docs/standards/review-rubric.md`](../../docs/standards/review-rubric.md): CI gate + peer review + Module Owner approve.

## Gợi ý cấu trúc bài nộp

```
submissions/<username>/module-01/
├── pubspec.yaml
├── analysis_options.yaml
├── lib/
│   ├── word_count.dart
│   ├── average.dart
│   └── classify.dart
├── test/
│   ├── word_count_test.dart
│   ├── average_test.dart
│   └── classify_test.dart
└── README.md
```
