# FAQ — Câu hỏi thường gặp

> Tổng hợp từ các Issue `type::question` đã được chuẩn hóa. Thêm câu hỏi mới sau mỗi buổi chuẩn hóa (Docs MR).

## Về khóa học & quy trình

**Q: Tôi mới, chưa biết gì Flutter, bắt đầu từ đâu?**
A: Đọc `docs/00-getting-started.md` → cài môi trường → làm Module 01. Cứ hỏi thoải mái bằng Issue.

**Q: Nộp bài ở đâu và như thế nào?**
A: Trong `submissions/<username>/module-NN/`, mở Merge Request với template *Assignment Submission*. Xem `docs/guides/submission-and-grading.md`.

**Q: Không phải senior thì có được trả lời câu hỏi/ review bài không?**
A: Rất khuyến khích. Peer review và trả lời câu hỏi là cách học tốt nhất.

**Q: CI báo đỏ, tôi phải làm gì?**
A: Đọc log job đỏ. Thường là format (`dart format .`) hoặc analyze (`dart analyze`). Sửa local, push lại.

**Q: Kiến thức được "chuẩn hóa" nghĩa là gì?**
A: Sau buổi meeting cuối module, nhóm thống nhất cách hiểu đúng và đưa vào `docs/curriculum/`. Đó là nguồn sự thật chính thức.

## Về Dart/Flutter (bổ sung dần)

**Q: `final` và `const` khác gì nhau?**
A: `final` = gán một lần lúc runtime. `const` = hằng biết tại compile-time, bất biến sâu. Ưu tiên `const` cho widget/giá trị cố định.

**Q: Khi nào StatelessWidget, khi nào StatefulWidget?**
A: Stateless khi UI chỉ phụ thuộc input (không đổi nội tại). Stateful khi có state thay đổi theo tương tác/thời gian.

<!-- Thêm mục mới ở đây sau mỗi module. Định dạng Q/A ngắn gọn, link tới Issue gốc nếu cần. -->
