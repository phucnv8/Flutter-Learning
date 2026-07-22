# Các kiểu dữ liệu trong Dart

## 1. Kiểu số (Numbers)

Dart có hai kiểu số chính, cùng thuộc lớp cha `num`.

```dart
int soNguyen = 10;        // số nguyên
double soThuc = 3.14;     // số thực
num batKy = 42;           // có thể là int hoặc double
```

| Kiểu     | Mô tả                              |
| -------- | ---------------------------------- |
| `int`    | Số nguyên                          |
| `double` | Số thực (dấu phẩy động)            |
| `num`    | Lớp cha, chứa cả `int` và `double` |

## 2. Chuỗi (String)

```dart
String ten = 'Xin chào';
String noiChuoi = 'Chào $ten';           // nội suy biến
String nhieuDong = '''
Dòng 1
Dòng 2
''';
```

- Dùng nháy đơn `'...'` hoặc nháy kép `"..."`.
- `$bien` hoặc `${bieu_thuc}` để nội suy giá trị vào chuỗi.
- `'''...'''` cho chuỗi nhiều dòng.

## 3. Boolean (bool)

Chỉ nhận hai giá trị `true` hoặc `false`.

```dart
bool dungSai = true;
```

## 4. Danh sách (List)

Tương đương mảng, các phần tử có thứ tự, cho phép trùng lặp.

```dart
List<int> so = [1, 2, 3];
var tenList = ['An', 'Bình'];
```

## 5. Tập hợp (Set)

Không có phần tử trùng lặp, không đảm bảo thứ tự.

```dart
Set<String> mau = {'đỏ', 'xanh', 'đỏ'};  // chỉ còn {'đỏ', 'xanh'}
```

## 6. Bản đồ (Map)

Lưu trữ theo cặp khóa – giá trị (key – value).

```dart
Map<String, int> tuoi = {'An': 20, 'Bình': 22};
```

## 7. Record (Dart 3 trở lên)

Nhóm nhiều giá trị lại thành một, tương tự tuple.

```dart
(int, String) ban = (1, 'An');
```

## 8. Các kiểu đặc biệt

| Kiểu      | Mô tả                                  |
| --------- | -------------------------------------- |
| `dynamic` | Giá trị có thể thay đổi kiểu tùy ý     |
| `Object`  | Lớp cha của gần như mọi thứ trong Dart |
| `Null`    | Đại diện cho giá trị rỗng              |
| `Symbol`  | Ít dùng trong thực tế                  |
| `Runes`   | Dùng cho Unicode, ít gặp               |

## 9. Null Safety

Mặc định biến **không** được phép mang giá trị `null`. Thêm dấu `?` để cho phép `null`.

```dart
String? tenCoTheRong;   // được phép null
int tuoi = 25;          // không được phép null
```

## 10. Khai báo biến: var, final, const

| Từ khóa | Ý nghĩa                                        |
| ------- | ---------------------------------------------- |
| `var`   | Trình biên dịch tự suy ra kiểu                 |
| `final` | Giá trị không đổi, gán một lần khi chạy        |
| `const` | Hằng số tại thời điểm biên dịch (compile-time) |

```dart
var ten = 'An';          // tự suy ra là String
final ngay = DateTime.now();   // xác định lúc chạy
const pi = 3.14159;      // xác định lúc biên dịch
```

---

> **Tóm tắt nhanh:** Dart chia kiểu dữ liệu thành số (`int`, `double`, `num`), chuỗi (`String`), luận lý (`bool`), tập hợp dữ liệu (`List`, `Set`, `Map`, `Record`), và các kiểu đặc biệt (`dynamic`, `Object`, `Null`). Toàn bộ hoạt động trong hệ thống **null safety**.
