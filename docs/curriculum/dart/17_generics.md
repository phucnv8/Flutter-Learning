# 17. Generics

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

print(max(3, 7));              // 7
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
