# 18. Iterable Methods — Tư Duy Functional

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

print(nums.take(3).toList());                 // [1, 2, 3]
print(nums.skip(5).toList());                 // [6, 7, 8]
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

### 18.9 `indexed` (Dart 3.0)

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
