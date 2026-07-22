# 10. Constructor Nâng Cao

### 10.1 Named Constructor (Constructor có tên)

Dart cho phép định nghĩa nhiều constructor trong một class bằng cách đặt tên cho chúng.

```dart
class Point {
  double x, y;

  // Default constructor
  Point(this.x, this.y);

  // Named constructor
  Point.origin()
      : x = 0,
        y = 0;

  Point.fromJson(Map<String, double> json)
      : x = json['x']!,
        y = json['y']!;

  @override
  String toString() => 'Point($x, $y)';
}

void main() {
  final p1 = Point(3, 4);
  final p2 = Point.origin();
  final p3 = Point.fromJson({'x': 1.0, 'y': 2.0});

  print(p1); // Point(3.0, 4.0)
  print(p2); // Point(0.0, 0.0)
  print(p3); // Point(1.0, 2.0)
}
```

### 10.2 Initializer List (Danh sách khởi tạo)

Phần sau dấu `:` và trước thân constructor — chạy trước khi thân constructor thực thi, thường dùng để validate hoặc gán `final` field.

```dart
class Triangle {
  final double a, b, c;
  final double perimeter;

  Triangle(this.a, this.b, this.c)
      : assert(a > 0 && b > 0 && c > 0, 'Các cạnh phải dương'),
        assert(a + b > c && a + c > b && b + c > a, 'Không hợp lệ'),
        perimeter = a + b + c;
}

void main() {
  final t = Triangle(3, 4, 5);
  print(t.perimeter); // 12.0
}
```

### 10.3 Redirecting Constructor

Một constructor gọi constructor khác trong cùng class:

```dart
class Color {
  final int r, g, b;

  Color(this.r, this.g, this.b);

  // Redirect sang constructor chính
  Color.black() : this(0, 0, 0);
  Color.white() : this(255, 255, 255);
  Color.grey(int shade) : this(shade, shade, shade);
}

void main() {
  final black = Color.black();
  final grey = Color.grey(128);
  print('${grey.r}, ${grey.g}, ${grey.b}'); // 128, 128, 128
}
```

### 10.4 Factory Constructor

`factory` constructor không tạo instance mới trực tiếp — nó kiểm soát việc tạo object (cache, singleton, polymorphism):

```dart
class Logger {
  final String name;
  static final Map<String, Logger> _cache = {};

  // Private constructor thực sự
  Logger._internal(this.name);

  // Factory trả về instance có sẵn hoặc tạo mới
  factory Logger(String name) {
    return _cache.putIfAbsent(name, () => Logger._internal(name));
  }

  void log(String msg) => print('[$name] $msg');
}

void main() {
  final a = Logger('Auth');
  final b = Logger('Auth');
  print(identical(a, b)); // true — cùng 1 instance
}
```

Factory constructor cũng dùng cho subclass polymorphism:

```dart
abstract class Shape {
  factory Shape(String type) {
    switch (type) {
      case 'circle':
        return Circle(1.0);
      case 'square':
        return Square(1.0);
      default:
        throw ArgumentError('Unknown shape: $type');
    }
  }

  double area();
}

class Circle implements Shape {
  final double radius;
  Circle(this.radius);
  @override
  double area() => 3.14159 * radius * radius;
}

class Square implements Shape {
  final double side;
  Square(this.side);
  @override
  double area() => side * side;
}
```

### 10.5 Constant Constructor (`const`)

Tạo compile-time constant objects — mọi field phải là `final`:

```dart
class Celsius {
  final double temperature;
  const Celsius(this.temperature);
}

void main() {
  const freezing = Celsius(0);
  const alsoFreezing = Celsius(0);
  print(identical(freezing, alsoFreezing)); // true — cùng 1 object
}
```

> **Lưu ý**: `const` constructor chỉ hiệu quả khi dùng với từ khóa `const` khi tạo object. Nếu dùng `new Celsius(0)` hoặc `Celsius(0)` thì không có constant optimization.
