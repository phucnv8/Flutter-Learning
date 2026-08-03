# Phân biệt class, abstract class, interface, mixin

| Tiêu chí            | Class   | Abstract Class  | Interface (implements) | Mixin     |
| ------------------- | ------- | --------------- | ---------------------- | --------- |
| Tạo object          | ✅      | ❌              | ❌                     | ❌        |
| Có constructor      | ✅      | ✅              | Tùy                    | ❌        |
| Implementation      | Toàn bộ | Một phần        | Không                  | Toàn bộ   |
| Dùng bằng           | extends | extends         | implements             | with      |
| Dùng được bao nhiêu | 1       | 1               | Nhiều                  | Nhiều     |
| Phải override       | Không   | Abstract method | Tất cả                 | Không cần |
