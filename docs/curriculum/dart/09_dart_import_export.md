# Import và Export trong Dart

## Khái niệm nền: library
Mỗi file `.dart` mặc định là một **library** riêng. `import`/`export` làm việc trên library, không phải trên "file" hay "class". Đây cũng là lý do quy tắc private (`_`) hoạt động theo library.

---

## import
Kéo các tên (name) từ một thư viện **vào** file hiện tại để dùng.

### Ba loại nguồn
```dart
import 'dart:math';                     // thư viện lõi đi kèm SDK
import 'package:flutter/material.dart'; // package trong pubspec.yaml (trỏ vào lib/)
import 'utils/helper.dart';             // đường dẫn tương đối trong project
```
- `dart:core` được import **ngầm định** vào mọi file (`String`, `int`, `List`, `print`...).

### as — tiền tố (prefix) để tạo namespace
Tránh xung đột khi hai thư viện trùng tên.
```dart
import 'package:lib1/lib1.dart' as lib1;
lib1.Element el = lib1.Element();
```

### show / hide — combinators
```dart
import 'package:lib/lib.dart' show Foo, bar; // chỉ lấy Foo, bar
import 'package:lib/lib.dart' hide Internal;  // lấy mọi thứ TRỪ Internal
```
Có thể kết hợp với `as`: `import '...' as l show Foo;`

### deferred as — tải trễ (lazy loading)
Hoãn nạp thư viện đến khi cần (có ý nghĩa nhất khi biên dịch web).
```dart
import 'package:heavy/heavy.dart' deferred as heavy;
await heavy.loadLibrary(); // BẮT BUỘC gọi trước khi dùng
heavy.doSomething();
```

### Import có điều kiện (conditional)
Chọn file khác nhau theo nền tảng biên dịch (native vs web).
```dart
import 'stub.dart'
    if (dart.library.io) 'io_impl.dart'         // native
    if (dart.library.js_interop) 'web_impl.dart'; // web
```
File đầu là fallback; các file phải khai báo API giống nhau.

---

## export
**Không** đưa tên vào file bạn để dùng, mà **phơi bày lại** cho những ai import file của bạn.

### Cơ bản + combinators
```dart
export 'src/foo.dart';
export 'src/bar.dart' show Foo;
export 'src/baz.dart' hide InternalHelper;
```

### Export có điều kiện
```dart
export 'stub.dart' if (dart.library.io) 'io.dart';
```

### Barrel file — mẫu phổ biến nhất
Gom nhiều file nội bộ thành một điểm truy cập công khai duy nhất. Code thật đặt trong `lib/src/`, phơi bày qua file ở gốc `lib/`.
```dart
// lib/my_package.dart
export 'src/models.dart';
export 'src/services.dart' show ApiService;
```
→ Người dùng chỉ cần `import 'package:my_package/my_package.dart';`, còn bạn tự do tổ chức lại `src/` mà không phá vỡ ai.

---

## library / part / part of
- `library ten_lib;` — tùy chọn, dùng để gắn doc/annotation cấp thư viện.
- `part` / `part of` — tách một library thành nhiều file **vật lý** nhưng vẫn là một library **logic** (chia sẻ scope, kể cả các thành viên private).
```dart
// main.dart
part 'other.dart';
// other.dart
part of 'main.dart';
```
- Ngày nay ít viết tay và bị coi là lỗi thời cho việc tổ chức code thông thường → ưu tiên chia library nhỏ dùng `import`/`export`.
- Vẫn gặp nhiều trong **code generation**: `freezed`, `json_serializable`, `built_value` sinh file `.g.dart` gắn qua `part`.

---

## Privacy (quyền riêng tư)
- Không có từ khóa `public`/`private`.
- Tên bắt đầu bằng `_` là **private với library** chứa nó.
```dart
class _Secret {}   // chỉ thấy trong cùng library
```
- Hệ quả: **không thể export một tên private** — chúng không tồn tại ngoài library. (Các file `part` cùng library thì thấy được `_` của nhau.)

---

## Ghi nhớ nhanh
| Từ khóa | Phục vụ ai | Tác dụng |
|---------|-----------|----------|
| `import` | Nhu cầu của bạn | Kéo tên vào để dùng |
| `export` | Người dùng của bạn | Đẩy tên ra để họ dùng |

- Một file thường vừa `import` phụ thuộc để làm việc, vừa `export` những gì muốn công khai.
- Lint `directives_ordering`: xếp `dart:` → `package:` → đường dẫn tương đối, mỗi nhóm theo bảng chữ cái.
