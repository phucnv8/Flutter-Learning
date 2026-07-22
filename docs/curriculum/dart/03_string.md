# String trong Dart

## 1. Khai báo String

String là kiểu dữ liệu biểu diễn chuỗi ký tự (dãy các đơn vị mã UTF-16). Có thể dùng nháy đơn hoặc nháy kép.

```dart
String a = 'Xin chào';
String b = "Dart rất hay";
String c = 'Anh ấy nói "OK"'; // nháy đơn chứa nháy kép
String d = "It's fine";       // nháy kép chứa nháy đơn
```

### Chuỗi nhiều dòng

Dùng ba dấu nháy (`'''` hoặc `"""`):

```dart
String multi = '''
Dòng 1
Dòng 2
Dòng 3
''';
```

### Raw string

Thêm `r` phía trước để bỏ qua ký tự escape (chuỗi thô):

```dart
String path = r'C:\Users\name\file.txt'; // \ giữ nguyên, không bị escape
print(r'\n không xuống dòng');
```

## 2. String Interpolation (nội suy chuỗi)

Dùng `$` để chèn biến, `${...}` để chèn biểu thức.

```dart
String name = "An";
int age = 25;

print("Tôi tên $name");                 // Tôi tên An
print("Năm sau tôi ${age + 1} tuổi");    // Năm sau tôi 26 tuổi
print("Độ dài tên: ${name.length}");     // Độ dài tên: 2
```

## 3. Nối chuỗi (Concatenation)

```dart
// Dùng +
String s1 = "Hello" + " " + "World";

// Đặt liền kề (adjacent string literals) — tự động nối
String s2 = "Hello" " " "World";

// Nối nhiều dòng
String s3 = "Dòng dài "
    "được viết "
    "trên nhiều dòng code";
```

## 4. Các thuộc tính thường dùng

```dart
String s = "Dart Language";

print(s.length);      // 13 - độ dài
print(s.isEmpty);     // false
print(s.isNotEmpty);  // true
```

## 5. Các phương thức phổ biến

### 5.1. Chuyển đổi hoa/thường

```dart
"Dart".toUpperCase(); // "DART"
"Dart".toLowerCase(); // "dart"
```

### 5.2. Cắt khoảng trắng

```dart
"  hello  ".trim();       // "hello"
"  hello  ".trimLeft();   // "hello  "
"  hello  ".trimRight();  // "  hello"
```

### 5.3. Kiểm tra nội dung

```dart
String s = "Dart Language";

s.contains("Lang");        // true
s.startsWith("Dart");      // true
s.endsWith("age");         // true
s.indexOf("a");            // 1 (vị trí đầu tiên)
s.lastIndexOf("a");        // 6
```

### 5.4. Thay thế

```dart
"aaa".replaceAll("a", "b");        // "bbb"
"aaa".replaceFirst("a", "b");      // "baa"
"hello world".replaceRange(0, 5, "HELLO"); // "HELLO world"
```

### 5.5. Cắt chuỗi con (substring)

```dart
String s = "Dart Language";
s.substring(0, 4);   // "Dart" (từ index 0 đến trước 4)
s.substring(5);      // "Language" (từ index 5 đến hết)
```

### 5.6. Tách và ghép

```dart
"a,b,c".split(",");          // ["a", "b", "c"]
["a", "b", "c"].join("-");   // "a-b-c"
```

### 5.7. Truy cập ký tự

```dart
String s = "Dart";
s[0];               // "D"
s.codeUnitAt(0);    // 68 (mã UTF-16)
s.substring(1, 2);  // "a"
```

### 5.8. Lặp lại và padding

```dart
"ab" * 3;                 // "ababab"
"5".padLeft(3, "0");      // "005"
"5".padRight(3, "0");     // "500"
```

## 6. So sánh chuỗi

Dùng `==` để so sánh nội dung (khác một số ngôn ngữ khác).

```dart
"abc" == "abc";        // true
"abc" == "ABC";        // false
"abc".compareTo("abd"); // -1 (âm: nhỏ hơn, 0: bằng, dương: lớn hơn)
```

## 7. Chuyển đổi kiểu

```dart
// Số -> chuỗi
int n = 42;
String s = n.toString();     // "42"
(3.14159).toStringAsFixed(2); // "3.14"

// Chuỗi -> số
int.parse("42");             // 42
double.parse("3.14");        // 3.14

// An toàn hơn (trả null nếu không parse được)
int.tryParse("abc");         // null
int.tryParse("42");          // 42
```

## 8. StringBuffer (nối chuỗi hiệu quả)

Khi cần nối nhiều chuỗi trong vòng lặp, `StringBuffer` hiệu quả hơn dùng `+` (vì String là bất biến — immutable).

```dart
var buffer = StringBuffer();
for (int i = 0; i < 5; i++) {
  buffer.write("Số $i ");
}
String result = buffer.toString(); // "Số 0 Số 1 Số 2 Số 3 Số 4 "
```

## 9. Lưu ý về tính bất biến (Immutable)

String trong Dart là **immutable** — mọi phương thức "thay đổi" thực chất trả về một chuỗi mới, không sửa chuỗi gốc.

```dart
String s = "hello";
s.toUpperCase();       // trả về "HELLO" nhưng s vẫn là "hello"
print(s);              // hello
s = s.toUpperCase();   // phải gán lại
print(s);              // HELLO
```
