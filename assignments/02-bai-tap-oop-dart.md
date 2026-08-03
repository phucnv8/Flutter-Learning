# Bài Tập OOP Trong Dart

> Tài liệu bài tập kèm theo — Lớp Flutter
> Cấu trúc: mỗi phần gồm **câu hỏi lý thuyết** để kiểm tra hiểu bản chất, và **bài tập code** để luyện tay. Độ khó tăng dần từ Phần A đến Phần D.
> Gợi ý cho giảng viên: đáp án gợi ý nằm ở cuối tài liệu (mục *Đáp án tham khảo*), nên tách ra khi phát cho học viên nếu muốn.

---

## Phần A — Class, Object, Constructor (Cơ bản)

### A. Câu hỏi lý thuyết

1. Sự khác nhau giữa **class** và **object** là gì? Cho một ví dụ trong đời thực.
2. Vì sao trong Dart ta nói "mọi thứ đều là object"? `int`, `null`, và một hàm có phải object không?
3. Named constructor khác gì so với việc overload constructor như trong Java? Tại sao Dart chọn cách này?
4. `const` constructor yêu cầu điều kiện gì về các field? Cho biết một lợi ích của nó trong Flutter.
5. Initializer list (phần sau dấu `:`) chạy vào lúc nào — trước hay sau thân constructor? Nêu một trường hợp bắt buộc phải dùng nó.

### A. Bài tập code

**A1.** Viết class `Student` gồm: `name` (String), `age` (int), `gpa` (double). Viết:
- một constructor thường nhận cả ba tham số;
- một named constructor `Student.freshman(String name)` đặt `age = 18`, `gpa = 0.0`;
- phương thức `describe()` in ra chuỗi mô tả sinh viên.

```dart
void main() {
  final s1 = Student('An', 20, 3.5);
  final s2 = Student.freshman('Bình');
  s1.describe(); // An, 20 tuổi, GPA 3.5
  s2.describe(); // Bình, 18 tuổi, GPA 0.0
}
```

**A2.** Viết class `Rectangle` với hai field `final` là `width`, `height`. Thêm:
- một redirecting constructor `Rectangle.square(double size)`;
- một `const` constructor.
Sau đó chứng minh trong `main()` rằng hai `const Rectangle.square(5)` là *cùng một instance* (dùng `identical`).

**A3. (Dự đoán kết quả)** Không chạy code, hãy đoán output rồi giải thích:

```dart
class Counter {
  int value;
  Counter(this.value);
  Counter.zero() : value = 0;
}

void main() {
  final a = Counter(10);
  final b = Counter.zero();
  b.value = a.value + 5;
  print('${a.value} ${b.value}');
}
```

---

## Phần B — Encapsulation & Inheritance (Trung bình)

### B. Câu hỏi lý thuyết

1. Trong Dart, dấu `_` làm cho một thành viên private ở phạm vi nào — **class** hay **library**? Điều này khác gì so với `private` của Java?
2. Vì sao nên dùng getter thay vì để field public trực tiếp, dù cú pháp gọi giống hệt nhau?
3. Phân biệt `extends` và `implements`. Với `implements`, tại sao ta buộc phải viết lại *tất cả* phương thức?
4. Câu nói "ưu tiên composition hơn inheritance" nghĩa là gì? Cho một ví dụ khi kế thừa là *sai* thiết kế.
5. Từ khóa `super` dùng để làm gì trong constructor của lớp con? Nó phải đứng ở vị trí nào?

### B. Bài tập code

**B1.** Viết class `BankAccount`:
- field `_balance` khởi tạo 0 (private);
- getter `balance` để đọc;
- `deposit(double amount)` và `withdraw(double amount)`;
- ném `ArgumentError` nếu nạp/rút số không hợp lệ (âm, hoặc rút quá số dư).
Viết `main()` thử cả trường hợp hợp lệ và trường hợp gây lỗi (dùng `try/catch`).

**B2.** Cho lớp cha `Employee` có `name`, `baseSalary`, và phương thức `double monthlySalary()`. Tạo hai lớp con:
- `Manager` — lương tháng = base + phụ cấp `bonus`;
- `Intern` — lương tháng = base × `0.5`.
Dùng `@override` và `super` hợp lý. Trong `main()`, tạo một `List<Employee>` chứa cả hai loại và in tổng quỹ lương.

