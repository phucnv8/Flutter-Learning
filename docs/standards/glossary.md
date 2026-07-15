# Glossary — Thuật ngữ Flutter & Dart (song ngữ)

> Giữ thuật ngữ tiếng Anh, giải thích tiếng Việt. Bổ sung khi gặp từ mới (mở Docs MR).

| Thuật ngữ (EN) | Giải thích (VI) |
|----------------|-----------------|
| **Widget** | Đơn vị dựng UI trong Flutter. "Mọi thứ là widget." |
| **StatelessWidget** | Widget không có state thay đổi theo thời gian. |
| **StatefulWidget** | Widget có state, rebuild khi state đổi (`setState`). |
| **BuildContext** | "Vị trí" của widget trong cây widget; dùng để truy cập theme, navigator... |
| **Widget tree** | Cây phân cấp các widget tạo nên UI. |
| **Hot reload** | Nạp lại code giữ nguyên state — vòng lặp phát triển nhanh. |
| **Future** | Giá trị sẽ có trong tương lai (bất đồng bộ). |
| **Stream** | Chuỗi giá trị bất đồng bộ theo thời gian. |
| **async/await** | Cú pháp viết code bất đồng bộ như đồng bộ. |
| **Isolate** | Đơn vị chạy song song trong Dart (không chia sẻ bộ nhớ). |
| **Null safety** | Hệ thống kiểu phân biệt rõ nullable (`?`) và non-nullable. |
| **Sound typing** | Hệ kiểu "vững": kiểu tĩnh đảm bảo tại runtime. |
| **Mixin** | Cơ chế tái sử dụng code across nhiều class (`with`). |
| **Extension** | Thêm method cho class có sẵn mà không sửa nó. |
| **pubspec.yaml** | File khai báo dependencies & metadata của package. |
| **pub / pub.dev** | Trình quản lý package của Dart & kho package. |
| **State management** | Cách quản lý & chia sẻ trạng thái ứng dụng (Provider, Riverpod, Bloc...). |
| **Navigator** | Quản lý stack màn hình & điều hướng. |
| **Repository pattern** | Lớp trung gian tách nguồn dữ liệu khỏi business logic. |
| **DevTools** | Bộ công cụ debug/performance của Flutter. |
| **Jank** | Hiện tượng khung hình rớt, UI giật. |
| **Flavor** | Biến thể build (dev/staging/prod) khác cấu hình. |
