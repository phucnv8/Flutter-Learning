# Dart Nâng Cao — Mục 10 đến 22

---

## 10. Constructor Nâng Cao

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

---

## 11. Cascade `..` & `this`

### 11.1 Cascade Operator `..`

Cascade cho phép thực hiện nhiều thao tác liên tiếp trên cùng một object mà không cần lặp lại tên biến. Toán tử `..` trả về object gốc thay vì giá trị của phương thức được gọi.

```dart
class StringBuffer {
  final List<String> _parts = [];

  StringBuffer write(String s) {
    _parts.add(s);
    return this;
  }

  @override
  String toString() => _parts.join();
}

void main() {
  // Không dùng cascade — phải lặp tên biến
  final buf1 = StringBuffer();
  buf1.write('Hello');
  buf1.write(', ');
  buf1.write('World');

  // Dùng cascade — gọn hơn
  final buf2 = StringBuffer()
    ..write('Hello')
    ..write(', ')
    ..write('World');

  print(buf2); // Hello, World
}
```

Cascade đặc biệt hữu ích với các class có setter hoặc builder pattern:

```dart
class HttpRequest {
  String method = 'GET';
  String url = '';
  Map<String, String> headers = {};
  String? body;

  void setMethod(String m) => method = m;
  void setUrl(String u) => url = u;
  void addHeader(String key, String value) => headers[key] = value;
  void setBody(String b) => body = b;
}

void main() {
  final request = HttpRequest()
    ..setMethod('POST')
    ..setUrl('https://api.example.com/data')
    ..addHeader('Content-Type', 'application/json')
    ..addHeader('Authorization', 'Bearer token123')
    ..setBody('{"name": "Dart"}');

  print(request.method); // POST
  print(request.headers); // {Content-Type: application/json, Authorization: Bearer token123}
}
```

### 11.2 Null-aware Cascade `?..`

Chỉ cascade nếu object không phải `null`:

```dart
List<int>? numbers;

numbers
  ?..add(1)
  ..add(2)
  ..sort(); // Không lỗi — không làm gì vì numbers == null

numbers = [3, 1, 2];
numbers
  ?..sort()
  ..add(0);

print(numbers); // [0, 1, 2, 3]
```

### 11.3 `this` và Fluent API

`this` trỏ đến instance hiện tại. Dùng để phân biệt parameter và field, hoặc xây dựng fluent API (method chaining):

```dart
class QueryBuilder {
  String _table = '';
  final List<String> _conditions = [];
  int? _limit;

  QueryBuilder from(String table) {
    _table = table;
    return this; // trả về this để chain
  }

  QueryBuilder where(String condition) {
    _conditions.add(condition);
    return this;
  }

  QueryBuilder limit(int n) {
    _limit = n;
    return this;
  }

  String build() {
    var query = 'SELECT * FROM $_table';
    if (_conditions.isNotEmpty) {
      query += ' WHERE ${_conditions.join(' AND ')}';
    }
    if (_limit != null) query += ' LIMIT $_limit';
    return query;
  }
}

void main() {
  final sql = QueryBuilder()
      .from('users')
      .where('age > 18')
      .where('active = true')
      .limit(10)
      .build();

  print(sql);
  // SELECT * FROM users WHERE age > 18 AND active = true LIMIT 10
}
```

### So sánh `..` vs method chaining `this`

| Đặc điểm                    | Cascade `..` | Method chaining (return `this`) |
| --------------------------- | ------------ | ------------------------------- |
| Cần sửa class?              | Không        | Cần return `this`               |
| Áp dụng được với mọi class? | Có           | Chỉ class được thiết kế sẵn     |
| Đọc code                    | Tự nhiên     | Rõ ý định hơn                   |

---

## 12. Kế Thừa & Abstract

### 12.1 Kế thừa với `extends`

Dart chỉ hỗ trợ **đơn kế thừa** (single inheritance). Subclass thừa hưởng tất cả các member không-private từ superclass.

```dart
class Animal {
  final String name;
  Animal(this.name);

  void breathe() => print('$name đang thở');

  String describe() => 'Tôi là $name';
}

class Dog extends Animal {
  final String breed;

  Dog(super.name, this.breed); // super parameter — Dart 2.17+

  void bark() => print('$name: Gâu gâu!');

  @override
  String describe() => '${super.describe()}, giống ${breed}';
}

void main() {
  final dog = Dog('Rex', 'Husky');
  dog.breathe();   // Rex đang thở (từ Animal)
  dog.bark();      // Rex: Gâu gâu!
  print(dog.describe()); // Tôi là Rex, giống Husky
}
```

### 12.2 `super` — Gọi constructor cha

```dart
class Vehicle {
  final String brand;
  final int year;

  Vehicle(this.brand, this.year) {
    print('Vehicle constructor: $brand $year');
  }
}

class Car extends Vehicle {
  final int doors;

  Car(super.brand, super.year, this.doors) {
    print('Car constructor: $doors cửa');
  }
}

void main() {
  final car = Car('Toyota', 2023, 4);
  // Vehicle constructor: Toyota 2023
  // Car constructor: 4 cửa
}
```

