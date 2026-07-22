# 22. Equality: `==` & `hashCode`

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

  print(p1 == p2);          // false — khác reference!
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

**1. Không bao giờ để `hashCode` phụ thuộc vào mutable fields:**

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
print(r1 == r2);                   // true — không cần override gì!
print(r1.hashCode == r2.hashCode); // true
```
