# 15. Stream

### 15.1 Stream là gì?

`Stream` là chuỗi các giá trị bất đồng bộ theo thời gian — giống như `Future` nhưng phát ra nhiều giá trị thay vì một. Analogies:

- `Future<T>` → một bức thư (một giá trị duy nhất)
- `Stream<T>` → tin nhắn liên tục từ một người (nhiều giá trị)

### 15.2 Tạo Stream

```dart
// 1. Stream từ Iterable
Stream<int> numbersStream() => Stream.fromIterable([1, 2, 3, 4, 5]);

// 2. Stream.periodic — phát mỗi N giây
Stream<int> ticker() => Stream.periodic(
  Duration(seconds: 1),
  (count) => count,
).take(5); // chỉ lấy 5 giá trị

// 3. async* generator (phổ biến nhất)
Stream<int> countDown(int from) async* {
  for (int i = from; i >= 0; i--) {
    await Future.delayed(Duration(milliseconds: 500));
    yield i; // phát một giá trị
  }
}

// 4. StreamController — kiểm soát thủ công
import 'dart:async';

Stream<String> eventStream() {
  final controller = StreamController<String>();

  // Thêm data
  controller.sink.add('Event 1');
  controller.sink.add('Event 2');
  controller.sink.addError(Exception('Something went wrong'));
  controller.sink.close();

  return controller.stream;
}
```

### 15.3 Lắng nghe Stream

```dart
void main() async {
  // Cách 1: listen()
  final stream = countDown(3);
  stream.listen(
    (value) => print('Value: $value'),
    onError: (e) => print('Error: $e'),
    onDone: () => print('Stream completed!'),
  );

  // Cách 2: await for (sạch hơn, xử lý lỗi với try/catch)
  await for (final value in countDown(3)) {
    print('Countdown: $value');
  }
}
```

### 15.4 Stream Transformations

```dart
void main() async {
  final stream = Stream.fromIterable([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);

  await stream
      .where((n) => n.isEven)          // lọc số chẵn
      .map((n) => n * n)               // bình phương
      .take(3)                         // lấy 3 phần tử đầu
      .forEach(print);                 // 4, 16, 36
}
```

### 15.5 Single vs Broadcast Stream

```dart
void main() async {
  // Single-subscription stream — chỉ 1 listener
  final single = Stream.fromIterable([1, 2, 3]);
  single.listen(print); // OK
  // single.listen(print); // LỖI — đã có listener

  // Broadcast stream — nhiều listener
  final controller = StreamController<int>.broadcast();
  final broadcast = controller.stream;

  broadcast.listen((v) => print('Listener 1: $v'));
  broadcast.listen((v) => print('Listener 2: $v'));

  controller.add(1);
  controller.add(2);
  await controller.close();
  // Listener 1: 1
  // Listener 2: 1
  // Listener 1: 2
  // Listener 2: 2
}
```

### 15.6 StreamController & Sink

```dart
class EventBus {
  final _controller = StreamController<String>.broadcast();

  Stream<String> get events => _controller.stream;

  void publish(String event) => _controller.sink.add(event);

  void dispose() => _controller.close();
}

void main() async {
  final bus = EventBus();

  bus.events
      .where((e) => e.startsWith('user:'))
      .listen((e) => print('User event: $e'));

  bus.publish('user:login');
  bus.publish('system:shutdown');
  bus.publish('user:logout');
  // User event: user:login
  // User event: user:logout

  bus.dispose();
}
```