**B3. (Sửa lỗi)** Đoạn code sau không biên dịch được. Tìm và sửa:

```dart
class Animal {
  final String name;
  Animal(this.name);
  void speak() => print('...');
}

class Dog implements Animal {
  Dog(String name);
  void speak() => print('Gâu');
}
```

> Gợi ý: xem lại điều gì `implements` yêu cầu mà đoạn này thiếu.

---

## Phần C — Abstraction, Polymorphism, Interface (Khá)

### C. Câu hỏi lý thuyết

1. Abstract class có thể chứa phương thức *có sẵn thân* (concrete method) không? Nếu có, dùng để làm gì?
2. Dart quyết định gọi phương thức override của lớp con nào vào lúc **biên dịch** hay lúc **runtime**? Tên gọi của cơ chế đó là gì?
3. Vì sao Dart không cần từ khóa `interface`? "Implicit interface" nghĩa là gì?
4. `@override` có bắt buộc không? Nêu một lý do cụ thể nên luôn dùng nó.
5. `covariant` giải quyết vấn đề gì khi override? Cho một tình huống cần đến nó.

### C. Bài tập code

**C1.** Định nghĩa abstract class `Shape` với phương thức trừu tượng `double area()` và một concrete method `void printInfo()` (in ra diện tích). Tạo `Circle`, `Rectangle`, `Triangle` hiện thực `area()`. Viết hàm `Shape largestShape(List<Shape> shapes)` trả về hình có diện tích lớn nhất — minh họa đa hình.

**C2.** Thiết kế một "interface ngầm" `Serializable` với phương thức `Map<String, dynamic> toJson()`. Cho hai lớp *không liên quan huyết thống* — `User` và `Product` — cùng `implements Serializable`. Viết hàm `String encode(Serializable item)` dùng chung cho cả hai.

**C3. (Factory dispatch)** Viết abstract class `Notification` với phương thức `void send(String message)`. Tạo `EmailNotification`, `SmsNotification`, `PushNotification`. Thêm một `factory Notification.create(String type)` trả về đúng loại tương ứng với chuỗi `type` (`'email'`, `'sms'`, `'push'`), ném lỗi nếu không hợp lệ. Giải thích trong comment vì sao đây *phải* là `factory` chứ không phải constructor thường.

---

## Phần D — Mixin, Generics, Enum, Equality (Nâng cao)

### D. Câu hỏi lý thuyết

1. Vì sao mixin **không có** constructor? Điều này nói lên bản chất của mixin là gì?
2. Khi trộn `with A, B` mà cả A và B có phương thức trùng tên, phương thức nào "thắng"? Cơ chế linearization hoạt động ra sao?
3. Từ khóa `on` trong định nghĩa mixin dùng để làm gì?
4. Vì sao khi override `==` ta **bắt buộc** phải override cả `hashCode`? Điều gì hỏng nếu quên?
5. Generics giúp gì cho type-safety? Cho một ví dụ code sẽ *mất an toàn kiểu* nếu không có generics.

### D. Bài tập code

**D1. (Mixin)** Tạo hai mixin `Logger` (phương thức `log(String msg)`) và `Validator` (phương thức `bool isValid()`). Tạo class `Form` trộn cả hai. Chứng minh trong `main()` rằng `Form` gọi được cả `log()` và `isValid()`.

**D2. (Generics)** Viết class generic `Stack<T>` với `push`, `pop` (trả `T?`), `peek`, `isEmpty`, và getter `size`. Test với `Stack<int>` và `Stack<String>`.

**D3. (Enum nâng cao)** Viết enhanced enum `HttpStatus` gồm ít nhất: `ok(200)`, `notFound(404)`, `serverError(500)`. Mỗi giá trị có field `code` (int) và getter `bool get isError => code >= 400`. Viết hàm nhận một `HttpStatus` và in ra thông điệp phù hợp bằng `switch`.

**D4. (Equality)** Viết class `Money` (`amount`, `currency`) override `==` và `hashCode` để so sánh theo giá trị. Chứng minh:
- hai `Money(100, 'VND')` khác instance nhưng `==` trả `true`;
- một `Set<Money>` loại được phần tử trùng.

