# Learning Roadmap — Flutter & Dart

> **Đối tượng:** Developer có kinh nghiệm lập trình, lần đầu học Flutter/Dart.
> **Nhịp độ:** Self-paced (tự điều chỉnh). Roadmap chia theo **module**, không ràng buộc theo tuần. Mỗi module có: mục tiêu → bài giảng → bài tập → thảo luận & chuẩn hóa.
> **Điều kiện hoàn thành module:** Nộp bài đạt (CI pass + review approve) và tham gia buổi chuẩn hóa.

---

## Tổng quan lộ trình

```
Track A — Dart Language          Track B — Flutter Core          Track C — Production-Ready
─────────────────────────        ─────────────────────────       ──────────────────────────
M1  Dart Fundamentals       →    M4  Widgets & Layout       →    M7  State Management
M2  Async & Streams         →    M5  Navigation & Routing   →    M8  Testing
M3  OOP, Generics, Null      →    M6  Networking & Data      →    M9  Architecture & Perf
    Safety                                                        M10 CI/CD & Release
```

Thứ tự khuyến nghị: **M1 → M10 tuần tự**. M1–M3 nền tảng Dart nên hoàn thành trước khi vào Flutter.

---

## Track A — Dart Language

### Module 01 — Dart Fundamentals
**Mục tiêu:** Nắm cú pháp Dart, kiểu dữ liệu, biến, hàm, collection, control flow.
**Bài giảng:** [`docs/curriculum/module-01-dart-fundamentals.md`](docs/curriculum/module-01-dart-fundamentals.md)
**Bài tập:** [`assignments/module-01-dart-fundamentals/`](assignments/module-01-dart-fundamentals/)
**So với ngôn ngữ bạn đã biết:** sound type system, `var`/`final`/`const`, không có `null` mặc định.

### Module 02 — Async, Future & Stream
**Mục tiêu:** `Future`, `async/await`, `Stream`, error handling, isolate cơ bản.
**Điểm dễ vấp:** event loop đơn luồng, khác thread model của Java/C#.

### Module 03 — OOP, Generics & Null Safety
**Mục tiêu:** class, mixin, extension, generics, sound null safety (`?`, `!`, `late`, `required`).
**Điểm dễ vấp:** mixin vs interface vs abstract class; null-safety migration mindset.

---

## Track B — Flutter Core

### Module 04 — Widgets & Layout
**Mục tiêu:** Everything is a widget; StatelessWidget vs StatefulWidget; layout (Row/Column/Stack/Flex); BuildContext & widget tree.
**Điểm dễ vấp:** rebuild, `const` constructor để tối ưu, khác biệt với imperative UI.

### Module 05 — Navigation & Routing
**Mục tiêu:** Navigator 1.0/2.0, named routes, `go_router`, truyền dữ liệu giữa màn hình, deep link.

### Module 06 — Networking & Data
**Mục tiêu:** `http`/`dio`, JSON serialization (`json_serializable`), local storage (`shared_preferences`, `sqflite`/`drift`), repository pattern.

---

## Track C — Production-Ready

### Module 07 — State Management
**Mục tiêu:** So sánh & thực hành: `setState`, `Provider`, `Riverpod`, `Bloc`. Chọn giải pháp phù hợp use-case.
**Ghi chú:** Đây là module gây tranh luận nhiều nhất → dành thời gian cho buổi chuẩn hóa.

### Module 08 — Testing
**Mục tiêu:** unit test, widget test, integration test, mocking (`mocktail`), coverage.

### Module 09 — Architecture & Performance
**Mục tiêu:** Clean Architecture / feature-first, DI (`get_it`), DevTools, tránh jank, tối ưu rebuild.

### Module 10 — CI/CD & Release
**Mục tiêu:** flavors, build Android/iOS, code signing cơ bản, GitLab CI cho Flutter, phân phối nội bộ.

---

## Cách theo dõi tiến độ

- Mỗi module là một **Milestone** trong GitLab. Vào **Issues → Milestones** để xem.
- Bài nộp của bạn là các **Merge Request** gắn label `module::NN`.
- Tự đánh dấu tiến độ trong `submissions/<your-username>/PROGRESS.md` (template có sẵn).

## Ai sở hữu module nào?

Bảng phân công Module Owner được duy trì tại [`docs/guides/module-owners.md`](docs/guides/module-owners.md). Senior đăng ký nhận module tại đó.
