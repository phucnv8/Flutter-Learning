# 21. Dart 3 — Sealed Class & Exhaustiveness

### 21.1 Sealed Class là gì?

`sealed` class là một class mà **tất cả subclass của nó phải được định nghĩa trong cùng một file**. Điều này cho phép compiler biết đầy đủ mọi case có thể xảy ra và kiểm tra exhaustiveness trong switch.

```dart
// Tất cả phải trong cùng 1 file
sealed class Shape {}

class Circle extends Shape {
  final double radius;
  Circle(this.radius);
}

class Rectangle extends Shape {
  final double width, height;
  Rectangle(this.width, this.height);
}

class Triangle extends Shape {
  final double base, height;
  Triangle(this.base, this.height);
}
```

### 21.2 Exhaustive Switch

```dart
double area(Shape shape) => switch (shape) {
  Circle(:final radius)                  => 3.14159 * radius * radius,
  Rectangle(:final width, :final height) => width * height,
  Triangle(:final base, :final height)   => 0.5 * base * height,
  // Không cần default — compiler biết tất cả cases đã được cover!
};
```

Nếu bạn thêm `class Pentagon extends Shape` trong file, compiler **ngay lập tức báo lỗi** ở mọi switch expression thiếu case `Pentagon`. Đây là tính năng cực kỳ mạnh để đảm bảo safety.

### 21.3 Sealed Class vs Abstract Class

|                               | `abstract class`     | `sealed class`             |
| ----------------------------- | -------------------- | -------------------------- |
| Extend ở file khác            | Cho phép             | **Không cho phép**         |
| Compiler biết tất cả subclass | Không                | **Có**                     |
| Switch exhaustiveness         | Cần `default`        | **Tự động kiểm tra**       |
| Dùng khi nào                  | Extensible hierarchy | **Closed set of variants** |

### 21.4 Sealed Class làm Result Type

```dart
sealed class ApiResult<T> {}

class ApiSuccess<T> extends ApiResult<T> {
  final T data;
  const ApiSuccess(this.data);
}

class ApiError<T> extends ApiResult<T> {
  final String message;
  final int statusCode;
  const ApiError(this.message, this.statusCode);
}

class ApiLoading<T> extends ApiResult<T> {
  const ApiLoading();
}

// Xử lý exhaustive — compiler đảm bảo không bỏ sót case nào

Widget buildFromResult(ApiResult<User> result) => switch (result) {
  ApiSuccess(:final data)    => UserCard(data),
  ApiError(:final message)   => ErrorWidget(message),
  ApiLoading()               => const CircularProgressIndicator(),
};
```

### 21.5 Pattern matching sâu với sealed class

```dart
sealed class Expr {}
class Num extends Expr { final double value; Num(this.value); }
class Add extends Expr { final Expr left, right; Add(this.left, this.right); }
class Mul extends Expr { final Expr left, right; Mul(this.left, this.right); }

double eval(Expr expr) => switch (expr) {
  Num(:final value)              => value,
  Add(:final left, :final right) => eval(left) + eval(right),
  Mul(:final left, :final right) => eval(left) * eval(right),
};

void main() {
  // (2 + 3) * 4 = 20
  final e = Mul(Add(Num(2), Num(3)), Num(4));
  print(eval(e)); // 20.0
}
```
