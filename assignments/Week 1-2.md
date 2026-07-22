# Tuần 1 — Dart cho Dev Web · CHECKLIST TỰ HỌC

---

## 🟢 PHẦN 1 — CƠ BẢN (bắt buộc phải biết)

Không qua được phần này thì không code Flutter được. Ưu tiên 60% thời gian tuần cho phần này, đặc biệt mục **Null Safety**.

### 1. Entry point & cấu trúc file

- [ ] Viết được chương trình Dart nhỏ nhất chạy được.
- ❓ Hàm `main()` là gì, có mấy dạng chữ ký? `print()` từ đâu ra, có cần import không?
- ❓ Cú pháp `import` khác gì `import` của JS/TS (dùng dấu gì, có `export default` không)?

### 2. Biến: `var` / `final` / `const` / `late`

- [ ] Khai báo biến bằng cả 4 từ khoá và giải thích khác nhau.
- ❓ `final` vs `const` khác nhau ở điểm gì (thời điểm nào giá trị được biết)?
- ❓ `late` dùng khi nào? Điều gì xảy ra nếu đọc biến `late` trước khi gán?
- ❓ Đối chiếu với `let`/`const` của JS — có gì giống và khác?

### 3. Kiểu dữ liệu cơ bản

- [ ] Dùng thử `int`, `double`, `num`, `String`, `bool`, `dynamic`, `Object`.
- ❓ Dart là ngôn ngữ **statically typed** hay **dynamically typed**? Điều đó nghĩa là gì so với JS?
- ❓ `dynamic` vs `Object` vs `var` khác nhau thế nào?
- ❓ `int` và `double` có tự cộng lẫn nhau được không? `num` là gì?

### 4. ⭐ Null Safety (QUAN TRỌNG NHẤT TUẦN)

- [ ] Khai báo được biến nullable và non-nullable, và trình bày điều gì compiler chặn.
- ❓ `String` và `String?` khác nhau ra sao? Vì sao Dart bắt phân biệt?
- ❓ Các toán tử sau làm gì: `?.` , `??` , `??=` , `!` ?
- ❓ `!` (bang operator) nguy hiểm ở chỗ nào? Khi nào được phép dùng?
- ❓ `late` liên quan gì tới null safety?
- 🔨 Viết hàm nhận `String? name` và trả về lời chào, xử lý trường hợp null **không dùng** `!`.

### 5. String

