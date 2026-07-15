# Website giáo trình — MkDocs + GitLab Pages

> Biến thư mục `docs/` thành một website tĩnh có mục lục & search, tự động cập nhật mỗi khi merge vào `main`. Hoàn toàn miễn phí trên GitLab Free.

## Có gì trong bộ này?

| File | Vai trò |
|------|---------|
| `mkdocs.yml` | Cấu hình site: theme Material, nav, search tiếng Việt, Mermaid |
| `docs/requirements.txt` | Pin version MkDocs + Material |
| `docs/index.md` | Trang chủ của website |
| `docs/build_site.sh` | Script build (dùng chung CI & local) |
| Job `pages` trong `.gitlab-ci.yml` | Build & publish qua GitLab Pages |

## Xem thử tại máy (local preview)

```bash
pip install -r docs/requirements.txt
bash docs/build_site.sh serve
# mở http://127.0.0.1:8000
```

Sửa file trong `docs/`, trang tự reload.

## Deploy tự động qua GitLab Pages

Không cần thao tác tay: mỗi khi có commit vào `main` chạm tới `docs/`, `mkdocs.yml` hoặc file `.md`, job `pages` sẽ:

1. Cài MkDocs.
2. Chạy `docs/build_site.sh build` → sinh thư mục `public/`.
3. GitLab publish `public/` thành website.

Lấy URL tại **Settings → Pages** (dạng `https://<group>.<pages-domain>/<project>/`).

## Cần bật gì một lần?

- **Settings → Pages**: đảm bảo Pages được bật cho project (mặc định bật ở Free nếu instance có cấu hình Pages domain — hỏi admin GitLab nội bộ nếu chưa thấy).
- Có **GitLab Runner** (Docker) — cùng runner đã dùng cho CI chấm bài.

## Nav & thêm trang mới

Muốn trang mới xuất hiện trên website: thêm file `.md` vào `docs/` **và** khai báo trong mục `nav:` của `mkdocs.yml`. Nếu không khai báo nav, MkDocs vẫn build file nhưng không hiện trong menu.

## Ghi chú thiết kế

- Các file governance ở gốc repo (`ROADMAP.md`, `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `DESIGN.md`) được `build_site.sh` **copy tạm** vào `docs/` lúc build (và `.gitignore` bỏ qua bản copy) — nhờ đó chúng vừa nằm ở gốc repo (đúng chuẩn GitLab tự nhận diện) vừa xuất hiện trên website.
- Build dùng chế độ thường (không `--strict`): vài link trỏ tới thư mục repo (`assignments/`, `submissions/`) nằm ngoài website nên chỉ là cảnh báo, không làm hỏng deploy. Những link đó vẫn hoạt động khi xem trực tiếp trên GitLab.
- Website chỉ để **đọc cho dễ**. Nguồn sự thật vẫn là repo; mọi thay đổi đi qua Merge Request.