### 12.3 Abstract Class

`abstract class` không thể được instantiate trực tiếp. Nó định nghĩa "hợp đồng" mà subclass phải implement:

```dart
abstract class Drawable {
  String color;
  Drawable(this.color);

  // Abstract method — subclass BẮT BUỘC override
  void draw();

  // Concrete method — subclass có thể dùng ngay
  void describe() => print('Hình màu $color');
}

class Circle extends Drawable {
  double radius;
  Circle(super.color, this.radius);

  @override
  void draw() => print('Vẽ hình tròn bán kính $radius màu $color');
}

class Rectangle extends Drawable {
  double width, height;
  Rectangle(super.color, this.width, this.height);

  @override
  void draw() => print('Vẽ hình chữ nhật ${width}x${height} màu $color');
}

void main() {
  // Drawable d = Drawable('red'); // LỖI — không thể tạo abstract class

  final shapes = <Drawable>[
    Circle('đỏ', 5),
    Rectangle('xanh', 3, 4),
  ];

  for (final shape in shapes) {
    shape.draw();
    shape.describe();
  }
}
```

### 12.4 `@override` và Covariant

```dart
class Animal {
  void eat(Object food) => print('Eating $food');
}

class Cat extends Animal {
  @override
  void eat(covariant String food) => print('Cat eating $food'); // Hẹp kiểu lại
}
```

### 12.5 Ngăn kế thừa với `final` class (Dart 3)

```dart
final class Singleton {
  static final Singleton _instance = Singleton._();
  Singleton._();
  factory Singleton() => _instance;
}

// class Sub extends Singleton {} // LỖI — không được extend final class
```

---

## 13. Interface, `implements`, Mixin (`with`)

### 13.1 Interface trong Dart

Dart **không có từ khóa `interface`**. Mọi class đều ngầm định là một interface. Bạn dùng `implements` để cam kết implement toàn bộ API của class đó (nhưng không kế thừa implementation):

```dart
class Flyable {
  void fly() => print('Flying...');
  double get maxAltitude => 10000;
}

class Bird implements Flyable {
  @override
  void fly() => print('Bird flaps wings and flies');

  @override
  double get maxAltitude => 3000;
}

class Airplane implements Flyable {
  @override
  void fly() => print('Airplane uses engines to fly');

  @override
  double get maxAltitude => 12000;
}
```

> Khác với `extends`: `implements` **không kế thừa code**, chỉ kế thừa "hợp đồng". Bạn phải viết lại tất cả.

### 13.2 `implements` nhiều interface

```dart
abstract class Swimmable {
  void swim();
}

abstract class Runnable {
  void run();
}

abstract interface class Flyable {
  void fly();
}

class Duck implements Swimmable, Runnable, Flyable {
  @override void swim() => print('Vịt bơi');
  @override void run() => print('Vịt chạy');
  @override void fly() => print('Vịt bay');
}
```

### 13.3 `abstract interface class` (Dart 3)

Từ Dart 3, có thể khai báo rõ ràng một class chỉ dùng làm interface:

```dart
abstract interface class Repository<T> {
  Future<T?> findById(String id);
  Future<List<T>> findAll();
  Future<void> save(T entity);
  Future<void> delete(String id);
}

class UserRepository implements Repository<User> {
  @override Future<User?> findById(String id) async { /* ... */ return null; }
  @override Future<List<User>> findAll() async => [];
  @override Future<void> save(User entity) async {}
  @override Future<void> delete(String id) async {}
}
```

### 13.4 Mixin với `mixin` và `with`

Mixin là cách chia sẻ code giữa nhiều class mà không cần kế thừa. Không giống `extends` (chỉ 1 cha), bạn có thể `with` nhiều mixin:

```dart
mixin Logging {
  void log(String message) {
    print('[${runtimeType}] $message');
  }
}

mixin Validation {
  bool isNotEmpty(String value) => value.trim().isNotEmpty;
  bool isValidEmail(String email) => email.contains('@');
}

mixin Serializable {
  Map<String, dynamic> toJson();

  String serialize() => toJson().toString();
}

class UserService with Logging, Validation {
  void createUser(String name, String email) {
    if (!isNotEmpty(name)) {
      log('Name is empty!');
      return;
    }
    if (!isValidEmail(email)) {
      log('Invalid email: $email');
      return;
    }
    log('Creating user: $name ($email)');
  }
}

void main() {
  final service = UserService();
  service.createUser('Alice', 'alice@example.com');
  // [UserService] Creating user: Alice (alice@example.com)
  service.createUser('', 'bad-email');
  // [UserService] Name is empty!
}
```

### 13.5 `on` — Giới hạn Mixin áp dụng cho class nào

```dart
class Animal {
  String name;
  Animal(this.name);
}

// Mixin này chỉ được dùng bởi subclass của Animal
mixin CanFly on Animal {
  void fly() => print('$name đang bay');
}

class Bird extends Animal with CanFly {
  Bird(super.name);
}

// class Car with CanFly {} // LỖI — Car không extend Animal
```

### 13.6 So sánh `extends`, `implements`, `with`

