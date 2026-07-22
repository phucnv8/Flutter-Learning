# 12. Kế Thừa & Abstract

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