**D5. (Tổng hợp — mini project)** Xây dựng mô hình nhỏ cho một app "quản lý task", kết hợp nhiều khái niệm:
- abstract class `Task` với `String title` và abstract `bool isDone()`;
- enum `Priority { low, medium, high }`;
- lớp con `SimpleTask` và `RecurringTask`;
- mixin `Timestamped` thêm field `createdAt`;
- override `==`/`hashCode` cho `Task` dựa trên `title`;
- một hàm generic `List<T> filterDone<T extends Task>(List<T> tasks)`.
Viết `main()` tạo vài task và in ra danh sách task chưa hoàn thành, sắp theo `Priority`.

---

## Bài tập mở rộng (tùy chọn / về nhà)

1. **Refactor sang SOLID:** Cho một class `ReportManager` làm cả ba việc: đọc dữ liệu, định dạng, và gửi email. Hãy tách nó theo nguyên tắc Single Responsibility thành các lớp riêng, rồi dùng Dependency Inversion để `ReportManager` phụ thuộc vào abstraction.
2. **Extension:** Viết `extension` cho `List<int>` thêm phương thức `int sumEven()` (tổng các số chẵn) và `double average()`.
3. **Operator overloading:** Viết class `Duration2` (giờ, phút) hỗ trợ toán tử `+` và `<`, tự chuẩn hóa khi phút ≥ 60.
4. **Liên hệ Flutter:** Giải thích bằng lời (không cần code): trong cây widget của Flutter, ba từ khóa `extends`, `with`, `implements` xuất hiện ở đâu, và mỗi cái phục vụ mục đích OOP gì?

---

## Đáp án tham khảo

> Phần này dành cho giảng viên. Đáp án lý thuyết viết ngắn gọn; đáp án code là một hướng giải hợp lệ (không phải duy nhất).

### Phần A

**Lý thuyết:**
1. Class là bản thiết kế; object là thể hiện cụ thể. Ví dụ: "bản vẽ ngôi nhà" (class) vs "ngôi nhà số 5 đã xây" (object).
2. Vì gốc kiểu của Dart là `Object`; `int`, `null`, hàm đều là instance của các lớp (`int`, `Null`, `Function`). Không có kiểu nguyên thủy tách biệt như Java.
3. Named constructor có tên tường minh (`User.fromJson`), diễn đạt ý định rõ ràng; Java overload phân biệt bằng chữ ký, dễ mơ hồ. Dart chọn cách này vì ưu tiên tính dễ đọc.
4. Mọi field phải `final` (immutable). Lợi ích Flutter: widget `const` được canonicalize và tái sử dụng, giảm rebuild.
5. Chạy **trước** thân constructor. Bắt buộc dùng khi khởi tạo `final` field từ dữ liệu chuyển hóa, hoặc gọi `super(...)`/`assert`.

**A1 (gợi ý):**
```dart
class Student {
  final String name;
  final int age;
  final double gpa;

  Student(this.name, this.age, this.gpa);
  Student.freshman(this.name) : age = 18, gpa = 0.0;

  void describe() => print('$name, $age tuổi, GPA $gpa');
}
```

**A2 (gợi ý):**
```dart
class Rectangle {
  final double width;
  final double height;
  const Rectangle(this.width, this.height);
  const Rectangle.square(double size) : this(size, size);
}

void main() {
  const a = Rectangle.square(5);
  const b = Rectangle.square(5);
  print(identical(a, b)); // true
}
```

**A3:** In ra `10 15`. Vì `a` và `b` là hai object độc lập; sửa `b.value` không ảnh hưởng `a.value`. `b.value = 10 + 5 = 15`.

### Phần B

**Lý thuyết:**
1. Private ở phạm vi **library** (file), không phải class. Java `private` là phạm vi class. Nghĩa là trong cùng file, class khác vẫn thấy `_field`.
2. Vì có thể sau này cần thêm logic (validate, tính toán, lazy). Đổi field → getter không phá vỡ code người dùng do cú pháp gọi giống nhau.
3. `extends` kế thừa cả hiện thực và chỉ override khi cần; `implements` chỉ lấy interface, buộc viết lại tất cả vì không kế thừa thân hàm nào.
4. Chỉ kế thừa khi quan hệ đúng là "is-a". Ví dụ sai: cho `Stack` kế thừa `List` — Stack không nên lộ toàn bộ API của List. Nên composition (chứa một List bên trong).
5. `super(...)` gọi constructor cha để khởi tạo phần state của cha; phải là phần tử đầu của initializer list.

