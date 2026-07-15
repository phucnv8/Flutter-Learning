# Submissions — Nơi nộp bài

Mỗi thành viên có **một thư mục riêng** theo username GitLab:

```
submissions/
├── README.md              ← file này
├── _TEMPLATE/             ← copy để bắt đầu
│   └── PROGRESS.md
├── hungnv/
│   ├── PROGRESS.md
│   ├── module-01/
│   └── module-02/
└── <your-username>/
    └── ...
```

## Quy tắc

1. **Chỉ sửa thư mục của chính bạn.** CI (`ci/validate_submission.sh`) sẽ chặn MR nếu bạn chạm vào thư mục người khác.
2. Mỗi module một thư mục con: `module-NN/`.
3. Có `PROGRESS.md` ở gốc thư mục của bạn — tự cập nhật tiến độ.
4. Một MR = một bài nộp của một module (nhỏ, dễ review).

## Bắt đầu

```bash
cp -r submissions/_TEMPLATE submissions/<your-username>
# sửa PROGRESS.md, rồi làm bài trong submissions/<your-username>/module-01/
```
