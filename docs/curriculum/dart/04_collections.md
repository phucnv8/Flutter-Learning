# Collections trong Dart

Dart có 3 loại collection cơ bản: **List** (danh sách có thứ tự), **Set** (tập hợp không trùng lặp), và **Map** (cặp khóa-giá trị).

## 1. List (Danh sách)

List là tập hợp có thứ tự các phần tử, truy cập qua chỉ số (index bắt đầu từ 0).

### Khai báo

```dart
// List có thể thay đổi (growable)
List<int> numbers = [1, 2, 3];
var fruits = ["táo", "cam", "chuối"];

// List rỗng
List<String> empty = [];
var empty2 = <String>[];

// List cố định độ dài
var fixed = List<int>.filled(3, 0); // [0, 0, 0]

// List sinh từ hàm
var squares = List<int>.generate(5, (i) => i * i); // [0, 1, 4, 9, 16]
```

### Truy cập và thao tác

```dart
var list = [10, 20, 30];

list[0];            // 10
list.first;         // 10
list.last;          // 30
list.length;        // 3
list.isEmpty;       // false
list.reversed;      // (30, 20, 10)

list.add(40);           // thêm cuối: [10, 20, 30, 40]
list.addAll([50, 60]);  // thêm nhiều
list.insert(0, 5);      // chèn tại index 0
list.remove(20);        // xóa theo giá trị
list.removeAt(0);       // xóa theo index
list.removeLast();      // xóa cuối
list.contains(30);      // true
list.indexOf(30);       // vị trí
list.clear();           // xóa hết
```

### Các phương thức xử lý phổ biến

```dart
var nums = [1, 2, 3, 4, 5];

nums.map((n) => n * 2);              // (2, 4, 6, 8, 10)
nums.where((n) => n.isEven);         // (2, 4) - lọc
nums.firstWhere((n) => n > 3);       // 4
nums.any((n) => n > 4);              // true
nums.every((n) => n > 0);            // true
nums.reduce((a, b) => a + b);        // 15 - gộp
nums.fold(100, (sum, n) => sum + n); // 115 - gộp với giá trị khởi tạo
nums.forEach((n) => print(n));       // duyệt
nums.sort();                         // sắp xếp tại chỗ
nums.take(2);                        // (1, 2)
nums.skip(2);                        // (3, 4, 5)
```

> Lưu ý: `map`, `where` trả về `Iterable` (lười biếng). Thêm `.toList()` để chuyển lại thành List.

## 2. Set (Tập hợp)

Set là tập hợp các phần tử **không trùng lặp** và **không có thứ tự đảm bảo**.

```dart
Set<int> s = {1, 2, 3};
var names = {"An", "Bình", "An"}; // {"An", "Bình"} - loại trùng
Set<String> empty = {};

s.add(4);           // {1, 2, 3, 4}
s.add(1);           // không thêm (đã có)
s.remove(2);        // {1, 3, 4}
s.contains(3);      // true
s.length;           // số phần tử
```

### Phép toán tập hợp

```dart
var a = {1, 2, 3};
var b = {2, 3, 4};

a.union(b);         // {1, 2, 3, 4} - hợp
a.intersection(b);  // {2, 3} - giao
a.difference(b);    // {1} - hiệu
```

## 3. Map (Từ điển - cặp khóa/giá trị)

Map lưu trữ dữ liệu dưới dạng cặp key-value, key là duy nhất.

```dart
Map<String, int> ages = {
  "An": 25,
  "Bình": 30,
};
var scores = {"Toán": 9, "Văn": 8};
Map<String, int> empty = {};
```

### Truy cập và thao tác

```dart
ages["An"];             // 25
ages["Chi"];            // null (key không tồn tại)
ages["Chi"] = 22;       // thêm/cập nhật
ages.remove("An");      // xóa theo key

ages.containsKey("Bình");   // true
ages.containsValue(30);     // true
ages.keys;                  // (Bình, Chi) - danh sách key
ages.values;                // (30, 22) - danh sách value
ages.length;                // số cặp

// Lấy có giá trị mặc định
ages.putIfAbsent("Dũng", () => 40); // thêm nếu chưa có
```

### Duyệt Map

```dart
ages.forEach((key, value) {
  print("$key: $value");
});

for (var entry in ages.entries) {
  print("${entry.key} = ${entry.value}");
}

for (var key in ages.keys) {
  print("$key -> ${ages[key]}");
}
```

## 4. Collection If & For (spread và điều kiện trong collection)

Dart cho phép dùng if/for ngay bên trong khai báo collection — rất hữu ích.

### Spread operator (`...` và `...?`)

```dart
var a = [1, 2, 3];
var b = [0, ...a, 4];       // [0, 1, 2, 3, 4]

List<int>? c;
var d = [0, ...?c];         // [0] - ...? bỏ qua nếu null
```

### Collection if

```dart
bool promoActive = true;
var items = [
  "Sản phẩm A",
  "Sản phẩm B",
  if (promoActive) "Sản phẩm khuyến mãi",
];
```

### Collection for

```dart
var nums = [1, 2, 3];
var doubled = [
  for (var n in nums) n * 2, // [2, 4, 6]
];
```

## 5. Bảng so sánh nhanh

| Đặc điểm | List | Set | Map |
|----------|------|-----|-----|
| Có thứ tự | Có | Không đảm bảo | Không đảm bảo |
| Cho phép trùng | Có | Không | Key: không |
| Truy cập bằng | index | — | key |
| Cú pháp | `[...]` | `{...}` | `{k: v}` |

> Lưu ý: `{}` rỗng mặc định là **Map**, không phải Set. Muốn Set rỗng phải viết `<int>{}` hoặc khai báo kiểu `Set<int> s = {}`.
