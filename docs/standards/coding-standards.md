# Coding Standards — Quy ước code Dart/Flutter

> Chuẩn chung cho mọi bài nộp để CI và review nhất quán. Dựa trên [Effective Dart](https://dart.dev/effective-dart) chính thức.

## 1. Format & Lint

- **Luôn** `dart format` trước khi commit (CI bắt buộc).
- Dùng `analysis_options.yaml` dưới đây làm chuẩn — copy vào mỗi project bài tập:

```yaml
# analysis_options.yaml
include: package:lints/recommended.yaml   # hoặc flutter_lints cho project Flutter

analyzer:
  language:
    strict-casts: true
    strict-raw-types: true
  errors:
    todo: ignore

linter:
  rules:
    - prefer_const_constructors
    - prefer_final_locals
    - avoid_print          # dùng logger thay print trong code thật
    - require_trailing_commas
```

## 2. Đặt tên (naming)

| Đối tượng | Quy ước | Ví dụ |
|-----------|---------|-------|
| Class, enum, typedef | `UpperCamelCase` | `UserRepository` |
| Biến, hàm, tham số | `lowerCamelCase` | `fetchUsers` |
| Hằng | `lowerCamelCase` | `defaultTimeout` |
| File, thư mục | `snake_case` | `user_repository.dart` |
| Private | tiền tố `_` | `_cache` |

## 3. Null safety

- Ưu tiên non-nullable. Chỉ dùng `?` khi thật sự có thể null.
- Tránh `!` (bang operator) trừ khi chắc chắn — ưu tiên `?.`, `??`, `if (x != null)`.
- Dùng `late` có chủ đích, không lạm dụng để né khởi tạo.

## 4. Dart idiom nên dùng

- `const` cho widget/biến bất biến (tối ưu rebuild).
- Collection-if / collection-for thay vì build list thủ công.
- Cascade `..` khi cấu hình nhiều thuộc tính một object.
- `final` mặc định cho biến local; chỉ `var` khi cần gán lại.

## 5. Riêng Flutter

- Tách widget lớn thành widget nhỏ tái sử dụng thay vì hàm `_buildXxx()` khổng lồ.
- `const` constructor cho widget không đổi.
- Không đặt logic nặng trong `build()`.
- Xử lý `dispose()` cho controller/stream để tránh leak.

## 6. Cấu trúc thư mục bài nộp

```
submissions/<username>/module-NN/
├── pubspec.yaml
├── analysis_options.yaml
├── lib/
│   └── *.dart
├── test/
│   └── *_test.dart
└── README.md          # ghi chú cách chạy + suy nghĩ của bạn
```

## 7. Commit & MR

Xem [`../../CONTRIBUTING.md`](../../CONTRIBUTING.md) cho Conventional Commits và quy ước branch.
