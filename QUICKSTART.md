# QUICKSTART — Đưa khóa học lên GitLab trong ~10 phút

> Dành cho Tech Lead. Repo đích: `https://gitlab-new.vndirect.com.vn/ipas-fe/rnd/flutter-and-dart-course`

## Cách A — Dùng script (nhanh nhất)

Giải nén bộ file, mở terminal **trong thư mục `flutter-and-dart-course/`**:

```bash
REMOTE_URL="https://gitlab-new.vndirect.com.vn/ipas-fe/rnd/flutter-and-dart-course.git" \
bash setup.sh
```

Script sẽ: `git init` → gắn remote → commit → push lên `main`, rồi in ra checklist việc cần bấm trên GitLab.

> Nếu repo **đã có sẵn nội dung**: chạy `git clone` repo đó, copy các file trong bộ này vào, rồi `git add -A && git commit && git push`. Đừng ép push đè lịch sử người khác.

## Cách B — Thủ công (nếu muốn kiểm soát từng bước)

```bash
cd flutter-and-dart-course
git init && git checkout -b main
chmod +x ci/*.sh docs/build_site.sh setup.sh
git remote add origin https://gitlab-new.vndirect.com.vn/ipas-fe/rnd/flutter-and-dart-course.git
git add -A
git commit -m "chore: khởi tạo khóa học Flutter & Dart"
git push -u origin main
```

## Sau khi push — cấu hình một lần trên GitLab

Làm theo thứ tự (đầy đủ trong [`docs/guides/repo-setup-checklist.md`](docs/guides/repo-setup-checklist.md)):

1. **Protect `main`** — Settings → Repository → Protected branches. Bật *Pipelines must succeed* + *All threads resolved*.
2. **Approvals** — Settings → Merge requests → tối thiểu 1 approval.
3. **Labels** — chạy:
   ```bash
   export GITLAB_URL="https://gitlab-new.vndirect.com.vn"
   export PROJECT_ID="<xem ở Settings → General>"
   export GITLAB_TOKEN="<Personal Access Token, scope: api>"
   bash ci/create_labels.sh
   ```
4. **Milestones** `Module 01`…`Module 10` + 2 **Boards** (Knowledge Flow, Submissions).
5. **Coverage parsing** — Settings → CI/CD: `lines\.*:\s*(\d+\.\d+)%`
6. **Pages** — Settings → Pages: lấy URL website giáo trình (hiện sau khi pipeline `pages` chạy xong).
7. **Members** — thêm 20 dev (Developer); Tech Lead + 1–2 senior (Maintainer).
8. **Ghim Issue chào mừng** + điền [`docs/guides/module-owners.md`](docs/guides/module-owners.md).

## Kiểm tra website giáo trình trước khi push (tùy chọn)

```bash
pip install -r docs/requirements.txt
bash docs/build_site.sh serve      # mở http://127.0.0.1:8000
```

## Xong!

- Website tự cập nhật mỗi khi merge vào `main`.
- Bài nộp (MR) tự chấm bằng CI.
- Hỏi–đáp/thảo luận qua Issues; theo dõi bằng Boards + Milestones.
