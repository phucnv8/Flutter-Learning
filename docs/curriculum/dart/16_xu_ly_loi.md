# 16. Xử Lý Lỗi

### 16.1 `try` / `catch` / `finally`

```dart
void main() {
  try {
    final result = int.parse('abc'); // ném FormatException
    print(result);
  } on FormatException catch (e) {
    print('Lỗi format: ${e.message}');
  } on RangeError catch (e, stackTrace) {
    print('Lỗi range: $e');
    print(stackTrace);
  } catch (e) {
    // Bắt mọi lỗi còn lại
    print('Lỗi không xác định: $e');
  } finally {
    // Luôn chạy — dùng để cleanup
    print('Xong rồi!');
  }
}
```

### 16.2 `throw` — Ném lỗi

Có thể throw bất cứ Object nào, nhưng tốt nhất dùng `Exception` hoặc `Error`:

```dart
// Exception — lỗi "có thể recover" (thiếu input, mạng lỗi, v.v.)
void validateAge(int age) {
  if (age < 0) throw ArgumentError('Tuổi không được âm: $age');
  if (age > 150) throw RangeError.range(age, 0, 150, 'age');
}

// Error — lỗi lập trình, không nên catch (StackOverflow, OutOfMemory...)
void riskyOperation() {
  throw StateError('Gọi hàm này không đúng trạng thái');
}
```

### 16.3 Custom Exception

```dart
class AppException implements Exception {
  final String code;
  final String message;
  final Object? cause;

  const AppException(this.code, this.message, {this.cause});

  @override
  String toString() => 'AppException[$code]: $message'
      '${cause != null ? ' (caused by: $cause)' : ''}';
}

class NetworkException extends AppException {
  final int statusCode;
  NetworkException(this.statusCode, String message)
      : super('NETWORK_ERROR', message);
}

class ValidationException extends AppException {
  final String field;
  ValidationException(this.field, String message)
      : super('VALIDATION_ERROR', message);
}

// Sử dụng
Future<void> fetchUser(String id) async {
  if (id.isEmpty) throw ValidationException('id', 'ID không được rỗng');
  // Giả lập lỗi mạng
  throw NetworkException(404, 'User không tồn tại');
}

void main() async {
  try {
    await fetchUser('');
  } on ValidationException catch (e) {
    print('Validate field ${e.field}: ${e.message}');
  } on NetworkException catch (e) {
    print('HTTP ${e.statusCode}: ${e.message}');
  } on AppException catch (e) {
    print('App error: $e');
  }
}
```

### 16.4 `rethrow` — Ném lại lỗi

```dart
Future<void> processData() async {
  try {
    await fetchUser('123');
  } catch (e) {
    print('Logging error: $e');
    rethrow; // Ném lại lỗi gốc (giữ nguyên stack trace)
  }
}
```

### 16.5 Result Pattern (không dùng exception)

Trong nhiều codebase Dart hiện đại (đặc biệt Flutter), người ta dùng pattern `Result` thay vì throw:

```dart
sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T value;
  const Success(this.value);
}

class Failure<T> extends Result<T> {
  final Object error;
  const Failure(this.error);
}

Result<int> divide(int a, int b) {
  if (b == 0) return Failure(ArgumentError('Chia cho 0'));
  return Success(a ~/ b);
}

void main() {
  final result = divide(10, 2);
  switch (result) {
    case Success(:final value): print('Kết quả: $value');
    case Failure(:final error): print('Lỗi: $error');
  }
}
```
