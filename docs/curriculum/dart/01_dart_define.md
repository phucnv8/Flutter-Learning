# Các kiểu khai báo biến trong Dart

Dart có khá nhiều cách khai báo biến, mỗi cách phục vụ mục đích khác nhau. Dưới đây là tổng hợp đầy đủ.

## 1. Khai báo tường minh kiểu (explicit type)

Đây là cách truyền thống, bạn chỉ rõ kiểu dữ liệu:

```dart
int tuoi = 25;
String ten = "An";
double chieuCao = 1.75;
bool dangHoc = true;
```

## 2. `var` — suy luận kiểu tự động

Dart tự suy ra kiểu dựa trên giá trị khởi tạo. Sau khi suy luận, kiểu bị **cố định**, không thể gán giá trị khác kiểu:

```dart
var soLuong = 10;      // được suy ra là int
soLuong = 20;          // OK
// soLuong = "hai mươi"; // LỖI: không thể gán String cho int
```

Nếu khai báo `var` mà không khởi tạo, kiểu sẽ là `dynamic`:

```dart
var x;      // kiểu là dynamic
x = 5;
x = "chuỗi"; // OK vì là dynamic
```

## 3. `dynamic` — kiểu động

Cho phép thay đổi kiểu bất cứ lúc nào. Tắt kiểm tra kiểu tại compile-time nên dễ gây lỗi runtime, cần dùng cẩn thận:

```dart
dynamic bien = 10;
bien = "xin chào";  // OK
bien = true;        // OK
```

## 4. `Object` / `Object?` — kiểu gốc

Khác với `dynamic` ở chỗ vẫn giữ kiểm tra kiểu. Bạn không thể gọi phương thức đặc thù nếu chưa ép kiểu:

```dart
Object obj = "chuỗi";
obj = 42;           // OK, gán được mọi kiểu
// print(obj.length); // LỖI: Object không có 'length'
```

## 5. `final` — gán một lần (runtime)

Giá trị được gán **một lần duy nhất**, không thể thay đổi sau đó. Giá trị có thể được xác định lúc chạy chương trình:

```dart
final ngayHomNay = DateTime.now();  // OK, tính lúc runtime
final String thanhPho = "Hà Nội";
// thanhPho = "Đà Nẵng";  // LỖI: không thể gán lại
```

## 6. `const` — hằng số biên dịch (compile-time)

Giá trị phải được biết **ngay lúc biên dịch**. Nghiêm ngặt hơn `final`:

```dart
const pi = 3.14159;
const int soMax = 100;
// const gio = DateTime.now();  // LỖI: không biết được lúc biên dịch
```

Sự khác biệt cốt lõi giữa `final` và `const`: `final` cho phép giá trị được tính lúc chạy, còn `const` bắt buộc phải là hằng số cố định ngay khi biên dịch. Ngoài ra `const` còn tạo ra đối tượng bất biến (immutable) sâu:

```dart
final list1 = [1, 2, 3];
list1.add(4);        // OK, nội dung list có thể đổi

const list2 = [1, 2, 3];
// list2.add(4);     // LỖI: const list bất biến hoàn toàn
```

## 7. `late` — khởi tạo trễ

Cho phép khai báo biến non-nullable mà chưa gán giá trị ngay, nhưng cam kết sẽ gán trước khi dùng:

```dart
late String moTa;

void main() {
  moTa = "Đã gán sau";
  print(moTa);  // OK
}
```

`late` cũng dùng để khởi tạo lười (lazy) — biểu thức chỉ chạy khi biến được truy cập lần đầu:

```dart
late int giaTri = tinhToanNang();  // hàm chỉ chạy khi 'giaTri' được đọc
```

## 8. Biến nullable — dấu `?`

Từ Dart 2.12 (null safety), biến mặc định không thể null. Thêm `?` để cho phép null:

```dart
int? tuoi;          // có thể null, mặc định là null
String? ten = null; // OK
int soKhong;        // LỖI nếu chưa gán mà đem dùng
```

## Bảng so sánh nhanh

| Từ khóa            | Có kiểm tra kiểu | Đổi giá trị được? | Xác định khi nào |
| ------------------ | :--------------: | :---------------: | ---------------- |
| `int`, `String`... |        Có        |        Có         | Runtime          |
| `var`              |  Có (suy luận)   |  Có (cùng kiểu)   | Runtime          |
| `dynamic`          |      Không       |   Có (mọi kiểu)   | Runtime          |
| `Object`           |        Có        |   Có (mọi kiểu)   | Runtime          |
| `final`            |        Có        |       Không       | Runtime          |
| `const`            |        Có        |       Không       | Compile-time     |
| `late`             |        Có        |        Tùy        | Khi truy cập     |
