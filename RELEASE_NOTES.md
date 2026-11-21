# Mark of the Deep — Bản Dịch Tiếng Việt v1.0.0

Bản dịch tiếng Việt hoàn chỉnh cho trò chơi hành động phiêu lưu Metroidvania / Soulslike **Mark of the Deep** (Nhà phát triển Mad Mimic / Unreal Engine 5).

---

## Thông tin bản phát hành v1.0.0

- **Phiên bản trò chơi hỗ trợ:** v2.3.6 (Steam và Epic Games Store).
- **Quy mô dữ liệu:** Hoàn thành 100% với 2.946 / 2.946 chuỗi văn bản gồm Cốt truyện chính, Lời thoại nhân vật, Nhật ký thám hiểm, Hệ thống kỹ năng, Bùa hộ mệnh và Toàn bộ giao diện cài đặt.
- **Định hướng bản địa hóa:** Văn phong dark fantasy kết hợp huyền thoại hải tặc và thần thoại biển sâu, chuẩn hóa hệ thống thuật ngữ thế giới game (Ấn Ký Biển Sâu, Cổ Tộc, Kẻ Giữ Ấn, Kẻ Toàn Tri, Giáo Phái Biển Sâu, Hũ Linh Hồn, Nghi Thức Máu...).
- **Xử lý font chữ:** Tích hợp bộ font Serif hoàn chỉnh có đầy đủ bảng mã tiếng Việt trực tiếp vào gói tài nguyên font asset `.ufont` của Unreal Engine 5, chuẩn hóa Unicode NFC, khắc phục triệt để lỗi thiếu dấu và ký tự lỗi `<?>`.
- **Cơ chế nạp mod an toàn:** Sử dụng cơ chế patch native `pakchunk0-VietHoa_P.pak` nạp qua thư mục `~mods`, hoàn toàn không can thiệp hay làm hỏng tệp gốc 1.9 GB của trò chơi.
- **Kịch bản cài đặt tự động:** Đi kèm tệp `.bat` tự động nhận diện thư mục game và hoàn tất thiết lập hoặc gỡ bỏ nhanh chóng.

---

## Lưu ý nhỏ

- **Miễn phí 100%:** Bản Việt hóa được thực hiện và chia sẻ miễn phí bởi **[Diiexe](https://github.com/diiexe)**. Nếu bạn phải bỏ tiền mua bản dịch này ở bất kỳ đâu thì bạn đã bị lừa đảo.
- **Bản dịch bằng AI** mình làm để tự chơi cá nhân, tiện chia sẻ lại cho ai cần. Dùng được thì dùng, không dùng thì thôi nhé.
- **Miễn trừ trách nhiệm:** Bản mod chỉ nạp ngôn ngữ và phông chữ qua thư mục `~mods`, không sửa file gốc và mở toàn bộ mã nguồn trên repo. Vì là bản chia sẻ cá nhân phi thương mại nên mình cung cấp theo nguyên trạng, không bảo hành và không chịu trách nhiệm nếu có lỗi phát sinh trong quá trình sử dụng.

---

## Hướng dẫn cài đặt & Gỡ bỏ

### Cách 1: Cài đặt tự động
1. Tải tệp tin `MarkOfTheDeep_VietHoa_v1.0.0.zip` đính kèm bên dưới và giải nén.
2. Chạy tệp tin `CaiDat_VietHoa.bat`.
3. Nhập phím 1 và nhấn Enter.
4. Khởi động trò chơi để áp dụng tiếng Việt.

### Cách 2: Cài đặt thủ công
1. Tải tệp tin `pakchunk0-VietHoa_P.pak` bên dưới.
2. Sao chép tệp tin vào thư mục:
   ```text
   <Thư_Mục_Cài_Game>\MarkOfTheDeep\Content\Paks\~mods\
   ```
   *(Nếu thư mục `~mods` chưa tồn tại trong `Paks`, hãy tạo một thư mục mới có tên `~mods`).*

---

## Chú thích tương thích phiên bản

- Phiên bản thử nghiệm cũ hơn v2.3.6 (như Demo hoặc Pre-Alpha) có cấu trúc bảng chuỗi và metadata khác biệt, cài đặt patch có thể gây lỗi hiển thị hoặc lỗi nạp tài nguyên.
- Các phiên bản cập nhật trong tương lai vẫn sẽ nạp được bản dịch cho toàn bộ 2.946 chuỗi hiện tại; các chuỗi mới (nếu có) sẽ hiển thị tiếng Anh mặc định.

---

## Mã kiểm tra tính toàn vẹn (SHA-256)

| Tên tệp tin | Mã băm SHA-256 |
| :--- | :--- |
| `MarkOfTheDeep_VietHoa_v1.0.0.zip` | `4b352c5d3e068ffe974aadc12d1d090ed8ed2f9842dc9db1d7cc6220c7aeac4a` |
| `pakchunk0-VietHoa_P.pak` | `72d4c83b1ec649c8a9c844399889c4e4e2f75c781b1a4d3eaad55d3bcf1691a0` |
| `CaiDat_VietHoa.bat` | `b2c29a980d37d848e69952c424e156810089bdb1c836957206ce261d05526abe` |

---

## Tác giả & Bản quyền

- **Bản dịch Tiếng Việt & Bộ công cụ mã nguồn:** Thực hiện bởi **[Diiexe](https://github.com/diiexe)** (chia sẻ phi thương mại).
- **Bản quyền trò chơi gốc:** Toàn bộ hình ảnh, âm thanh, mã nguồn và tài sản trò chơi gốc thuộc quyền sở hữu của **Mad Mimic**.
