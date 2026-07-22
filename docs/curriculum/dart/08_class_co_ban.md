# Class cơ bản trong Dart

Dart là ngôn ngữ hướng đối tượng (OOP). Class là bản thiết kế (blueprint) để tạo ra các đối tượng (object/instance).

## 1. Khai báo class và tạo đối tượng

```dart
class Person {
  String name = "";
  int age = 0;
}

void main() {
  var p = Person();   // tạo đối tượng (không cần từ khóa 'new')
  p.name = "An";
  p.age = 25;
  print(p.name);      // An
}
```

## 2. Constructor (hàm khởi tạo)

### 2.1. Constructor cơ bản

```dart
class Person {
  String name;
  int age;

  Person(this.name, this.age); // gán trực tiếp qua this
}

var p = Person("An", 25);
```

### 2.2. Named constructor (constructor có tên)

Cho phép tạo nhiều cách khởi tạo khác nhau.

```dart
class Point {
  double x, y;

  Point(this.x, this.y);

  // Constructor có tên
  Point.origin() : x = 0, y = 0;

  Point.fromJson(Map<String, double> json)
      : x = json['x']!,
        y = json['y']!;
}

var a = Point(3, 4);
var b = Point.origin();          // (0, 0)
var c = Point.fromJson({'x': 1, 'y': 2});
```

### 2.3. Named & optional parameters trong constructor

```dart
class User {
  String name;
  int age;
  String? email;

  User({required this.name, this.age = 18, this.email});
}

var u = User(name: "Bình", age: 30, email: "b@mail.com");
```

### 2.4. Initializer list

Chạy trước thân constructor, dùng để khởi tạo field final hoặc kiểm tra điều kiện.

```dart
class Rectangle {
  final double width, height;
  final double area;

  Rectangle(this.width, this.height) : area = width * height;
}
```

## 3. Instance variables và methods

```dart
class BankAccount {
  double balance = 0; // instance variable

  // method
  void deposit(double amount) {
    balance += amount;
  }

  bool withdraw(double amount) {
    if (amount > balance) return false;
    balance -= amount;
    return true;
  }
}

var acc = BankAccount();
acc.deposit(100);
acc.withdraw(30);
print(acc.balance); // 70
```

## 4. Getters và Setters

Cho phép truy cập/gán field như thuộc tính nhưng có xử lý logic bên trong.

```dart
class Circle {
  double radius;

  Circle(this.radius);

  // getter - tính toán khi truy cập
  double get area => 3.14159 * radius * radius;
  double get diameter => radius * 2;

  // setter
  set diameter(double value) {
    radius = value / 2;
  }
}

var c = Circle(5);
print(c.area);      // 78.53975 (gọi như thuộc tính, không có ())
c.diameter = 20;    // gọi setter
print(c.radius);    // 10
```

## 5. Final và Static

### Final field (chỉ gán một lần)

```dart
class Config {
  final String appName;
  Config(this.appName);
}
```

### Static (thuộc về class, không thuộc về instance)

```dart
class MathHelper {
  static const double pi = 3.14159; // hằng số static
  static int count = 0;             // biến static

  static int square(int n) => n * n; // phương thức static
}

print(MathHelper.pi);        // truy cập qua tên class
print(MathHelper.square(5)); // 25
```

## 6. Kế thừa (Inheritance) với `extends`

Class con kế thừa thuộc tính và phương thức của class cha.

```dart
class Animal {
  String name;
  Animal(this.name);

  void eat() => print("$name đang ăn");
  void makeSound() => print("...");
}

class Dog extends Animal {
  Dog(String name) : super(name); // gọi constructor cha

  @override
  void makeSound() => print("$name: Gâu gâu!"); // ghi đè
}

void main() {
  var d = Dog("Kiki");
  d.eat();        // Kiki đang ăn (kế thừa)
  d.makeSound();  // Kiki: Gâu gâu! (override)
}
```

- `super` truy cập thành viên của class cha.
- `@override` đánh dấu phương thức được ghi đè (giúp compiler kiểm tra).

## 7. Abstract class (lớp trừu tượng)

Không thể tạo instance trực tiếp, dùng làm khuôn mẫu cho class con. Có thể chứa method chưa có thân (abstract method).

```dart
abstract class Shape {
  double area(); // abstract method - class con phải triển khai

  void describe() {
    print("Diện tích: ${area()}");
  }
}

class Square extends Shape {
  double side;
  Square(this.side);

  @override
  double area() => side * side;
}

void main() {
  var s = Square(4);
  s.describe(); // Diện tích: 16.0
}
```

## 8. Interface & `implements`

Trong Dart, mọi class đều có thể dùng làm interface. `implements` buộc phải triển khai lại **toàn bộ** thành viên.

```dart
class Flyable {
  void fly() => print("Đang bay");
}

class Bird implements Flyable {
  @override
  void fly() => print("Chim bay lượn"); // bắt buộc triển khai
}
```

## 9. Mixin với `with`

Mixin cho phép tái sử dụng code giữa nhiều class mà không cần kế thừa.

```dart
mixin Swimmer {
  void swim() => print("Đang bơi");
}

mixin Runner {
  void run() => print("Đang chạy");
}

class Athlete with Swimmer, Runner {}

void main() {
  var a = Athlete();
  a.swim(); // Đang bơi
  a.run();  // Đang chạy
}
```

## 10. toString() và override

Ghi đè `toString()` để hiển thị đối tượng dễ đọc.

```dart
class Person {
  String name;
  int age;
  Person(this.name, this.age);

  @override
  String toString() => "Person(name: $name, age: $age)";
}

void main() {
  var p = Person("An", 25);
  print(p); // Person(name: An, age: 25)
}
```

## 11. Tóm tắt từ khóa quan trọng

| Từ khóa | Ý nghĩa |
|---------|---------|
| `class` | Định nghĩa lớp |
| `extends` | Kế thừa (một lớp) |
| `implements` | Triển khai interface |
| `with` | Trộn mixin |
| `abstract` | Lớp/method trừu tượng |
| `super` | Truy cập lớp cha |
| `this` | Tham chiếu đối tượng hiện tại |
| `static` | Thành viên của lớp |
| `final` | Gán một lần |
| `@override` | Đánh dấu ghi đè |
| `get` / `set` | Getter / Setter |
