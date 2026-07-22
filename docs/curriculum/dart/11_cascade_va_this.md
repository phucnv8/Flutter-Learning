# 11. Cascade `..` & `this`

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

| Đặc điểm | Cascade `..` | Method chaining (return `this`) |
|---|---|---|
| Cần sửa class? | Không | Cần return `this` |
| Áp dụng được với mọi class? | Có | Chỉ class được thiết kế sẵn |
| Đọc code | Tự nhiên | Rõ ý định hơn |