|                     | `extends`  | `implements` | `with`           |
| ------------------- | ---------- | ------------ | ---------------- |
| Số lượng            | 1          | Nhiều        | Nhiều            |
| Kế thừa code        | Có         | Không        | Có               |
| Kế thừa constructor | Có         | Không        | Không            |
| Mục đích            | Chuyên hóa | Cam kết API  | Tái sử dụng code |

---

## 14. Enum Nâng Cao (Enhanced Enums)

### 14.1 Enum cơ bản

```dart
enum Direction { north, south, east, west }

void main() {
  final dir = Direction.north;
  print(dir.name);  // north
  print(dir.index); // 0

  // Switch exhaustive
  switch (dir) {
    case Direction.north: print('Đi lên');
    case Direction.south: print('Đi xuống');
    case Direction.east:  print('Đi phải');
    case Direction.west:  print('Đi trái');
  }
}
```

### 14.2 Enhanced Enum (Dart 2.17+)

Enum có thể chứa field, constructor, và method như class:

```dart
enum Planet {
  mercury(3.303e+23, 2.4397e6),
  venus(4.869e+24, 6.0518e6),
  earth(5.976e+24, 6.37814e6),
  mars(6.421e+23, 3.3972e6);

  // Fields
  final double mass;       // kg
  final double radius;     // m

  // Constant constructor (bắt buộc với enhanced enum)
  const Planet(this.mass, this.radius);

  // Computed property
  double get surfaceGravity {
    const G = 6.67430e-11;
    return G * mass / (radius * radius);
  }

  double surfaceWeight(double otherMass) => otherMass * surfaceGravity;
}

void main() {
  const earthWeight = 75.0;
  const mass = earthWeight / Planet.earth.surfaceGravity;

  for (final p in Planet.values) {
    print('${p.name}: ${p.surfaceWeight(mass).toStringAsFixed(2)} N');
  }
}
```

### 14.3 Enum implement interface

```dart
abstract interface class Describable {
  String get description;
}

enum Season implements Describable {
  spring('Mùa xuân — ấm áp, hoa nở'),
  summer('Mùa hè — nóng, nhiều nắng'),
  autumn('Mùa thu — mát, lá vàng'),
  winter('Mùa đông — lạnh, có tuyết');

  @override
  final String description;

  const Season(this.description);
}

void main() {
  for (final s in Season.values) {
    print('${s.name}: ${s.description}');
  }
}
```

### 14.4 Enum với mixin

```dart
mixin EnumLabel {
  String get label => name.toUpperCase();
}

enum Status with EnumLabel { pending, active, inactive, banned }

void main() {
  print(Status.active.label); // ACTIVE
}
```

---

## 15. Stream

### 15.1 Stream là gì?

`Stream` là chuỗi các giá trị bất đồng bộ theo thời gian — giống như `Future` nhưng phát ra nhiều giá trị thay vì một. Analogies:

- `Future<T>` → một bức thư (một giá trị duy nhất)
- `Stream<T>` → tin nhắn liên tục từ một người (nhiều giá trị)

### 15.2 Tạo Stream

```dart
// 1. Stream từ Iterable
Stream<int> numbersStream() => Stream.fromIterable([1, 2, 3, 4, 5]);

// 2. Stream.periodic — phát mỗi N giây
Stream<int> ticker() => Stream.periodic(
  Duration(seconds: 1),
  (count) => count,
).take(5); // chỉ lấy 5 giá trị

// 3. async* generator (phổ biến nhất)
Stream<int> countDown(int from) async* {
  for (int i = from; i >= 0; i--) {
    await Future.delayed(Duration(milliseconds: 500));
    yield i; // phát một giá trị
  }
}

// 4. StreamController — kiểm soát thủ công
import 'dart:async';

Stream<String> eventStream() {
  final controller = StreamController<String>();

  // Thêm data
  controller.sink.add('Event 1');
  controller.sink.add('Event 2');
  controller.sink.addError(Exception('Something went wrong'));
  controller.sink.close();

  return controller.stream;
}
```

### 15.3 Lắng nghe Stream

```dart
void main() async {
  // Cách 1: listen()
  final stream = countDown(3);
  stream.listen(
    (value) => print('Value: $value'),
    onError: (e) => print('Error: $e'),
    onDone: () => print('Stream completed!'),
  );

  // Cách 2: await for (sạch hơn, xử lý lỗi với try/catch)
  await for (final value in countDown(3)) {
    print('Countdown: $value');
  }
}
```

### 15.4 Stream Transformations

```dart
void main() async {
  final stream = Stream.fromIterable([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);

  await stream
      .where((n) => n.isEven)          // lọc số chẵn
      .map((n) => n * n)               // bình phương
      .take(3)                         // lấy 3 phần tử đầu
      .forEach(print);                 // 4, 16, 36
}
```

### 15.5 Single vs Broadcast Stream

