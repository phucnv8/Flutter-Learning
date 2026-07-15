# Module 01 — Dart Fundamentals

> **Đây là bài giảng mẫu hoàn chỉnh.** Các Module Owner khác dùng khung này để viết module của mình.

## 1. Mục tiêu học (Learning objectives)

Sau module này bạn có thể:

- Khai báo biến với `var`, `final`, `const` và hiểu khác biệt.
- Dùng các kiểu cơ bản: `int`, `double`, `String`, `bool`, `List`, `Map`, `Set`.
- Viết hàm (positional, named, optional, arrow function).
- Dùng control flow: `if/else`, `for`, `while`, `switch`, collection-if/for.
- Hiểu sound type system và null safety ở mức cơ bản.

## 2. Điều kiện cần (Prerequisites)

- Đã cài môi trường (xem `docs/guides/environment-setup.md`).
- Có kinh nghiệm lập trình ở ít nhất một ngôn ngữ khác.

## 3. Nội dung cốt lõi (Core content)

### 3.1 Biến & khai báo

```dart
var name = 'Flutter';      // kiểu suy ra: String
String lang = 'Dart';      // khai báo tường minh
final createdAt = DateTime.now();  // gán 1 lần, runtime
const pi = 3.14159;        // hằng compile-time, bất biến sâu
```

- `var`: kiểu được suy ra, có thể gán lại (cùng kiểu).
- `final`: gán đúng một lần, giá trị biết lúc runtime.
- `const`: hằng biết lúc compile-time; dùng cho literal cố định, tối ưu bộ nhớ.

### 3.2 Kiểu dữ liệu & collection

```dart
List<int> numbers = [1, 2, 3];
Map<String, int> ages = {'an': 25, 'bình': 30};
Set<String> tags = {'dart', 'flutter'};

// collection-if & collection-for (idiom Dart)
final flags = [
  'always',
  if (numbers.isNotEmpty) 'has-numbers',
  for (final n in numbers) 'n$n',
];
```

### 3.3 Hàm

```dart
// positional
int add(int a, int b) => a + b;

// named parameters + required + default
String greet({required String name, String greeting = 'Xin chào'}) {
  return '$greeting, $name!';
}

// optional positional
String join(String a, [String? b]) => b == null ? a : '$a-$b';

void main() {
  print(add(2, 3));                       // 5
  print(greet(name: 'Dart'));             // Xin chào, Dart!
  print(greet(name: 'Dart', greeting: 'Hi'));
}
```

### 3.4 Control flow

```dart
for (final n in numbers) {
  if (n.isEven) {
    print('$n chẵn');
  } else {
    print('$n lẻ');
  }
}

final label = switch (numbers.length) {
  0 => 'rỗng',
  1 => 'một',
  _ => 'nhiều',
};
```

### 3.5 Null safety (giới thiệu)

```dart
String? maybeName;          // có thể null
print(maybeName?.length);   // null-aware, an toàn
print(maybeName ?? 'khách');// giá trị mặc định nếu null
```

## 4. So với ngôn ngữ bạn đã biết (For experienced devs)

| Khái niệm | Dart | Khác gì Java/JS/Python |
|-----------|------|------------------------|
| Kiểu tĩnh | Sound, kiểm tra compile-time | Chặt hơn JS/Python |
| Null | Non-nullable mặc định | Khác Java/JS "mọi thứ nullable" |
| `const` | Compile-time constant, deep-immutable | Mạnh hơn `final` của Java |
| Hàm | First-class, arrow syntax | Giống JS arrow, có named params như Python/kwargs |
| Không có `null` mặc định | Phải khai báo `?` | Khác JS `undefined/null` |

## 5. Bẫy thường gặp (Common pitfalls)

- Nhầm `final` (runtime) với `const` (compile-time) → dùng `const` cho thứ không cố định lúc compile sẽ lỗi.
- Quên `?` khi biến thực sự có thể null → analyzer báo lỗi.
- Dùng `==` cho object mà không override → so sánh reference, không phải giá trị.
- Lạm dụng `!` (bang) làm mất an toàn null.

## 6. Câu hỏi thảo luận (cho buổi chuẩn hóa)

1. Khi nào dùng `final` vs `const`? Cho ví dụ trong dự án thật.
2. Sound null safety giúp/gây khó gì so với ngôn ngữ bạn từng dùng?
3. Named parameters có nên là mặc định cho hàm nhiều tham số không? Vì sao?
4. Có nên bật `require_trailing_commas` cho cả team? Trade-off?

## 7. Bài tập

Làm bài tại [`assignments/module-01-dart-fundamentals/`](../../assignments/module-01-dart-fundamentals/).

## 8. Tài liệu tham khảo

- Dart Language Tour — https://dart.dev/language
- Effective Dart — https://dart.dev/effective-dart
- Null safety — https://dart.dev/null-safety

---

*Phần bổ sung/chỉnh sửa sau buổi chuẩn hóa sẽ được ghi ở cuối file này kèm link Issue thảo luận.*
