# 13. Interface, `implements`, Mixin (`with`)

### 13.1 Interface trong Dart

Dart **không có từ khóa `interface`**. Mọi class đều ngầm định là một interface. Bạn dùng `implements` để cam kết implement toàn bộ API của class đó (nhưng không kế thừa implementation):

```dart
class Flyable {
  void fly() => print('Flying...');
  double get maxAltitude => 10000;
}

class Bird implements Flyable {
  @override
  void fly() => print('Bird flaps wings and flies');

  @override
  double get maxAltitude => 3000;
}

class Airplane implements Flyable {
  @override
  void fly() => print('Airplane uses engines to fly');

  @override
  double get maxAltitude => 12000;
}
```

> Khác với `extends`: `implements` **không kế thừa code**, chỉ kế thừa "hợp đồng". Bạn phải viết lại tất cả.

### 13.2 `implements` nhiều interface

```dart
abstract class Swimmable {
  void swim();
}

abstract class Runnable {
  void run();
}

abstract interface class Flyable {
  void fly();
}

class Duck implements Swimmable, Runnable, Flyable {
  @override void swim() => print('Vịt bơi');
  @override void run() => print('Vịt chạy');
  @override void fly() => print('Vịt bay');
}
```

### 13.3 `abstract interface class` (Dart 3)

Từ Dart 3, có thể khai báo rõ ràng một class chỉ dùng làm interface:

```dart
abstract interface class Repository<T> {
  Future<T?> findById(String id);
  Future<List<T>> findAll();
  Future<void> save(T entity);
  Future<void> delete(String id);
}

class UserRepository implements Repository<User> {
  @override Future<User?> findById(String id) async { /* ... */ return null; }
  @override Future<List<User>> findAll() async => [];
  @override Future<void> save(User entity) async {}
  @override Future<void> delete(String id) async {}
}
```

### 13.4 Mixin với `mixin` và `with`

Mixin là cách chia sẻ code giữa nhiều class mà không cần kế thừa. Không giống `extends` (chỉ 1 cha), bạn có thể `with` nhiều mixin:

```dart
mixin Logging {
  void log(String message) {
    print('[${runtimeType}] $message');
  }
}

mixin Validation {
  bool isNotEmpty(String value) => value.trim().isNotEmpty;
  bool isValidEmail(String email) => email.contains('@');
}

mixin Serializable {
  Map<String, dynamic> toJson();

  String serialize() => toJson().toString();
}

class UserService with Logging, Validation {
  void createUser(String name, String email) {
    if (!isNotEmpty(name)) {
      log('Name is empty!');
      return;
    }
    if (!isValidEmail(email)) {
      log('Invalid email: $email');
      return;
    }
    log('Creating user: $name ($email)');
  }
}

void main() {
  final service = UserService();
  service.createUser('Alice', 'alice@example.com');
  // [UserService] Creating user: Alice (alice@example.com)
  service.createUser('', 'bad-email');
  // [UserService] Name is empty!
}
```

### 13.5 `on` — Giới hạn Mixin áp dụng cho class nào

```dart
class Animal {
  String name;
  Animal(this.name);
}

// Mixin này chỉ được dùng bởi subclass của Animal
mixin CanFly on Animal {
  void fly() => print('$name đang bay');
}

class Bird extends Animal with CanFly {
  Bird(super.name);
}

// class Car with CanFly {} // LỖI — Car không extend Animal
```

### 13.6 So sánh `extends`, `implements`, `with`

|                     | `extends`  | `implements` | `with`           |
| ------------------- | ---------- | ------------ | ---------------- |
| Số lượng            | 1          | Nhiều        | Nhiều            |
| Kế thừa code        | Có         | Không        | Có               |
| Kế thừa constructor | Có         | Không        | Không            |
| Mục đích            | Chuyên hóa | Cam kết API  | Tái sử dụng code |