```dart
void main() async {
  // Single-subscription stream — chỉ 1 listener
  final single = Stream.fromIterable([1, 2, 3]);
  single.listen(print); // OK
  // single.listen(print); // LỖI — đã có listener

  // Broadcast stream — nhiều listener
  final controller = StreamController<int>.broadcast();
  final broadcast = controller.stream;

  broadcast.listen((v) => print('Listener 1: $v'));
  broadcast.listen((v) => print('Listener 2: $v'));

  controller.add(1);
  controller.add(2);
  await controller.close();
  // Listener 1: 1
  // Listener 2: 1
  // Listener 1: 2
  // Listener 2: 2
}
```

### 15.6 StreamController & Sink

```dart
class EventBus {
  final _controller = StreamController<String>.broadcast();

  Stream<String> get events => _controller.stream;

  void publish(String event) => _controller.sink.add(event);

  void dispose() => _controller.close();
}

void main() async {
  final bus = EventBus();

  bus.events
      .where((e) => e.startsWith('user:'))
      .listen((e) => print('User event: $e'));

  bus.publish('user:login');
  bus.publish('system:shutdown');
  bus.publish('user:logout');
  // User event: user:login
  // User event: user:logout

  bus.dispose();
}
```

---

## 16. Xử Lý Lỗi

### 16.1 `try` / `catch` / `finally`

```dart
void main() {
  try {
    final result = int.parse('abc'); // ném FormatException
    print(result);
  } on FormatException catch (e) {
    print('Lỗi format: ${e.message}');
  } on RangeError catch (e, stackTrace) {
    print('Lỗi range: $e');
    print(stackTrace);
  } catch (e) {
    // Bắt mọi lỗi còn lại
    print('Lỗi không xác định: $e');
  } finally {
    // Luôn chạy — dùng để cleanup
    print('Xong rồi!');
  }
}
```

### 16.2 `throw` — Ném lỗi

Có thể throw bất cứ Object nào, nhưng tốt nhất dùng `Exception` hoặc `Error`:

```dart
// Exception — lỗi "có thể recover" (thiếu input, mạng lỗi, v.v.)
void validateAge(int age) {
  if (age < 0) throw ArgumentError('Tuổi không được âm: $age');
  if (age > 150) throw RangeError.range(age, 0, 150, 'age');
}

// Error — lỗi lập trình, không nên catch (StackOverflow, OutOfMemory...)
void riskyOperation() {
  throw StateError('Gọi hàm này không đúng trạng thái');
}
```

### 16.3 Custom Exception

```dart
class AppException implements Exception {
  final String code;
  final String message;
  final Object? cause;

  const AppException(this.code, this.message, {this.cause});

  @override
  String toString() => 'AppException[$code]: $message'
      '${cause != null ? ' (caused by: $cause)' : ''}';
}

class NetworkException extends AppException {
  final int statusCode;
  NetworkException(this.statusCode, String message)
      : super('NETWORK_ERROR', message);
}

class ValidationException extends AppException {
  final String field;
  ValidationException(this.field, String message)
      : super('VALIDATION_ERROR', message);
}

// Sử dụng
Future<void> fetchUser(String id) async {
  if (id.isEmpty) throw ValidationException('id', 'ID không được rỗng');
  // Giả lập lỗi mạng
  throw NetworkException(404, 'User không tồn tại');
}

void main() async {
  try {
    await fetchUser('');
  } on ValidationException catch (e) {
    print('Validate field ${e.field}: ${e.message}');
  } on NetworkException catch (e) {
    print('HTTP ${e.statusCode}: ${e.message}');
  } on AppException catch (e) {
    print('App error: $e');
  }
}
```

### 16.4 `rethrow` — Ném lại lỗi

```dart
Future<void> processData() async {
  try {
    await fetchUser('123');
  } catch (e) {
    print('Logging error: $e');
    rethrow; // Ném lại lỗi gốc (giữ nguyên stack trace)
  }
}
```

### 16.5 Result Pattern (không dùng exception)

Trong nhiều codebase Dart hiện đại (đặc biệt Flutter), người ta dùng pattern `Result` thay vì throw:

```dart
sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T value;
  const Success(this.value);
}

class Failure<T> extends Result<T> {
  final Object error;
  const Failure(this.error);
}

Result<int> divide(int a, int b) {
  if (b == 0) return Failure(ArgumentError('Chia cho 0'));
  return Success(a ~/ b);
}

void main() {
  final result = divide(10, 2);
  switch (result) {
    case Success(:final value): print('Kết quả: $value');
    case Failure(:final error): print('Lỗi: $error');
  }
}
```

---

## 17. Generics

### 17.1 Tại sao cần Generics?

Generics cho phép viết code tổng quát mà vẫn type-safe — thay vì dùng `dynamic` và mất type checking.

```dart
// Không có generics — mất type safety
List dynamicList = [1, 'two', 3.0];
String s = dynamicList[0] as String; // Runtime error!

// Có generics — type safe
List<int> intList = [1, 2, 3];
// intList.add('four'); // Compile-time error!
```

### 17.2 Generic Class