- [ ] Dùng string interpolation, multiline string, raw string.
- ❓ Nội suy biến vào chuỗi trong Dart viết thế nào (so với template literal `` ` `` của JS)?
- ❓ Khi nào cần `${...}` và khi nào chỉ cần `$...`?

### 6. Collections: `List`, `Set`, `Map`

- [ ] Tạo và thao tác cả 3 loại; dùng `collection-if`, `collection-for`, spread `...`.
- ❓ `List` / `Set` / `Map` tương ứng với gì trong JS?
- ❓ `collection-if` và `collection-for` là gì — viết ví dụ tạo list có phần tử điều kiện.
- ❓ Spread `...` và `...?` (null-aware spread) khác nhau ra sao?

### 7. Hàm

- [ ] Viết hàm với positional param, **named param**, optional param, default value, arrow function.
- ❓ Named parameter là gì (dùng `{}`)? Khi nào bắt buộc phải có `required`?
- ❓ Optional positional (`[]`) khác named optional (`{}`) thế nào?
- ❓ Hàm trong Dart có phải first-class không (truyền hàm làm tham số được không)?

### 8. Control flow

- [ ] Dùng `if/else`, `for`, `for-in`, `while`, `switch`.
- ❓ `switch` trong Dart có cần `break` không? Có gì khác `switch` của JS?

### 9. Class cơ bản

- [ ] Viết 1 class có field, constructor, method, getter/setter.
- ❓ Cú pháp constructor rút gọn `this.x` trong ngoặc constructor nghĩa là gì?
- ❓ Getter/setter khai báo thế nào? Khác gì method thường?

### 10. Async cơ bản

- [ ] Viết hàm `async` trả về `Future`, dùng `await`, giả lập delay bằng `Future.delayed`.
- ❓ `Future<T>` tương ứng với gì trong JS? `async`/`await` giống hay khác?
- ❓ Một hàm `async` **luôn** trả về kiểu gì?

**✅ Checkpoint Cơ bản:** viết được 1 file Dart parse JSON giả (Map) vào biến, xử lý field nullable an toàn, có ít nhất 1 hàm async — chạy không lỗi, không dùng `!`.

---

## 🟡 PHẦN 2 — NÊN NẮM VỮNG

Đây là chỗ tách "code chạy được" khỏi "code chuẩn". Cần cho tuần 4 (state) và 5 (kiến trúc).

### 11. Constructor nâng cao

- [ ] Viết named constructor, factory constructor, const constructor, initializer list.
- ❓ `factory` constructor khác constructor thường ở đâu? Dùng để làm gì (vd cache, trả subtype)?
- ❓ `const` constructor cho phép điều gì? Vì sao Flutter cực thích `const`?
- ❓ Initializer list (`: x = ...`) chạy lúc nào?

### 12. Cascade `..` & `this`

- [ ] Dùng cascade để gọi nhiều method trên cùng object.
- ❓ `..` giúp gì? Viết lại 1 đoạn code không cascade thành có cascade.

### 13. Kế thừa & abstract

- [ ] Viết `abstract class` và class con `extends`, dùng `super`, `@override`.
- ❓ `abstract class` là gì, có tạo instance trực tiếp được không?
- ❓ `@override` bắt buộc hay tuỳ chọn? Nó giúp gì?

### 14. Interface, `implements`, mixin (`with`)

- [ ] Dùng `implements` và tạo một `mixin` dùng `with`.
- ❓ Dart không có từ khoá `interface` riêng — vậy "interface" trong Dart là gì?
- ❓ `extends` vs `implements` vs `with` khác nhau ra sao? Khi nào dùng mixin?

### 15. Enum nâng cao (enhanced enums)

- [ ] Viết enum có field, constructor và method.
- ❓ Enhanced enum (Dart 2.17+) làm được gì mà enum cũ không làm được?

### 16. Stream

- [ ] Tạo `Stream`, lắng nghe bằng `await for` và `.listen()`; thử `StreamController`.
- ❓ `Stream` khác `Future` ở đâu (1 giá trị vs nhiều giá trị)?
- ❓ Single-subscription vs broadcast stream khác nhau thế nào?
- ❓ Vì sao phải `cancel` subscription? (liên hệ memory leak)

### 17. Xử lý lỗi

- [ ] Dùng `try/catch/on/finally`, `throw`, tự viết 1 Exception.
- ❓ `Exception` và `Error` trong Dart khác nhau về ý nghĩa thế nào (cái nào nên bắt, cái nào là bug)?
- ❓ `catch (e)` vs `on SomeType catch (e)` khác gì?

### 18. Generics

- [ ] Viết 1 class/hàm generic `<T>`, và 1 generic có ràng buộc `<T extends X>`.
- ❓ Generics giúp gì cho type safety? Đối chiếu với TS generics.

### 19. Iterable methods (tư duy functional)

- [ ] Dùng `map`, `where`, `firstWhere`, `fold`, `reduce`, `any`, `every`, `sort`.
- ❓ `map`/`where` của Dart khác `.map`/`.filter` của JS ở điểm nào (trả về `Iterable` lazy)?
- ❓ Vì sao đôi khi phải gọi `.toList()` ở cuối?

### 20. Dart 3 — Records

- [ ] Tạo record (positional & named field), destructure nó.
- ❓ Record dùng để làm gì? Khi nào dùng record thay vì tạo hẳn 1 class?
- ❓ Hàm trả về nhiều giá trị bằng record viết thế nào?

### 21. Dart 3 — Patterns & pattern matching

- [ ] Dùng `switch` expression, destructuring pattern, `if-case`.
- ❓ Pattern matching giúp code gọn hơn ở đâu so với `if/else` lồng nhau?
- 🔨 Viết `switch` expression xử lý 1 record `(status, data)`.

### 22. Dart 3 — Sealed class & exhaustiveness

- [ ] Viết `sealed class Result` với các subclass, `switch` trên nó.
- ❓ `sealed` giúp compiler làm được gì (gợi ý: exhaustive check)?
- ❓ Vì sao mô hình `sealed class Result { Success / Failure }` lại lý tưởng cho việc gọi API?

### 23. Equality: `==` & `hashCode`

- [ ] So sánh 2 object "giống nội dung" — mặc định trả về gì?
- ❓ Vì sao 2 object cùng nội dung lại `!=` nhau theo mặc định?
- ❓ Value equality là gì? Vì sao immutable + value equality quan trọng cho state management? (đây là lý do dùng `freezed` sau này)

**✅ Checkpoint Nên nắm vững:** viết được `sealed class Result<T>` với `Success`/`Failure`, dùng pattern matching xử lý; giải thích được vì sao dùng immutable + value equality.

---

## 🔴 PHẦN 3 — NÂNG CAO (biết là có, khám phá nếu còn thời gian)

Không bắt buộc thành thạo trong tuần 1, nhưng nên **biết nó tồn tại** để không "phát minh lại bánh xe" sau này.

### 24. Extension methods

- ❓ Extension method là gì? Viết 1 extension thêm method cho `String`.
- ❓ Khi nào extension tốt hơn hàm helper thường?

### 25. Extension types

- ❓ Extension type (Dart 3.3+) khác extension method thế nào? Zero-cost wrapper nghĩa là gì?

### 26. Operator overloading & callable class

- ❓ Có thể override `+`, `==`, `[]` cho class của mình không? Viết ví dụ 1 class `Vector` cộng được bằng `+`.

### 27. Isolates & mô hình concurrency

- ❓ Dart chạy single-threaded với event loop — vậy Isolate là gì?
- ❓ Isolate khác thread thông thường ở đâu (gợi ý: không chia sẻ bộ nhớ)? Khi nào cần `Isolate.run` (vd xử lý nặng để không đơ UI)?

### 28. Event loop: microtask vs event queue

- ❓ Thứ tự chạy giữa `Future`, `Future.microtask`, và code đồng bộ là gì?
- ❓ `Future.wait` vs `Future.any` khác nhau ra sao?

### 29. Typedef & function types

- ❓ `typedef` dùng để đặt tên cho kiểu hàm — viết ví dụ.

### 30. `const` canonicalization & `identical()`

- ❓ Hai `const` object giống hệt nhau có phải cùng 1 instance trong bộ nhớ không? `identical()` trả về gì?

### 31. Code generation (`build_runner`) — cầu nối sang Flutter

- ❓ `build_runner` là gì, các package như `freezed`/`json_serializable`/`riverpod` dùng nó để làm gì?
- ❓ File `*.g.dart` / `*.freezed.dart` từ đâu ra, có commit vào git không?

### 32. Flow analysis & type promotion

- ❓ Vì sao sau khi check `if (x != null)` thì trong block đó `x` được coi là non-null? Cơ chế "promotion" hoạt động thế nào?

**🎯 Kết quả cuối tuần cần nộp:**

1. 1 file Dart tổng hợp: parse JSON giả → model (có field nullable) → xử lý bằng `sealed class Result` → in kết quả qua pattern matching. **Không dùng `!`, không `dynamic`, `dart analyze` sạch.**
2. Bản trả lời (notion/doc) cho toàn bộ câu hỏi ❓ ở Phần 1 & 2 bằng lời của bạn.
3. Ghi lại 3 điều Dart **khác JS/TS** làm bạn bất ngờ nhất.
