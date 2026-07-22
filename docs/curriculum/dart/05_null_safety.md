# Null Safety trong Dart

## 1. Null Safety là gì?

Null Safety (an toàn null) là cơ chế giúp Dart phân biệt rõ ràng giữa biến **có thể chứa `null`** và biến **không được phép chứa `null`** ngay từ lúc biên dịch (compile-time). Mục tiêu là loại bỏ lỗi kinh điển "Null Reference Error" (hay `NoSuchMethodError` khi gọi method trên `null`).

Từ Dart 2.12 trở đi, Null Safety là mặc định (sound null safety). "Sound" nghĩa là nếu trình biên dịch xác định một biến không phải null, thì tại runtime nó **chắc chắn** không bao giờ là null.

Lợi ích chính:

- Bắt lỗi null ngay khi viết code thay vì lúc chạy.
- Giúp compiler tối ưu hóa tốt hơn (biết chắc biến không null).
- Code rõ ràng hơn về mặt ý định (biến nào cho phép null, biến nào không).

## 2. Kiểu non-nullable và nullable

Mặc định mọi kiểu đều là **non-nullable** (không được gán null).

```dart
int a = 10;
a = null; // ❌ Lỗi biên dịch: không thể gán null cho int non-nullable
```

Muốn cho phép null, thêm dấu `?` sau kiểu để tạo **nullable type**:

```dart
int? b = 10;
b = null; // ✅ Hợp lệ
```

| Kiểu | Có thể null? | Ví dụ |
|------|--------------|-------|
| `int` | Không | `int x = 5;` |
| `int?` | Có | `int? x = null;` |
| `String` | Không | `String s = "hi";` |
| `String?` | Có | `String? s = null;` |

## 3. Các toán tử liên quan Null Safety

### 3.1. `?.` — Toán tử truy cập an toàn (null-aware access)

Nếu đối tượng là null thì biểu thức trả về null thay vì ném lỗi.

```dart
String? name;
print(name?.length); // In ra: null (không lỗi)

name = "Dart";
print(name?.length); // In ra: 4
```

### 3.2. `??` — Toán tử giá trị mặc định (if-null)

Trả về vế trái nếu khác null, ngược lại trả về vế phải.

```dart
String? name;
String result = name ?? "Khách"; // "Khách" vì name là null
print(result);
```

### 3.3. `??=` — Gán nếu đang null

Chỉ gán giá trị khi biến hiện đang null.

```dart
int? score;
score ??= 0; // score = 0
score ??= 100; // Không thay đổi vì score đã khác null
print(score); // 0
```

### 3.4. `!` — Toán tử khẳng định không null (null assertion / bang operator)

Ép compiler tin rằng giá trị không null. **Nguy hiểm**: nếu thực tế là null sẽ ném exception tại runtime.

```dart
int? value = 10;
int x = value!; // OK vì value khác null

int? y;
int z = y!; // ❌ Runtime error: Null check operator used on a null value
```

Chỉ dùng `!` khi bạn chắc chắn 100% giá trị không null.

## 4. Từ khóa `late`

`late` khai báo một biến non-nullable nhưng sẽ được khởi tạo **sau** (lazy initialization). Dùng khi bạn chắc chắn biến sẽ có giá trị trước khi được sử dụng.

```dart
late String description;

void main() {
  description = "Đây là mô tả";
  print(description); // OK
}
```

Nếu truy cập biến `late` trước khi gán → ném `LateInitializationError`.

`late` cũng dùng cho khởi tạo lười (chỉ tính toán khi được truy cập lần đầu):

```dart
late String data = _expensiveComputation(); // chỉ chạy khi data được dùng
```

## 5. `required` cho tham số bắt buộc

Với named parameter non-nullable, phải đánh dấu `required` để đảm bảo người gọi luôn truyền giá trị.

```dart
void createUser({required String name, int? age}) {
  print("Tên: $name, Tuổi: ${age ?? 'chưa rõ'}");
}

createUser(name: "An"); // OK
createUser(); // ❌ Lỗi: thiếu tham số required 'name'
```

## 6. Flow analysis (phân tích luồng)

Compiler tự động "thu hẹp" kiểu nullable thành non-nullable sau khi bạn kiểm tra null.

```dart
String? name;

void printName() {
  if (name != null) {
    // Trong khối này, compiler hiểu name là String (không null)
    print(name.length); // Không cần dùng ! hay ?.
  }
}
```

Lưu ý: flow analysis hoạt động tốt với biến cục bộ. Với biến instance của class (field), compiler thường không thể đảm bảo nó không thay đổi giữa chừng nên bạn có thể cần gán vào biến local trước:

```dart
class MyClass {
  String? name;

  void show() {
    final n = name;
    if (n != null) {
      print(n.length); // an toàn
    }
  }
}
```

## 7. Danh sách và null

```dart
List<int> a = [1, 2, 3];      // list không null, phần tử không null
List<int?> b = [1, null, 3];  // list không null, phần tử có thể null
List<int>? c;                 // list có thể null, phần tử không null
List<int?>? d;                // cả hai đều có thể null
```

## 8. Tóm tắt nhanh

| Ký hiệu | Ý nghĩa |
|---------|---------|
| `Type?` | Kiểu cho phép null |
| `?.` | Truy cập an toàn, trả null nếu đối tượng null |
| `??` | Giá trị mặc định khi null |
| `??=` | Gán khi đang null |
| `!` | Khẳng định không null (rủi ro runtime) |
| `late` | Khởi tạo trễ biến non-nullable |
| `required` | Named parameter bắt buộc |