```dart
class Stack<T> {
  final List<T> _items = [];

  void push(T item) => _items.add(item);

  T pop() {
    if (_items.isEmpty) throw StateError('Stack is empty');
    return _items.removeLast();
  }

  T get peek => _items.last;
  bool get isEmpty => _items.isEmpty;
  int get length => _items.length;

  @override
  String toString() => 'Stack($_items)';
}

void main() {
  final intStack = Stack<int>()
    ..push(1)
    ..push(2)
    ..push(3);

  print(intStack.pop()); // 3
  print(intStack.peek);  // 2

  final stringStack = Stack<String>()
    ..push('a')
    ..push('b');

  print(stringStack); // Stack([a, b])
}
```

### 17.3 Generic Method

```dart
T first<T>(List<T> list) {
  if (list.isEmpty) throw StateError('Empty list');
  return list.first;
}

// Dart có thể infer kiểu
print(first([1, 2, 3]));     // 1 — infer T = int
print(first(['a', 'b']));   // a — infer T = String

// Hoặc chỉ định rõ
print(first<double>([1.0, 2.0]));
```

### 17.4 Type Constraints (`extends`)

```dart
// T phải là Comparable (để có thể so sánh)
T max<T extends Comparable<T>>(T a, T b) => a.compareTo(b) >= 0 ? a : b;

print(max(3, 7));         // 7
print(max('apple', 'banana')); // banana

// T phải là num
double average<T extends num>(List<T> numbers) {
  return numbers.reduce((a, b) => (a + b) as T) / numbers.length;
}
```

### 17.5 Covariance và Contravariance

```dart
// List<Dog> không phải subtype của List<Animal> trong Dart
// (Dart Lists là invariant)
List<int> ints = [1, 2, 3];
// List<num> nums = ints; // LỖI — không tương thích

// Nhưng có thể dùng type parameter ở các vị trí covariant
void printAll(Iterable<Object> items) {
  for (final item in items) print(item);
}
printAll([1, 2, 3]); // OK — Iterable covariant
```

### 17.6 Generic với Multiple Type Parameters

```dart
class Pair<A, B> {
  final A first;
  final B second;

  const Pair(this.first, this.second);

  Pair<B, A> swap() => Pair(second, first);

  @override
  String toString() => '($first, $second)';
}

class Either<L, R> {
  final L? _left;
  final R? _right;
  final bool isLeft;

  Either.left(L value)  : _left = value,  _right = null, isLeft = true;
  Either.right(R value) : _left = null,   _right = value, isLeft = false;

  L get left  => _left!;
  R get right => _right!;
}

void main() {
  final pair = Pair<String, int>('hello', 42);
  print(pair);         // (hello, 42)
  print(pair.swap());  // (42, hello)
}
```

---

## 18. Iterable Methods — Tư Duy Functional

### 18.1 Tổng quan

`Iterable<T>` là base của `List`, `Set`, `Map.entries`, v.v. Dart cung cấp bộ methods functional mạnh mẽ, cho phép biến đổi, lọc, gộp dữ liệu mà không cần vòng lặp thủ công.

### 18.2 `map` — Biến đổi mỗi phần tử

```dart
final numbers = [1, 2, 3, 4, 5];
final squared = numbers.map((n) => n * n).toList();
print(squared); // [1, 4, 9, 16, 25]

final people = [
  {'name': 'Alice', 'age': 30},
  {'name': 'Bob', 'age': 25},
];
final names = people.map((p) => p['name']!).toList();
print(names); // [Alice, Bob]
```

### 18.3 `where` — Lọc phần tử

```dart
final evens = numbers.where((n) => n.isEven).toList();
print(evens); // [2, 4]

// whereType<T>() — lọc theo type
final mixed = <Object>[1, 'a', 2, 'b', 3];
final ints = mixed.whereType<int>().toList();
print(ints); // [1, 2, 3]
```

### 18.4 `reduce` và `fold` — Gộp tất cả thành một giá trị

```dart
// reduce — dùng phần tử đầu làm accumulator ban đầu
final sum = numbers.reduce((acc, n) => acc + n);
print(sum); // 15

// fold — chỉ định giá trị ban đầu (an toàn hơn với list rỗng)
final product = numbers.fold<int>(1, (acc, n) => acc * n);
print(product); // 120

final sumOfSquares = numbers.fold<int>(0, (acc, n) => acc + n * n);
print(sumOfSquares); // 55
```

### 18.5 `expand` (flatMap) — Mở rộng mỗi phần tử

```dart
final nested = [[1, 2], [3, 4], [5, 6]];
final flat = nested.expand((list) => list).toList();
print(flat); // [1, 2, 3, 4, 5, 6]

final sentences = ['Hello World', 'Dart is great'];
final words = sentences.expand((s) => s.split(' ')).toList();
print(words); // [Hello, World, Dart, is, great]
```

### 18.6 `any`, `every`, `contains`

```dart
final scores = [55, 70, 85, 92, 60];

print(scores.any((s) => s >= 90));    // true — có ít nhất 1 >= 90
print(scores.every((s) => s >= 50));  // true — tất cả >= 50
print(scores.contains(70));           // true
```

### 18.7 `take`, `skip`, `takeWhile`, `skipWhile`

