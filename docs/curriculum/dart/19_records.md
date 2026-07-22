# 19. Dart 3 — Records

### 19.1 Records là gì?

Record là kiểu dữ liệu **immutable, anonymous** giữ nhiều giá trị cùng lúc. Khác với class: không cần định nghĩa trước, không thể thêm method, so sánh theo giá trị.

```dart
// Tạo record
final point = (3.0, 4.0);                       // positional
final person = (name: 'Alice', age: 30);         // named
final mixed  = (42, name: 'Bob', active: true);  // kết hợp

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
