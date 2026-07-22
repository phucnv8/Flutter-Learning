# Lập trình bất đồng bộ (Async) trong Dart

## 1. Tại sao cần Async?

Dart chạy trên một luồng chính (single-threaded) với **event loop**. Các tác vụ tốn thời gian như gọi API, đọc file, truy vấn database... nếu chạy đồng bộ sẽ làm "đơ" chương trình. Lập trình bất đồng bộ cho phép chương trình tiếp tục làm việc khác trong khi chờ tác vụ hoàn thành.

Hai công cụ cốt lõi: **Future** (một giá trị trong tương lai) và **Stream** (chuỗi nhiều giá trị theo thời gian).

## 2. Future

`Future<T>` đại diện cho một giá trị kiểu `T` sẽ có **trong tương lai** — kết quả của một tác vụ bất đồng bộ. Nó có 3 trạng thái: chưa hoàn thành (uncompleted), hoàn thành thành công (completed with value), hoặc lỗi (completed with error).

```dart
Future<String> fetchData() {
  return Future.delayed(
    Duration(seconds: 2),
    () => "Dữ liệu đã tải xong",
  );
}
```

### Tạo Future nhanh

```dart
Future.value(42);                       // Future hoàn thành ngay với 42
Future.error("Có lỗi");                 // Future lỗi
Future.delayed(Duration(seconds: 1));   // hoàn thành sau 1 giây
```

## 3. async / await

Cách hiện đại và dễ đọc nhất để làm việc với Future.

- `async`: đánh dấu hàm là bất đồng bộ (luôn trả về Future).
- `await`: tạm dừng hàm cho tới khi Future hoàn thành, rồi lấy giá trị.

```dart
Future<String> fetchData() {
  return Future.delayed(Duration(seconds: 2), () => "Xong");
}

Future<void> main() async {
  print("Bắt đầu tải...");
  String result = await fetchData(); // chờ 2 giây
  print(result);                     // Xong
  print("Kết thúc");
}
```

Chỉ được dùng `await` bên trong hàm có đánh dấu `async`.

## 4. Xử lý lỗi với try/catch

```dart
Future<int> risky() async {
  throw Exception("Lỗi kết nối");
}

Future<void> main() async {
  try {
    int value = await risky();
    print(value);
  } catch (e) {
    print("Bắt lỗi: $e");
  } finally {
    print("Luôn chạy dù lỗi hay không");
  }
}
```

## 5. API dạng .then() (callback)

Cách cũ hơn, dùng callback thay vì await. Vẫn hữu ích trong một số trường hợp.

```dart
fetchData()
  .then((value) => print("Kết quả: $value"))
  .catchError((e) => print("Lỗi: $e"))
  .whenComplete(() => print("Hoàn thành"));
```

So sánh: `async/await` dễ đọc hơn, đặc biệt khi có nhiều bước tuần tự (tránh "callback hell").

## 6. Chạy nhiều Future song song

### Tuần tự (chậm — cộng dồn thời gian)

```dart
Future<void> main() async {
  var a = await task1(); // chờ xong task1
  var b = await task2(); // rồi mới chờ task2
}
```

### Song song với Future.wait (nhanh — chạy đồng thời)

```dart
Future<int> task1() async {
  await Future.delayed(Duration(seconds: 2));
  return 1;
}
Future<int> task2() async {
  await Future.delayed(Duration(seconds: 3));
  return 2;
}

Future<void> main() async {
  // Cả hai chạy cùng lúc, tổng thời gian ~3 giây (không phải 5)
  List<int> results = await Future.wait([task1(), task2()]);
  print(results); // [1, 2]
}
```

## 7. Stream

`Stream<T>` là chuỗi các sự kiện/giá trị được phát ra **liên tục theo thời gian** (khác Future chỉ trả một giá trị duy nhất). Ví dụ: dữ liệu từ WebSocket, sự kiện nhấn nút, đọc file theo từng phần.

### Tạo Stream

```dart
// Phát 1 giá trị mỗi giây
Stream<int> countStream() async* {
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i; // phát giá trị
  }
}
```

- `async*`: đánh dấu hàm trả về Stream (generator bất đồng bộ).
- `yield`: phát ra một giá trị vào stream.

### Lắng nghe Stream với await for

```dart
Future<void> main() async {
  await for (int value in countStream()) {
    print("Nhận: $value"); // 1, 2, 3, 4, 5 (mỗi giây một số)
  }
  print("Stream kết thúc");
}
```

### Lắng nghe với listen()

```dart
void main() {
  countStream().listen(
    (value) => print("Nhận: $value"),
    onError: (e) => print("Lỗi: $e"),
    onDone: () => print("Xong"),
  );
}
```

### Các phương thức xử lý Stream

```dart
Stream<int> s = countStream();

s.where((n) => n.isEven);   // lọc
s.map((n) => n * 2);        // biến đổi
s.take(3);                  // lấy 3 giá trị đầu
await s.first;              // giá trị đầu tiên
await s.length;             // đếm số phần tử
await s.toList();           // gom thành List
```

## 8. So sánh Future và Stream

| Đặc điểm | Future | Stream |
|----------|--------|--------|
| Số giá trị | Một (duy nhất) | Nhiều (theo thời gian) |
| Từ khóa hàm | `async` | `async*` |
| Lấy giá trị | `await` | `await for` / `listen` |
| Phát giá trị | `return` | `yield` |
| Ví dụ | Gọi API một lần | Sự kiện click, dữ liệu realtime |

## 9. Event loop — cách Dart xử lý bất đồng bộ

Dart chạy đơn luồng nhưng dùng **event loop** với hai hàng đợi:

- **Microtask queue**: ưu tiên cao (Future đã hoàn thành, scheduleMicrotask).
- **Event queue**: các sự kiện I/O, timer, tương tác người dùng.

Event loop luôn xử lý hết microtask trước, rồi mới đến một event tiếp theo. Điều này giải thích thứ tự thực thi:

```dart
void main() {
  print("1");
  Future(() => print("3 - event queue"));
  Future.microtask(() => print("2 - microtask"));
  print("1 (đồng bộ chạy trước hết)");
}
// Thứ tự in: 1 -> 1 (đồng bộ) -> 2 (microtask) -> 3 (event)
```

## 10. Một số lưu ý

- `await` chỉ dừng hàm hiện tại, không chặn toàn bộ chương trình.
- Hàm `async` luôn trả về `Future`, kể cả khi bạn `return` một giá trị thường.
- Nên luôn xử lý lỗi (try/catch hoặc catchError) để tránh unhandled exception.
- Dùng `Future.wait` khi các tác vụ độc lập để tăng tốc.