```dart
final nums = [1, 2, 3, 4, 5, 6, 7, 8];

print(nums.take(3).toList());              // [1, 2, 3]
print(nums.skip(5).toList());              // [6, 7, 8]
print(nums.takeWhile((n) => n < 5).toList()); // [1, 2, 3, 4]
print(nums.skipWhile((n) => n < 5).toList()); // [5, 6, 7, 8]
```

### 18.8 `sort`, `toList`, `toSet`

```dart
final unsorted = [3, 1, 4, 1, 5, 9, 2, 6];

// sort — in-place (chỉ trên List)
final sorted = [...unsorted]..sort();
print(sorted); // [1, 1, 2, 3, 4, 5, 6, 9]

// sort với custom comparator
final people2 = [
  {'name': 'Charlie', 'age': 35},
  {'name': 'Alice', 'age': 30},
  {'name': 'Bob', 'age': 25},
];
people2.sort((a, b) => (a['age'] as int).compareTo(b['age'] as int));
print(people2.map((p) => p['name'])); // (Bob, Alice, Charlie)

// toSet — loại bỏ trùng lặp
print(unsorted.toSet().toList()); // [3, 1, 4, 5, 9, 2, 6] (thứ tự có thể thay đổi)
```

### 18.9 `indexed` (Dart 3.0) và `enumerate`

```dart
final fruits = ['apple', 'banana', 'cherry'];

// indexed — trả về (index, value) records
for (final (i, fruit) in fruits.indexed) {
  print('$i: $fruit');
}
// 0: apple
// 1: banana
// 2: cherry
```

### 18.10 Lazy Evaluation

Iterable methods trả về `Iterable` lazy — chỉ tính toán khi cần. Gọi `.toList()` mới thực sự execute chain.

```dart
// Không có intermediate lists — hiệu quả
final result = List.generate(1000000, (i) => i)
    .where((n) => n.isEven)
    .map((n) => n * 2)
    .take(5)  // Chỉ cần 5 phần tử đầu — không xử lý 1 triệu phần tử!
    .toList();

print(result); // [0, 4, 8, 12, 16]
```

---

## 19. Dart 3 — Records

### 19.1 Records là gì?

Record là kiểu dữ liệu **immutable, anonymous** giữ nhiều giá trị cùng lúc. Khác với class: không cần định nghĩa trước, không thể thêm method, so sánh theo giá trị.

```dart
// Tạo record
final point = (3.0, 4.0);                    // positional
final person = (name: 'Alice', age: 30);     // named
final mixed  = (42, name: 'Bob', active: true); // kết hợp

// Truy cập
print(point.$1);         // 3.0
print(point.$2);         // 4.0
print(person.name);      // Alice
print(person.age);       // 30
print(mixed.$1);         // 42
print(mixed.name);       // Bob
```

### 19.2 Record Type Annotation

```dart
// Khai báo kiểu rõ ràng
(double, double) getCoordinates() => (10.5, 20.3);
({String name, int age}) getUser() => (name: 'Alice', age: 30);

// Dùng làm tham số
void printPoint((double x, double y) point) {
  print('(${point.$1}, ${point.$2})');
}
```

### 19.3 Records thay thế cho multiple return values

```dart
// Trước Dart 3 — phải dùng List, Map hoặc custom class
Map<String, dynamic> divmod_old(int a, int b) {
  return {'quotient': a ~/ b, 'remainder': a % b};
}

// Dart 3 — Records!
(int quotient, int remainder) divmod(int a, int b) {
  return (a ~/ b, a % b);
}

void main() {
  final (q, r) = divmod(17, 5);
  print('17 ÷ 5 = $q dư $r'); // 17 ÷ 5 = 3 dư 2
}
```

### 19.4 Records Equality — So sánh theo giá trị

```dart
final r1 = (1, 2, 3);
final r2 = (1, 2, 3);
print(r1 == r2); // true — so sánh theo giá trị, không phải reference!

final r3 = (name: 'Alice', age: 30);
final r4 = (name: 'Alice', age: 30);
print(r3 == r4); // true

final r5 = (age: 30, name: 'Alice'); // khác thứ tự field name
print(r3 == r5); // false — thứ tự field ảnh hưởng đến equality
```

### 19.5 Records trong Collection

```dart
final students = <(String, int)>[
  ('Alice', 90),
  ('Bob', 85),
  ('Charlie', 92),
];

students.sort((a, b) => b.$2.compareTo(a.$2)); // sort theo điểm giảm dần

for (final (name, score) in students) {
  print('$name: $score');
}
// Charlie: 92
// Alice: 90
// Bob: 85
```

### 19.6 Destructuring Records

```dart
final record = (name: 'Alice', age: 30, city: 'Hanoi');

// Destructure toàn bộ
final (name: n, age: a, city: c) = record;
print('$n, $a, $c'); // Alice, 30, Hanoi

// Bỏ qua field không cần (dùng _)
final (name: myName, age: _, city: myCity) = record;
print('$myName sống ở $myCity'); // Alice sống ở Hanoi
```

---

## 20. Dart 3 — Patterns & Pattern Matching

### 20.1 Patterns là gì?

