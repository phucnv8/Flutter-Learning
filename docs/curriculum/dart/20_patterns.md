# 20. Dart 3 — Patterns & Pattern Matching

### 20.1 Patterns là gì?

Pattern là cú pháp để **khớp** cấu trúc của một giá trị và **destructure** (trích xuất) các phần của nó đồng thời. Dùng trong `switch`, `if case`, khai báo biến.

### 20.2 Literal Pattern

```dart
void classify(Object value) {
  switch (value) {
    case 0:       print('Zero');
    case < 0:     print('Negative');
    case > 0:     print('Positive');
    case 'hello': print('Greeting');
    case true:    print('True');
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
  print(getArea(Circle(5)));        // 78.53...
  print(getArea(Rectangle(3, 4))); // 12.0
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
