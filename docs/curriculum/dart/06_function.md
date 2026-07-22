# Function trong Dart

## 1. Khai báo hàm cơ bản

Hàm gồm: kiểu trả về, tên hàm, danh sách tham số và thân hàm.

```dart
int add(int a, int b) {
  return a + b;
}

void sayHello(String name) {
  print("Xin chào $name");
}
```

Nếu không khai báo kiểu trả về, Dart mặc định là `dynamic` (nên khai báo rõ ràng để code an toàn hơn). Hàm không trả về giá trị dùng `void`.

## 2. Arrow function (hàm mũi tên)

Với hàm chỉ có một biểu thức, dùng cú pháp `=>` gọn hơn. `=> expr` tương đương `{ return expr; }`.

```dart
int add(int a, int b) => a + b;

String greet(String name) => "Chào $name";

bool isEven(int n) => n % 2 == 0;
```

## 3. Các loại tham số

### 3.1. Positional parameters (tham số vị trí — bắt buộc)

Truyền theo đúng thứ tự.

```dart
int subtract(int a, int b) => a - b;
subtract(10, 3); // 7
```

### 3.2. Optional positional parameters (tham số vị trí tùy chọn)

Đặt trong `[ ]`, có thể bỏ qua khi gọi.

```dart
String fullName(String first, [String? last]) {
  if (last != null) return "$first $last";
  return first;
}

fullName("An");          // "An"
fullName("An", "Nguyễn"); // "An Nguyễn"
```

Có thể đặt giá trị mặc định:

```dart
int power(int base, [int exponent = 2]) {
  int result = 1;
  for (int i = 0; i < exponent; i++) result *= base;
  return result;
}

power(3);    // 9 (mũ 2)
power(2, 3); // 8
```

### 3.3. Named parameters (tham số đặt tên)

Đặt trong `{ }`, truyền theo tên (không quan trọng thứ tự). Mặc định là tùy chọn.

```dart
void createUser({String? name, int age = 18}) {
  print("Tên: $name, Tuổi: $age");
}

createUser(name: "An", age: 25);
createUser(age: 30, name: "Bình"); // thứ tự tự do
createUser();                       // Tên: null, Tuổi: 18
```

Dùng `required` để bắt buộc named parameter (đặc biệt với non-nullable):

```dart
void register({required String email, required String password}) {
  print("Đăng ký: $email");
}

register(email: "a@b.com", password: "123");
// register(); // ❌ Lỗi: thiếu required
```

## 4. Kết hợp các loại tham số

```dart
void log(String message, {bool uppercase = false, DateTime? time}) {
  var msg = uppercase ? message.toUpperCase() : message;
  print("[$time] $msg");
}

log("hello");
log("hello", uppercase: true, time: DateTime.now());
```

## 5. Hàm là first-class object

Trong Dart, hàm là "công dân hạng nhất" — có thể gán cho biến, truyền làm tham số, trả về từ hàm khác.

```dart
// Gán hàm cho biến
int Function(int, int) op = add;
print(op(2, 3)); // 5

// Truyền hàm làm tham số
void applyAndPrint(int a, int b, int Function(int, int) fn) {
  print(fn(a, b));
}
applyAndPrint(4, 5, add); // 9
```

## 6. Anonymous function (hàm ẩn danh / lambda)

Hàm không tên, thường truyền trực tiếp vào các phương thức như `map`, `where`, `forEach`.

```dart
var numbers = [1, 2, 3];

// Hàm ẩn danh dạng khối
numbers.forEach((n) {
  print("Số: $n");
});

// Hàm ẩn danh dạng arrow
var doubled = numbers.map((n) => n * 2).toList(); // [2, 4, 6]
```

## 7. Closure (bao đóng)

Closure là hàm "nhớ" được các biến trong phạm vi mà nó được tạo ra, kể cả khi phạm vi đó đã kết thúc.

```dart
Function makeCounter() {
  int count = 0;
  return () {
    count++;
    return count;
  };
}

void main() {
  var counter = makeCounter();
  print(counter()); // 1
  print(counter()); // 2
  print(counter()); // 3 — count được "nhớ" giữa các lần gọi
}
```

## 8. Tham số hàm dạng typedef

`typedef` giúp đặt tên cho một kiểu hàm, code dễ đọc hơn.

```dart
typedef IntOperation = int Function(int a, int b);

int calculate(int x, int y, IntOperation operation) {
  return operation(x, y);
}

void main() {
  print(calculate(10, 5, (a, b) => a + b)); // 15
  print(calculate(10, 5, (a, b) => a - b)); // 5
}
```

## 9. Giá trị trả về

- Hàm không có `return` (hoặc `return;` trần) trả về `null`.
- Hàm khai báo `void` không dùng để lấy giá trị.

```dart
int? findFirst(List<int> list, bool Function(int) test) {
  for (var item in list) {
    if (test(item)) return item;
  }
  return null; // không tìm thấy
}
```

## 10. Hàm main

Điểm khởi đầu của mọi chương trình Dart là hàm `main`. Có thể nhận tham số dòng lệnh.

```dart
void main() {
  print("Chương trình bắt đầu");
}

// Nhận tham số dòng lệnh
void main(List<String> args) {
  print("Tham số: $args");
}
```