Pattern là cú pháp để **khớp** cấu trúc của một giá trị và **destructure** (trích xuất) các phần của nó đồng thời. Dùng trong `switch`, `if case`, khai báo biến.

### 20.2 Literal Pattern

```dart
void classify(Object value) {
  switch (value) {
    case 0:      print('Zero');
    case < 0:    print('Negative');
    case > 0:    print('Positive');
    case 'hello': print('Greeting');
    case true:   print('True');
  }
}
```

### 20.3 Variable & Wildcard Pattern

```dart
switch (someValue) {
  case int n when n > 100:
    print('Large number: $n'); // Bind vào biến n
  case _:
    print('Something else');   // Wildcard — bỏ qua giá trị
}
```

### 20.4 List Pattern

```dart
void describeList(List<int> list) {
  switch (list) {
    case []:
      print('Empty');
    case [int x]:
      print('One element: $x');
    case [int x, int y]:
      print('Two elements: $x and $y');
    case [int first, ...]: // rest pattern
      print('Starts with $first, has more');
    case [_, _, ...List<int> rest]:
      print('Skip first two, rest: $rest');
  }
}

void main() {
  describeList([]);        // Empty
  describeList([42]);      // One element: 42
  describeList([1, 2]);    // Two elements: 1 and 2
  describeList([1, 2, 3]); // Starts with 1, has more
}
```

### 20.5 Map Pattern

```dart
void processUser(Map<String, Object> user) {
  switch (user) {
    case {'role': 'admin', 'name': String name}:
      print('Admin: $name');
    case {'role': 'guest'}:
      print('Guest user');
    case {'name': String name, 'age': int age} when age >= 18:
      print('Adult: $name ($age)');
    default:
      print('Unknown user');
  }
}

void main() {
  processUser({'role': 'admin', 'name': 'Alice'}); // Admin: Alice
  processUser({'name': 'Bob', 'age': 25});          // Adult: Bob (25)
}
```

### 20.6 Object Pattern

```dart
class Shape { const Shape(); }
class Circle extends Shape {
  final double radius;
  const Circle(this.radius);
}
class Rectangle extends Shape {
  final double width, height;
  const Rectangle(this.width, this.height);
}

double getArea(Shape shape) {
  return switch (shape) {
    Circle(radius: var r) => 3.14159 * r * r,
    Rectangle(width: var w, height: var h) => w * h,
    _ => 0,
  };
}

void main() {
  print(getArea(Circle(5)));          // 78.53...
  print(getArea(Rectangle(3, 4)));    // 12.0
}
```

### 20.7 Record Pattern

```dart
(int, int) point = (3, 4);

switch (point) {
  case (0, 0):
    print('Origin');
  case (int x, 0):
    print('On X-axis at $x');
  case (0, int y):
    print('On Y-axis at $y');
  case (int x, int y):
    print('Point at ($x, $y)');
}
// Point at (3, 4)
```

### 20.8 `if case` — Pattern trong if

```dart
Object json = {'type': 'circle', 'radius': 5.0};

if (json case {'type': 'circle', 'radius': double r}) {
  print('Circle with radius $r'); // Circle with radius 5.0
}

// Trong list processing
final data = <Object>[1, 'hello', 2, 'world', 3];
for (final item in data) {
  if (item case int n) print('Number: $n');
  if (item case String s) print('String: $s');
}
```

### 20.9 Guard Clause với `when`

```dart
switch (score) {
  case int n when n >= 90: print('A');
  case int n when n >= 80: print('B');
  case int n when n >= 70: print('C');
  case int n when n >= 60: print('D');
  case _: print('F');
}
```

---

## 21. Dart 3 — Sealed Class & Exhaustiveness

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
  Circle(:final radius)       => 3.14159 * radius * radius,
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
  ApiSuccess(:final data) => UserCard(data),
  ApiError(:final message) => ErrorWidget(message),
  ApiLoading() => const CircularProgressIndicator(),
};
```

### 21.5 Pattern matching sâu với sealed class

```dart
sealed class Expr {}
class Num extends Expr { final double value; Num(this.value); }
class Add extends Expr { final Expr left, right; Add(this.left, this.right); }
class Mul extends Expr { final Expr left, right; Mul(this.left, this.right); }

double eval(Expr expr) => switch (expr) {
  Num(:final value) => value,
  Add(:final left, :final right) => eval(left) + eval(right),
  Mul(:final left, :final right) => eval(left) * eval(right),
};

void main() {
  // (2 + 3) * 4 = 20
  final e = Mul(Add(Num(2), Num(3)), Num(4));
  print(eval(e)); // 20.0
}
```

---

## 22. Equality: `==` & `hashCode`

### 22.1 Mặc định trong Dart

Theo mặc định, Dart so sánh object theo **reference identity** (giống `identical()`):

```dart
class Point {
  final int x, y;
  Point(this.x, this.y);
}

