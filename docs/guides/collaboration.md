# Quy trình Tương tác & Thảo luận (Collaboration)

> Mục tiêu: mọi kiến thức, câu hỏi, tranh luận đều **được ghi lại và tra cứu được**, không tan biến trong chat. Công cụ chính: **GitLab Issues, Boards, Milestones** (đều miễn phí).

## 1. Kênh nào cho việc gì?

| Nhu cầu | Dùng | Vì sao |
|---------|------|--------|
| Hỏi kiến thức | **Issue** — Question | Lưu lại, người sau tra được |
| Đề xuất chủ đề | **Issue** — Topic Proposal | Đưa vào roadmap có hệ thống |
| Tranh luận cách làm | **Issue** — Discussion | Chốt được kết luận, không trôi |
| Báo lỗi giáo trình | **Issue** — Correction → Docs MR | Sửa có căn cứ |
| Góp ý bài nộp | **Comment trong MR** | Gắn trực tiếp với code |
| Trao đổi nhanh, hẹn giờ | Chat (Teams/Slack) | Nhưng kết luận phải "chốt hạ" về Issue |

> **Nguyên tắc "chốt về Issue":** trao đổi ở chat thoải mái, nhưng mọi *kết luận* phải được ghi vào Issue/MR liên quan để không mất.

## 2. Vòng đời một câu hỏi

```
Mở Issue (Question)  →  Ai cũng có thể trả lời  →  Người hỏi xác nhận đã hiểu
      →  Nếu là kiến thức chung tốt: gắn status::needs-standardization
      →  Đưa vào FAQ/giáo trình qua Docs MR  →  Close issue
```

- **Khuyến khích mọi người trả lời**, không chỉ senior — trả lời là cách học tốt nhất.
- Câu hỏi hay + câu trả lời tốt = ứng viên đưa vào [FAQ](../standards/faq.md).

## 3. Boards — nhìn toàn cảnh

Tạo **Issue Board** (Issues → Boards) với các cột theo label `status::`:

```
┌──────────┬───────────────┬──────────────┬────────────────────────┬────────┐
│  Open    │  In Discussion │  Answered    │  Needs Standardization │  Done  │
│ (mới mở) │ (đang bàn)     │ (đã trả lời) │ (chờ đưa vào giáo trình)│(đã đóng)│
└──────────┴───────────────┴──────────────┴────────────────────────┴────────┘
```

Board thứ hai cho **bài nộp** theo module (label `module::NN`) để Module Owner theo dõi MR nào chờ review.

## 4. Milestones = Module

Mỗi module là một **Milestone**. Gắn mọi Issue/MR của module vào milestone tương ứng để:

- Thấy tiến độ % của cả nhóm theo module.
- Biết còn câu hỏi/bài nộp nào chưa xử lý trước khi chốt module.

## 5. Buổi chuẩn hóa (Standardization Meeting)

Tổ chức **cuối mỗi module**, ~60–90 phút. Đây là trái tim của mô hình peer learning.

**Trước meeting** (Module Owner chuẩn bị):
- Tổng hợp các Issue `status::needs-standardization` của module.
- Liệt kê điểm gây tranh cãi / hiểu khác nhau từ bài nộp.
- Chuẩn bị 3–5 câu hỏi chốt.

**Trong meeting:**
- Đi qua từng điểm, nhóm thảo luận đến khi thống nhất *cách hiểu chuẩn*.
- Người ghi biên bản (rotate) note kết luận ngay vào Issue Discussion của module.

**Sau meeting:**
- Module Owner mở **Docs MR** đưa kiến thức đã chốt vào `docs/curriculum/`, gắn `status::standardized`.
- Close các Issue liên quan, link tới MR chuẩn hóa.
- Cập nhật [FAQ](../standards/faq.md) nếu có câu hỏi lặp lại.

## 6. Nghi thức giao tiếp tốt

- **Threads/replies** thay vì comment rời rạc — giữ mạch thảo luận.
- **Resolve thread** khi vấn đề đã xong (bật *All threads resolved* làm merge check).
- **@mention** đúng người, nhưng đừng spam; ưu tiên để cộng đồng trả lời trước.
- **Ghi nguồn** khi trích tài liệu ngoài.
- Kết thúc mỗi Issue bằng một dòng tóm tắt kết luận để người sau đọc lướt hiểu ngay.

## 7. Nhịp độ đề xuất (self-paced nhưng có điểm hẹn)

Vì khóa self-paced, đặt vài "điểm hẹn" nhẹ để giữ động lực:

- **Async mọi lúc:** hỏi/đáp/nộp bài bất kỳ khi nào.
- **Standup văn bản hàng tuần (tùy chọn):** mỗi người 3 dòng trong Issue "Weekly check-in" — đang học gì, kẹt gì, cần giúp gì.
- **Meeting chuẩn hóa:** khi một module đạt đủ số bài nộp (vd ≥60% thành viên) thì Module Owner hẹn lịch.
