# Flutter & Dart Course — Internal Knowledge Base

> Khóa học nội bộ theo mô hình **Peer Learning** (học ngang hàng): mọi thành viên vừa **dạy**, vừa **học**, vừa **chia sẻ**. Tài liệu song ngữ Việt–Anh, dành cho developer đã có kinh nghiệm lập trình, lần đầu tiếp cận Flutter/Dart.

---

## 🚀 Start here — Đọc theo thứ tự này nếu bạn mới vào

| # | Bạn muốn... | Đọc file |
|---|-------------|----------|
| 1 | Hiểu khóa học vận hành thế nào | [`docs/00-getting-started.md`](docs/00-getting-started.md) |
| 2 | Xem lộ trình học & thứ tự module | [`ROADMAP.md`](ROADMAP.md) |
| 3 | Biết cách cư xử & quy tắc chung | [`CODE_OF_CONDUCT.md`](CODE_OF_CONDUCT.md) |
| 4 | Biết cách đóng góp: nộp bài, hỏi, đề xuất | [`CONTRIBUTING.md`](CONTRIBUTING.md) |
| 5 | Bắt đầu học module đầu tiên | [`docs/curriculum/module-01-dart-fundamentals.md`](docs/curriculum/module-01-dart-fundamentals.md) |

---

## 🗺️ Bản đồ Knowledge Base

```
flutter-and-dart-course/
├── README.md                     ← Bạn đang ở đây (cổng thông tin)
├── ROADMAP.md                    ← Lộ trình học theo module
├── CODE_OF_CONDUCT.md            ← Quy tắc ứng xử
├── CONTRIBUTING.md               ← Hướng dẫn tham gia (dạy–học–sharing)
├── DESIGN.md                     ← Thiết kế tổng thể quy trình (dành cho tech lead/senior)
├── .gitlab-ci.yml                ← Pipeline chấm bài tự động
│
├── docs/                         ← GIÁO TRÌNH (nguồn kiến thức đã chuẩn hóa)
│   ├── 00-getting-started.md
│   ├── curriculum/               ← Bài giảng từng module
│   ├── standards/                ← Coding convention, glossary, review rubric
│   └── guides/                   ← How-to: setup, nộp bài, hỏi–đáp
│
├── assignments/                  ← ĐỀ BÀI TẬP (do senior biên soạn)
│   └── module-01-.../
│
├── submissions/                  ← NƠI HỌC VIÊN NỘP BÀI (mỗi người 1 thư mục)
│
└── .gitlab/                      ← Templates cho Issue & Merge Request
    ├── issue_templates/
    └── merge_request_templates/
```

---

## 👥 Vai trò trong khóa học — Ai làm gì?

Khóa học **không có giảng viên cố định**. Mọi người luân phiên đảm nhận vai trò theo module.

| Vai trò | Ai | Trách nhiệm chính |
|---------|-----|-------------------|
| **Maintainer** | Tech Lead + 1–2 senior | Quản trị repo, merge MR cuối cùng, giữ nhịp khóa học |
| **Module Owner** | Senior (luân phiên theo module) | Nghiên cứu & viết giáo trình, ra dàn ý, soạn đề bài + câu hỏi thảo luận, review bài nộp |
| **Learner** | Tất cả thành viên | Tự nghiên cứu, làm bài, nộp qua MR, đặt câu hỏi, raise issue, tham gia thảo luận |
| **Reviewer** | Bất kỳ ai (peer review) | Đọc & góp ý bài nộp của người khác trước khi Module Owner duyệt |

> Nguyên tắc: **Ai cũng có thể mở Issue, đặt câu hỏi, đề xuất topic, sửa tài liệu** — miễn là liên quan đến kiến thức. Xem [`CONTRIBUTING.md`](CONTRIBUTING.md).

---

## 🔁 Vòng đời một module (tóm tắt)

```
Module Owner soạn giáo trình + đề bài  →  Learner tự học  →  Nộp bài qua MR
        →  Peer review + CI tự động chấm  →  Module Owner duyệt
        →  Meeting thảo luận & chuẩn hóa  →  Cập nhật kiến thức chuẩn vào docs/
```

Chi tiết đầy đủ trong [`DESIGN.md`](DESIGN.md).

---

## 🏷️ Điều hướng nhanh bằng Labels & Boards

Vào **Issues → Board** để xem trạng thái mọi thứ đang diễn ra. Các nhãn chính:

- `type::question` — câu hỏi cần giải đáp
- `type::topic-proposal` — đề xuất chủ đề học mới
- `type::correction` — báo lỗi / đề xuất sửa giáo trình
- `type::discussion` — chủ đề thảo luận mở
- `module::01` … `module::N` — gắn theo module
- `status::needs-standardization` — kiến thức chờ chuẩn hóa vào giáo trình
- `good-first-question` — dễ, khuyến khích người mới trả lời

Danh sách đầy đủ & cách dùng: [`docs/guides/labels-and-boards.md`](docs/guides/labels-and-boards.md).

---

## ✅ Checklist cho thành viên mới (Day 1)

- [ ] Đọc `docs/00-getting-started.md` và `CODE_OF_CONDUCT.md`
- [ ] Cài môi trường theo `docs/guides/environment-setup.md`
- [ ] Fork/clone repo, tạo thư mục `submissions/<your-username>/`
- [ ] Mở 1 Issue giới thiệu bản thân (dùng template *Question* cũng được) để làm quen luồng
- [ ] Xem `ROADMAP.md`, bắt đầu Module 01

---

*Khóa học này là "tài sản sống": mỗi lần thảo luận và chuẩn hóa, giáo trình lại tốt hơn cho khóa sau. Cảm ơn bạn đã đóng góp. 💙*