void main() {
  final p1 = Point(1, 2);
  final p2 = Point(1, 2);

  print(p1 == p2);         // false — khác reference!
  print(identical(p1, p2)); // false
}
```

### 22.2 Override `==` và `hashCode`

Khi override `==`, bắt buộc phải override `hashCode` để đảm bảo contract: **nếu `a == b` thì `a.hashCode == b.hashCode`**:

```dart
class Point {
  final int x, y;
  const Point(this.x, this.y);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;   // Tối ưu: cùng reference
    if (other is! Point) return false;          // Khác type
    return x == other.x && y == other.y;        // So sánh giá trị
  }

  @override
  int get hashCode => Object.hash(x, y);

  @override
  String toString() => 'Point($x, $y)';
}

void main() {
  final p1 = Point(1, 2);
  final p2 = Point(1, 2);
  final p3 = Point(3, 4);

  print(p1 == p2); // true
  print(p1 == p3); // false

  // Hoạt động đúng với Set và Map
  final set = {p1, p2, p3};
  print(set.length); // 2 — p1 và p2 bị coi là trùng

  final map = {p1: 'A', p3: 'B'};
  print(map[p2]); // 'A' — vì p2 == p1
}
```

### 22.3 `Object.hash` và `Object.hashAll`

```dart
class Person {
  final String firstName, lastName;
  final int age;

  const Person(this.firstName, this.lastName, this.age);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Person &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          age == other.age;

  // Object.hash — hash nhiều giá trị
  @override
  int get hashCode => Object.hash(firstName, lastName, age);
}

class Team {
  final List<Person> members;
  Team(this.members);

  @override
  bool operator ==(Object other) =>
      other is Team && _listEquals(members, other.members);

  bool _listEquals(List a, List b) =>
      a.length == b.length &&
      List.generate(a.length, (i) => a[i] == b[i]).every((e) => e);

  // Object.hashAll — hash từ một Iterable
  @override
  int get hashCode => Object.hashAll(members);
}
```

### 22.4 `equatable` package (phổ biến trong Flutter)

Trong thực tế, dùng package `equatable` để tránh viết boilerplate:

```dart
// pubspec.yaml: equatable: ^2.0.5

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final int age;

  const User(this.id, this.name, this.age);

  @override
  List<Object?> get props => [id, name, age]; // Chỉ cần khai báo props!
}

void main() {
  final u1 = User('1', 'Alice', 30);
  final u2 = User('1', 'Alice', 30);
  final u3 = User('2', 'Bob', 25);

  print(u1 == u2); // true
  print(u1 == u3); // false
  print(u1);       // User(1, Alice, 30) — toString tự động!
}
```

### 22.5 Các lưu ý quan trọng

**1. Không bao giờ để `hashCode` mutable fields ảnh hưởng:**

```dart
// SAI — nếu thay đổi x/y sau khi đã bỏ vào Set/Map, sẽ mất object!
class MutablePoint {
  int x, y; // mutable fields
  MutablePoint(this.x, this.y);

  @override
  bool operator ==(Object other) => other is MutablePoint && x == other.x && y == other.y;

  @override
  int get hashCode => Object.hash(x, y); // Nguy hiểm!
}

// ĐÚNG — dùng final fields
class ImmutablePoint {
  final int x, y;
  const ImmutablePoint(this.x, this.y);
  // ...
}
```

**2. `identical()` vs `==`:**

```dart
const a = 'hello';
const b = 'hello';
print(identical(a, b)); // true — compile-time constant canonicalization
print(a == b);          // true

final c = 'hel' + 'lo';
print(identical(a, c)); // false — runtime String, khác object
print(a == c);          // true — String override ==
```

**3. Records tự động có equality đúng:**

```dart
final r1 = (1, 2);
final r2 = (1, 2);
print(r1 == r2); // true — không cần override gì!
print(r1.hashCode == r2.hashCode); // true
```

---

## Tổng Kết

| Chủ đề                   | Điểm mấu chốt                                                              |
| ------------------------ | -------------------------------------------------------------------------- |
| **Constructor nâng cao** | Named, factory, redirecting, const — mỗi loại có use case riêng            |
| **Cascade & this**       | `..` giúp code gọn khi gọi nhiều method/setter liên tiếp                   |
| **Kế thừa & abstract**   | Dart chỉ có single inheritance; abstract class định nghĩa "hợp đồng"       |
| **Interface & mixin**    | `implements` = cam kết API; `with` = tái sử dụng code                      |
| **Enhanced enum**        | Enum có thể có field, method, implement interface                          |
| **Stream**               | Chuỗi async nhiều giá trị; dùng `async*`/`yield` để tạo                    |
| **Xử lý lỗi**            | `try/on/catch/finally`; dùng custom Exception; cân nhắc Result pattern     |
| **Generics**             | Type-safe tổng quát; dùng `extends` để ràng buộc type parameter            |
| **Iterable methods**     | Tư duy functional: `map`, `where`, `fold`, `expand` — lazy evaluation      |
| **Records**              | Tuple có tên, immutable, equality theo giá trị, không cần định nghĩa class |
| **Patterns**             | Khớp cấu trúc + destructure đồng thời trong switch/if case                 |
| **Sealed class**         | Closed hierarchy + compiler exhaustiveness checking                        |
| **Equality**             | Override cả `==` và `hashCode`; dùng `Object.hash`; cẩn thận mutable state |