**B3 (đáp án):** `Dog implements Animal` nên: (a) `speak()` phải có `@override` và giữ nguyên; (b) `implements` **không** kế thừa field `name`, nên `Dog` phải tự khai báo `name` và hiện thực constructor thật (không chỉ `Dog(String name);` rỗng). Cách sửa nhanh nhất về mặt ngữ nghĩa là dùng `extends` thay cho `implements`, hoặc tự khai báo lại `final String name;` trong `Dog`.

### Phần C

**Lý thuyết:**
1. Có. Dùng để chia sẻ code chung cho mọi lớp con (ví dụ `printInfo()` gọi tới `area()` trừu tượng).
2. Lúc **runtime** — cơ chế **dynamic dispatch**.
3. Vì mọi class tự sinh interface ngầm gồm các thành viên public của nó; dùng `implements` với class bất kỳ là đủ. "Implicit interface" = interface được suy ra tự động từ class.
4. Không bắt buộc, nhưng nên dùng: compiler báo lỗi nếu ta gõ sai tên phương thức cha (nếu không có `@override`, Dart tưởng ta tạo phương thức mới).
5. `covariant` cho phép thu hẹp kiểu tham số khi override (Animal → Cat) mà vẫn hợp lệ; cần khi logic đảm bảo chỉ nhận kiểu con.

**C3 (điểm mấu chốt):** phải là `factory` vì constructor thường bắt buộc tạo instance của *chính* `Notification`, trong khi ở đây ta trả về instance của *lớp con* tùy `type` — đó là factory dispatch, và `factory` không truy cập `this`.

### Phần D

**Lý thuyết:**
1. Vì mixin không phải kiểu để khởi tạo độc lập, mà là "gói hành vi" trộn vào lớp khác; nó không sở hữu vòng đời khởi tạo riêng.
2. Cái khai báo **sau** thắng (linearization từ trái sang phải, cái sau ghi đè cái trước).
3. `on` ràng buộc mixin chỉ áp dụng cho lớp con của một kiểu nhất định (để mixin được phép gọi thành viên của kiểu đó).
4. Vì `Set`/`Map` dùng `hashCode` để phân nhóm rồi mới so `==`. Nếu `==` true nhưng `hashCode` khác nhau, hai object bị xếp khác bucket → Set chứa trùng, Map tra cứu sai.
5. Generics giữ kiểu tĩnh, tránh ép kiểu. Không có generics, `List` chứa `dynamic` → lấy phần tử ra dễ crash runtime do sai kiểu.

**D2 (gợi ý):**
```dart
class Stack<T> {
  final _items = <T>[];
  void push(T item) => _items.add(item);
  T? pop() => _items.isEmpty ? null : _items.removeLast();
  T? peek() => _items.isEmpty ? null : _items.last;
  bool get isEmpty => _items.isEmpty;
  int get size => _items.length;
}
```

**D3 (gợi ý):**
```dart
enum HttpStatus {
  ok(200),
  notFound(404),
  serverError(500);

  const HttpStatus(this.code);
  final int code;
  bool get isError => code >= 400;
}
```

**D4 (điểm mấu chốt):**
```dart
class Money {
  final int amount;
  final String currency;
  const Money(this.amount, this.currency);

  @override
  bool operator ==(Object other) =>
      other is Money && other.amount == amount && other.currency == currency;

  @override
  int get hashCode => Object.hash(amount, currency);
}
```
`Set<Money>{Money(100,'VND'), Money(100,'VND')}` sẽ chỉ còn 1 phần tử.

---

### Thang chấm gợi ý cho bài D5 (mini project)

| Tiêu chí | Điểm |
|---|---|
| Dùng đúng abstract class + phương thức trừu tượng | 2 |
| Enum `Priority` và dùng để sắp xếp | 2 |
| Ít nhất một mixin áp dụng đúng | 2 |
| Override `==`/`hashCode` đúng cặp | 2 |
| Hàm generic có ràng buộc `<T extends Task>` chạy đúng | 2 |

Tổng: 10 điểm. Trừ điểm nếu lạm dụng `dynamic`, hoặc kế thừa sai quan hệ (không phải is-a).
