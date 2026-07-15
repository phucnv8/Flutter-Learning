# Environment Setup — Cài đặt môi trường

> Làm một lần trước Module 01. Nếu kẹt, mở Issue `type::question` + `good-first-question`.

## 1. Cài Flutter SDK (đã bao gồm Dart)

- Tải theo hướng dẫn chính thức: https://docs.flutter.dev/get-started/install
- Sau khi cài, kiểm tra:
  ```bash
  flutter --version
  dart --version
  flutter doctor      # sửa các mục ❌ mà doctor báo
  ```

## 2. IDE khuyến nghị

- **VS Code** + extension *Flutter* & *Dart*, hoặc **Android Studio** + plugin Flutter.
- Bật **Format on Save** để `dart format` chạy tự động (giảm rớt CI vì format).

## 3. Chạy thử một project

```bash
flutter create hello_flutter
cd hello_flutter
flutter run        # chọn thiết bị: Chrome (web) là nhanh nhất để bắt đầu
```

## 4. Riêng cho bài tập Dart thuần (M01–M03)

Nhiều bài tập Dart không cần Flutter, chạy nhanh hơn với Dart CLI:

```bash
mkdir my_exercise && cd my_exercise
dart create -t console .
dart run
dart test
```

## 5. Chuẩn bị cho việc nộp bài

- Cấu hình Git (name/email) trùng tài khoản GitLab nội bộ.
- Đọc [`submission-and-grading.md`](submission-and-grading.md) để nắm luồng MR.
- Thêm `analysis_options.yaml` chuẩn (xem `docs/standards/coding-standards.md`) vào project bài tập để lint khớp CI.

## Sự cố thường gặp

| Triệu chứng | Cách xử lý |
|-------------|-----------|
| `flutter doctor` báo thiếu Android toolchain | Cài Android Studio + SDK, chạy `flutter doctor --android-licenses` |
| CI đỏ ở bước format | Chạy `dart format .` local rồi commit lại |
| CI đỏ ở analyze | Chạy `dart analyze`, sửa hết warning; đảm bảo có `analysis_options.yaml` |
| `pub get` chậm/lỗi mạng | Kiểm tra proxy nội bộ công ty, cấu hình `PUB_HOSTED_URL` nếu cần |
