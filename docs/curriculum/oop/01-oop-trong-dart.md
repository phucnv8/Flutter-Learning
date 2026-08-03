# OOP và Biểu Hiện Của Nó Trong Dart

> Tài liệu giảng dạy — Lớp Flutter
> Mục tiêu: Hiểu bản chất của Lập trình Hướng đối tượng (OOP) và cách Dart hiện thực hóa từng khái niệm. Tài liệu nhấn mạnh *tại sao* Dart thiết kế như vậy, không chỉ *cú pháp*.

---

## Mục lục

1. [OOP là gì và tại sao cần OOP](#1-oop-là-gì-và-tại-sao-cần-oop)
2. [Class và Object](#2-class-và-object)
3. [Constructor — trái tim của việc khởi tạo](#3-constructor--trái-tim-của-việc-khởi-tạo)
4. [Encapsulation (Đóng gói)](#4-encapsulation-đóng-gói)
5. [Inheritance (Kế thừa)](#5-inheritance-kế-thừa)
6. [Abstraction (Trừu tượng hóa)](#6-abstraction-trừu-tượng-hóa)
7. [Interface trong Dart](#7-interface-trong-dart)
8. [Polymorphism (Đa hình)](#8-polymorphism-đa-hình)
9. [Mixin — đặc sản của Dart](#9-mixin--đặc-sản-của-dart)
10. [Static members](#10-static-members)
11. [Generics](#11-generics)
12. [Enum nâng cao](#12-enum-nâng-cao)
13. [Object equality: `==` và `hashCode`](#13-object-equality--và-hashcode)
14. [Extension methods & operator overloading](#14-extension-methods--operator-overloading)
15. [Nguyên tắc SOLID (tóm tắt)](#15-nguyên-tắc-solid-tóm-tắt)
16. [Tổng kết bảng đối chiếu](#16-tổng-kết-bảng-đối-chiếu)

---

## 1. OOP là gì và tại sao cần OOP

**Lập trình hướng đối tượng** là cách tổ chức code quanh các *đối tượng* — những thực thể gói chung **dữ liệu** (state) và **hành vi** (behavior) tác động lên dữ liệu đó.

Trước OOP, code thường tổ chức theo lối thủ tục: dữ liệu nằm một nơi, hàm xử lý nằm một nơi. Khi hệ thống lớn lên, ta khó biết hàm nào được phép chạm vào dữ liệu nào, và một thay đổi nhỏ có thể lan ra khắp nơi.

OOP giải quyết điều đó bằng bốn trụ cột:

| Trụ cột | Câu hỏi nó trả lời |
|---|---|
| **Encapsulation** | Ai được phép chạm vào dữ liệu này? |
| **Abstraction** | Người dùng cần biết gì, và được phép giấu gì? |
| **Inheritance** | Làm sao tái sử dụng và mở rộng cái đã có? |
| **Polymorphism** | Làm sao xử lý nhiều loại đối tượng khác nhau bằng cùng một cách gọi? |

Trong Flutter, mọi thứ bạn thấy đều là biểu hiện của OOP: `Widget` là một lớp trừu tượng, `StatelessWidget` và `StatefulWidget` kế thừa từ nó, và bạn *override* phương thức `build()` — đó chính là đa hình.

---

## 2. Class và Object

**Class** là bản thiết kế (blueprint). **Object** là một thể hiện (instance) cụ thể được tạo ra từ bản thiết kế đó.

```dart
class Point {
  double x;
  double y;

  Point(this.x, this.y);

  double distanceToOrigin() {
    return math.sqrt(x * x + y * y);
  }
}

void main() {
  final p = Point(3, 4);        // p là một object
  print(p.distanceToOrigin());  // 5.0
}
```

**Điểm Dart-đặc-thù cần nhớ:**

- Trong Dart, **mọi thứ đều là object**, kể cả `int`, `bool`, `null` và cả hàm. Không có kiểu "nguyên thủy" tách biệt như Java. `3` là một object của lớp `int`, và `int` kế thừa từ `Object`.
- Gốc của mọi class là `Object` (và trên nữa là `Object?` khi tính cả null safety).
- Từ khóa `new` **không bắt buộc** (và ngày nay được khuyến nghị bỏ hẳn): viết `Point(3, 4)` thay vì `new Point(3, 4)`.

---

## 3. Constructor — trái tim của việc khởi tạo

Đây là phần Dart phong phú hơn nhiều ngôn ngữ khác, nên ta dừng lại kỹ.

### 3.1. Generative constructor (constructor thường)

```dart
class User {
  final String name;
  final int age;

  // Cú pháp `this.field` gán trực tiếp tham số vào field.
  User(this.name, this.age);
}
```

### 3.2. Named constructor

Dart không cho overload constructor bằng cách trùng tên khác tham số như Java. Thay vào đó Dart dùng **constructor có tên** — rõ nghĩa hơn nhiều:

```dart
class User {
  final String name;
  final int age;

  User(this.name, this.age);

  User.guest() : name = 'Guest', age = 0;              // named constructor
  User.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        age = json['age'] as int;
}

final u1 = User('An', 20);
final u2 = User.guest();
final u3 = User.fromJson({'name': 'Bình', 'age': 25});
```

> **Tại sao thiết kế thế này?** Vì `User.fromJson(...)` tự mô tả ý định rõ ràng hơn nhiều so với việc đoán xem overload nào đang được gọi. Đây là một ví dụ cho triết lý "code dễ đọc" của Dart.

### 3.3. Initializer list

Phần sau dấu `:` chạy **trước** thân constructor và được dùng để khởi tạo `final` field, gọi `assert`, hoặc chuyển hóa dữ liệu:

```dart
class Temperature {
  final double celsius;

  Temperature.fromFahrenheit(double f)
      : celsius = (f - 32) * 5 / 9,
        assert(f > -459.67, 'Dưới độ 0 tuyệt đối');
}
```

### 3.4. Redirecting constructor

Một constructor có thể chuyển hướng sang constructor khác cùng lớp để tránh lặp code:

```dart
class Rectangle {
  final double width;
  final double height;

  Rectangle(this.width, this.height);

  Rectangle.square(double size) : this(size, size); // redirect
}
```

### 3.5. Const constructor

Nếu một object là bất biến (immutable) hoàn toàn, ta cho phép nó trở thành **hằng số biên dịch**. Đây là lý do trong Flutter ta viết `const Text('Hello')` — nó giúp Flutter tái sử dụng widget và tối ưu rebuild.

```dart
class Coordinate {
  final double lat;
  final double lng;

  const Coordinate(this.lat, this.lng); // mọi field phải là final
}

const a = Coordinate(10.7, 106.6);
const b = Coordinate(10.7, 106.6);
print(identical(a, b)); // true — Dart canonicalize và tái sử dụng cùng một instance
```

### 3.6. Factory constructor — điểm hay bị hiểu nhầm

Constructor thường **bắt buộc** tạo ra một instance mới của chính lớp đó. `factory` phá bỏ ràng buộc này: nó *không cần* tạo object mới — nó có thể trả về object đã cache, trả về một instance của lớp con, hoặc quyết định kiểu trả về lúc runtime.

```dart
class Shape {
  const Shape();

  factory Shape.fromName(String name) {
    switch (name) {
      case 'circle':
        return Circle();
      case 'square':
        return Square();
      default:
        throw ArgumentError('Không rõ hình: $name');
    }
  }
}

class Circle extends Shape {}
class Square extends Shape {}
```

Ở đây `Shape.fromName('circle')` trả về một `Circle` — đây gọi là **factory dispatch**. Đó là lý do `factory` không được phép truy cập `this`: tại thời điểm chạy factory, chưa chắc có instance nào của `Shape` tồn tại.

Một ứng dụng phổ biến khác là **singleton/cache**:

```dart
class Logger {
  static final Logger _instance = Logger._internal();
  Logger._internal();               // private named constructor
  factory Logger() => _instance;    // luôn trả về cùng một instance
}
```

### 3.7. Constructor trong abstract class — "tại sao lại được phép?"

Nhiều học viên thắc mắc: "Abstract class không tạo được object, vậy sao vẫn viết constructor?"

Lý do: constructor của abstract class **không dùng để tạo object của chính nó**, mà để **lớp con gọi lên qua `super`** nhằm khởi tạo phần state chung.

```dart
abstract class Animal {
  final String name;
  Animal(this.name);           // constructor này tồn tại để lớp con gọi super

  void makeSound();            // phương thức trừu tượng
}

class Dog extends Animal {
  Dog(String name) : super(name);
  @override
  void makeSound() => print('$name: Gâu gâu');
}
```

---

## 4. Encapsulation (Đóng gói)

Đóng gói = che giấu trạng thái nội bộ và chỉ để lộ những gì cần thiết, qua một giao diện có kiểm soát.

**Điểm Dart-đặc-thù quan trọng nhất:** Dart **không có** từ khóa `private`, `public`, `protected`. Thay vào đó, quy ước là:

> Định danh bắt đầu bằng dấu gạch dưới `_` sẽ **private ở phạm vi library**, không phải phạm vi class.

"Library-private" nghĩa là: mọi thứ trong cùng một file (chính xác hơn là cùng một library) đều thấy được `_field`, còn code ở file khác thì không.

```dart
class BankAccount {
  double _balance = 0;              // private ở library

  double get balance => _balance;   // getter — để lộ chỉ-đọc

  void deposit(double amount) {
    if (amount <= 0) throw ArgumentError('Số tiền phải dương');
    _balance += amount;             // chỉ hàm này được sửa _balance
  }
}
```

### Getter và setter

Getter/setter cho phép ta *trông giống như* truy cập field nhưng thực chất chạy logic:

```dart
class Circle {
  double radius;
  Circle(this.radius);

  double get area => math.pi * radius * radius; // computed getter, không tốn bộ nhớ lưu trữ

  set diameter(double d) => radius = d / 2;      // setter
}

final c = Circle(5);
print(c.area);      // gọi như field, nhưng là hàm tính
c.diameter = 20;    // gọi setter
```

> **Mẹo thiết kế:** Bắt đầu bằng field public đơn giản. Chỉ chuyển sang getter/setter khi cần thêm logic. Vì cú pháp gọi giống hệt nhau, việc đổi field thành getter *không phá vỡ* code phía người dùng — đây là lợi thế lớn của Dart.

---

## 5. Inheritance (Kế thừa)

Kế thừa cho phép một lớp con `extends` lớp cha để tái sử dụng và mở rộng.

```dart
class Vehicle {
  final String brand;
  Vehicle(this.brand);

  void start() => print('$brand khởi động');
}

class Car extends Vehicle {
  final int seats;

  Car(String brand, this.seats) : super(brand); // gọi constructor cha

  @override
  void start() {
    super.start();               // gọi lại logic cha nếu cần
    print('Xe $seats chỗ sẵn sàng');
  }
}
```

**Nguyên tắc quan trọng:**

- Dart chỉ cho **kế thừa đơn** (single inheritance) — một lớp chỉ `extends` được một lớp. (Muốn "đa kế thừa hành vi" thì dùng mixin, xem mục 9.)
- `super(...)` phải là **lời gọi đầu tiên** trong initializer list.
- Ưu tiên **composition over inheritance**: nếu quan hệ không thật sự là "is-a" thì hãy chứa object khác làm field thay vì kế thừa. Ví dụ `Car` *có* một `Engine` (composition) chứ không *là* một `Engine`.

---

## 6. Abstraction (Trừu tượng hóa)

Trừu tượng hóa = định nghĩa *cái gì* phải làm mà không nói *làm như thế nào*, để lại phần hiện thực cho lớp con.

```dart
abstract class Repository<T> {
  Future<T?> findById(String id);   // chỉ có chữ ký, không có thân
  Future<void> save(T item);
}

class UserRepository extends Repository<User> {
  @override
  Future<User?> findById(String id) async { /* gọi API/DB thật */ }

  @override
  Future<void> save(User item) async { /* ... */ }
}
```

- Không thể `Repository()` trực tiếp — abstract class không tạo được instance.
- Lớp con **bắt buộc** hiện thực mọi phương thức trừu tượng, nếu không sẽ lỗi biên dịch.
- Abstract class *vẫn có thể* chứa phương thức có sẵn thân (concrete method) và field — dùng để chia sẻ code chung.

> Trong Flutter, `Widget` chính là một abstract class. Bạn không bao giờ tạo `Widget()` trực tiếp; bạn tạo `StatelessWidget`/`StatefulWidget` và hiện thực `build()`.

---

## 7. Interface trong Dart

Đây là chỗ Dart khác biệt lớn: **Dart không có từ khóa `interface`.**

Thay vào đó: **mọi class đều tự động định nghĩa một "interface ngầm" (implicit interface)** gồm toàn bộ phương thức và getter/setter public của nó. Muốn dùng một class *như một interface*, bạn dùng `implements` thay cho `extends`.

Khác biệt cốt lõi giữa `extends` và `implements`:

| | `extends` | `implements` |
|---|---|---|
| Kế thừa phần **hiện thực** (code thân hàm)? | Có | **Không** |
| Phải viết lại **tất cả** phương thức? | Không (chỉ override khi cần) | **Có, tất cả** |
| Được `super`? | Có | Không |
| Số lượng cho phép | 1 | Nhiều |

```dart
class Duck {
  void swim() => print('Bơi');
  void fly()  => print('Bay');
}

// Robot không phải là con vịt, nhưng ta muốn nó "cư xử như" vịt.
class RobotDuck implements Duck {
  @override
  void swim() => print('Bơi bằng động cơ');   // BẮT BUỘC viết lại
  @override
  void fly()  => print('Bay bằng cánh quạt');  // BẮT BUỘC viết lại
}
```

Từ Dart 3, bạn có thể tạo interface "thuần" rõ ràng hơn bằng modifier `interface class` hoặc dùng `abstract interface class` để cấm việc `extends`, chỉ cho phép `implements`.

---

## 8. Polymorphism (Đa hình)

Đa hình = "nhiều hình dạng": cùng một lời gọi phương thức nhưng cho ra hành vi khác nhau tùy kiểu thực tế của object lúc runtime.

```dart
abstract class Shape {
  double area();
}

class Circle extends Shape {
  final double r;
  Circle(this.r);
  @override
  double area() => math.pi * r * r;
}

class Rectangle extends Shape {
  final double w, h;
  Rectangle(this.w, this.h);
  @override
  double area() => w * h;
}

void printArea(Shape shape) {   // nhận Shape, không cần biết loại cụ thể
  print('Diện tích: ${shape.area()}');
}

void main() {
  final shapes = <Shape>[Circle(2), Rectangle(3, 4)];
  for (final s in shapes) {
    printArea(s);   // gọi đúng area() của từng loại — dynamic dispatch
  }
}
```

**Ba điều cần nắm:**

1. **`@override`** không bắt buộc nhưng nên luôn dùng: nó giúp compiler cảnh báo nếu bạn gõ sai tên phương thức cha.
2. Dart dùng **dynamic dispatch**: quyết định gọi `Circle.area()` hay `Rectangle.area()` xảy ra lúc chạy, dựa trên kiểu thực của object.
3. `covariant` cho phép thu hẹp kiểu tham số khi override — dùng khi bạn chắc chắn về mặt logic:

```dart
class Animal {}
class Cat extends Animal {}

class AnimalShelter {
  void adopt(Animal a) {}
}
class CatShelter extends AnimalShelter {
  @override
  void adopt(covariant Cat c) {} // thu hẹp Animal -> Cat
}
```

---

## 9. Mixin — đặc sản của Dart

Vấn đề: Dart chỉ cho kế thừa đơn. Nhưng đôi khi bạn muốn "trộn" hành vi từ nhiều nguồn vào một lớp mà không lập quan hệ cha-con. **Mixin** giải quyết điều này.

```dart
mixin Swimmer {
  void swim() => print('Đang bơi');
}

mixin Flyer {
  void fly() => print('Đang bay');
}

class Duck with Swimmer, Flyer {}   // trộn cả hai khả năng

void main() {
  Duck().swim();
  Duck().fly();
}
```

**Điểm cần nhớ:**

- Mixin **không có constructor** — nó không phải là kiểu để khởi tạo, mà là "gói hành vi" gắn vào lớp khác.
- Có thể ràng buộc mixin chỉ dùng cho lớp con của một kiểu nào đó bằng `on`:

```dart
mixin Sortable on Comparable {
  // chỉ class nào đã là Comparable mới trộn được Sortable
}
```

- Thứ tự khai báo `with A, B` quyết định thứ tự "linearization" — nếu A và B cùng có phương thức trùng tên, cái khai báo sau ghi đè cái trước.
- Trong Flutter bạn gặp mixin liên tục: `SingleTickerProviderStateMixin`, `WidgetsBindingObserver`, `AutomaticKeepAliveClientMixin`...

**So sánh nhanh ba từ khóa:**

| Từ khóa | Mục đích | Lấy code hiện thực? | Số lượng |
|---|---|---|---|
| `extends` | Là một (is-a), kế thừa | Có | 1 |
| `implements` | Cư xử như (giao diện) | Không | Nhiều |
| `with` | Có thêm khả năng (mixin) | Có | Nhiều |

---

## 10. Static members

Thành viên `static` thuộc về **lớp**, không thuộc về từng object. Dùng cho hằng số, hàm tiện ích, hoặc trạng thái dùng chung.

```dart
class MathUtils {
  static const double pi = 3.14159;

  static double square(double x) => x * x; // gọi qua lớp, không cần instance
}

print(MathUtils.pi);
print(MathUtils.square(5));
```

- Không truy cập được `this` bên trong `static`.
- Đừng lạm dụng static để lưu state — nó dễ tạo ra trạng thái toàn cục khó test.

---

## 11. Generics

Generics cho phép viết code hoạt động với nhiều kiểu mà vẫn giữ được an toàn kiểu (type-safe), tránh phải ép kiểu thủ công.

```dart
class Box<T> {
  final T value;
  Box(this.value);

  T get content => value;
}

final intBox = Box<int>(42);       // T = int
final strBox = Box<String>('hi');  // T = String
```

**Ràng buộc kiểu (bounded type):**

```dart
// T bắt buộc là con của Comparable
T largest<T extends Comparable<T>>(List<T> items) {
  var max = items.first;
  for (final item in items) {
    if (item.compareTo(max) > 0) max = item;
  }
  return max;
}
```

Bạn đã dùng generics mỗi ngày: `List<int>`, `Map<String, User>`, `Future<Response>` đều là generic.

---

## 12. Enum nâng cao

Dart 2.17+ hỗ trợ **enhanced enum**: enum có thể có field, constructor, phương thức — mạnh hơn nhiều so với "danh sách hằng số" truyền thống.

```dart
enum Planet {
  mercury(mass: 3.3e23, radius: 2439.7),
  earth(mass: 5.97e24, radius: 6371.0);

  const Planet({required this.mass, required this.radius});

  final double mass;
  final double radius;

  double get surfaceGravity => 6.67e-11 * mass / (radius * radius);
}

void main() {
  print(Planet.earth.surfaceGravity);
  print(Planet.values);         // liệt kê toàn bộ
  print(Planet.earth.index);    // 1
  print(Planet.earth.name);     // 'earth'
}
```

Enum rất hợp để mô tả trạng thái hữu hạn: `enum LoadStatus { idle, loading, success, error }` — và dùng với `switch` để Dart cảnh báo nếu bạn quên xử lý một nhánh.

---

## 13. Object equality: `==` và `hashCode`

Mặc định, `==` trong Dart so sánh theo **identity** (cùng một object trong bộ nhớ). Hai object có nội dung giống hệt nhau vẫn được coi là *khác nhau*.

```dart
class Point {
  final int x, y;
  Point(this.x, this.y);
}

print(Point(1, 2) == Point(1, 2)); // false! — khác identity
```

Muốn so sánh theo **giá trị**, phải override cả `==` **và** `hashCode` (luôn đi đôi với nhau):

```dart
class Point {
  final int x, y;
  const Point(this.x, this.y);

  @override
  bool operator ==(Object other) =>
      other is Point && other.x == x && other.y == y;

  @override
  int get hashCode => Object.hash(x, y);
}

print(Point(1, 2) == Point(1, 2)); // true
```

> **Quy tắc vàng:** Nếu `a == b` thì `a.hashCode` phải bằng `b.hashCode`. Vi phạm quy tắc này sẽ làm `Set` và `Map` hoạt động sai. Trong thực tế, cân nhắc dùng package `equatable` hoặc `freezed` để tự sinh phần này.

---

## 14. Extension methods & operator overloading

### Extension methods

Cho phép "thêm" phương thức vào một lớp có sẵn *mà không cần sửa hay kế thừa* nó — kể cả lớp của thư viện chuẩn:

```dart
extension StringExtension on String {
  String capitalize() =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}

print('hello'.capitalize()); // 'Hello'
```

### Operator overloading

Bạn có thể định nghĩa ý nghĩa của các toán tử cho lớp của mình:

```dart
class Vector {
  final double x, y;
  const Vector(this.x, this.y);

  Vector operator +(Vector other) => Vector(x + other.x, y + other.y);
  Vector operator *(double scalar) => Vector(x * scalar, y * scalar);

  @override
  String toString() => 'Vector($x, $y)';
}

print(Vector(1, 2) + Vector(3, 4)); // Vector(4.0, 6.0)
```

---

## 15. Nguyên tắc SOLID (tóm tắt)

Năm nguyên tắc thiết kế giúp code OOP dễ bảo trì:

- **S** — Single Responsibility: mỗi lớp chỉ nên có một lý do để thay đổi.
- **O** — Open/Closed: mở để mở rộng, đóng với sửa đổi (thêm lớp mới thay vì sửa lớp cũ).
- **L** — Liskov Substitution: lớp con phải thay thế được lớp cha mà không phá vỡ hành vi.
- **I** — Interface Segregation: nhiều interface nhỏ tốt hơn một interface to.
- **D** — Dependency Inversion: phụ thuộc vào abstraction, không phụ thuộc vào hiện thực cụ thể.

Ví dụ áp dụng D trong Flutter: widget của bạn phụ thuộc vào abstract `Repository` (mục 6), còn `UserRepository` cụ thể được "tiêm" (inject) vào — nhờ đó bạn có thể thay bằng `FakeRepository` khi viết test.

---

## 16. Tổng kết bảng đối chiếu

| Khái niệm OOP | Biểu hiện trong Dart |
|---|---|
| Class / Object | `class`, mọi thứ đều là object, gốc là `Object` |
| Đóng gói | Quy ước `_` (library-private), getter/setter |
| Kế thừa | `extends`, `super`, chỉ đơn kế thừa |
| Trừu tượng | `abstract class`, phương thức không thân |
| Interface | Interface ngầm + `implements` (không có từ khóa `interface` cổ điển) |
| Đa hình | `@override`, dynamic dispatch, `covariant` |
| Trộn hành vi | `mixin` + `with` (thay cho đa kế thừa) |
| Khởi tạo linh hoạt | named / factory / const / redirecting constructor |
| So sánh giá trị | override `==` + `hashCode` |
| Mở rộng lớp có sẵn | `extension` |
| Kiểu tổng quát | Generics `<T>`, bounded `<T extends ...>` |
| Hằng trạng thái | enhanced `enum` |

---

### Gợi ý cho buổi dạy

- Bắt đầu từ một ví dụ Flutter quen thuộc (`StatelessWidget`) rồi "mổ" ngược ra các trụ cột OOP — học viên sẽ thấy OOP không phải lý thuyết suông.
- Nhấn mạnh ba điểm Dart khác biệt dễ gây nhầm: (1) `_` là library-private chứ không phải class-private, (2) không có từ khóa `interface`, (3) `factory` không nhất thiết tạo object mới.
- Kết mỗi mục bằng một câu hỏi "tại sao Dart thiết kế thế này" để học viên tư duy thay vì học vẹt cú pháp.
