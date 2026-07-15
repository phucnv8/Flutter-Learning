# Repo Setup Checklist — Dành cho Maintainer (cấu hình 1 lần)

> Làm theo danh sách này sau khi push bộ file lên repo. Tất cả tính năng dùng đều có ở **GitLab Free**.

## 1. Push cấu trúc & bật Wiki

- [ ] Push toàn bộ thư mục này lên nhánh `main`.
- [ ] **Settings → General → Visibility**: bật **Wiki** (nếu muốn dùng Wiki song song với `docs/`).
- [ ] (Tùy chọn) Đồng bộ nội dung `docs/` sang GitLab Wiki, hoặc chỉ dùng `docs/` trong repo cho gọn (khuyến nghị: giữ trong repo để review qua MR).

## 2. Bảo vệ nhánh `main`

**Settings → Repository → Protected branches:**

- [ ] `main`: **Allowed to merge** = Maintainers; **Allowed to push** = No one.
- [ ] **Settings → Merge requests:**
  - [ ] Merge method: **Squash commits** (khuyến nghị).
  - [ ] Bật **Pipelines must succeed**.
  - [ ] Bật **All threads must be resolved**.

## 3. Approvals

**Settings → Merge requests → Merge request approvals:**

- [ ] Approvals required: **1** tối thiểu.
- [ ] (Tùy chọn) Approval rule riêng: MR trong `docs/` cần Module Owner approve.

## 4. CI/CD

- [ ] **Settings → CI/CD → Runners**: đảm bảo có runner Docker khả dụng.
- [ ] **Settings → CI/CD → General pipelines → Test coverage parsing**: dán
      `lines\.*:\s*(\d+\.\d+)%`
- [ ] Chạy thử pipeline bằng một MR nộp bài mẫu.

## 5. Labels, Milestones, Boards

- [ ] Tạo labels: chạy `ci/create_labels.sh` hoặc tạo tay theo `docs/guides/labels-and-boards.md`.
- [ ] Tạo **Milestones** `Module 01` … `Module 10`.
- [ ] Tạo 2 **Boards**: *Knowledge Flow* và *Submissions* (xem `collaboration.md`).

## 6. Quyền thành viên

- [ ] Thêm 20 thành viên với role **Developer** (mở MR, comment, push branch).
- [ ] Tech Lead + 1–2 senior: role **Maintainer**.

## 7. Templates

- [ ] Xác nhận Issue/MR templates xuất hiện khi tạo mới (GitLab tự nhận `.gitlab/issue_templates/` và `.gitlab/merge_request_templates/`).
- [ ] (Tùy chọn) **Settings → Merge requests → Default description template**: chọn `Assignment_Submission`.

## 8. Chốt sổ

- [ ] Đăng 1 Issue "📢 Welcome & how to start" ghim (pin) lên đầu.
- [ ] Điền `docs/guides/module-owners.md` với người phụ trách các module đầu.
