# Nhật Ký Thay Đổi (Changelog)

Toàn bộ các cập nhật của dự án bản địa hóa **Mark of the Deep** được ghi nhận tại đây.

---

## [v1.0.0] - 2026-11-21

### Phiên bản phát hành đầu tiên

#### Dữ liệu dịch thuật
- Hoàn thành dịch thuật 100% (2.946 / 2.946 chuỗi văn bản) cho phiên bản trò chơi chính thức **v2.3.6**.
- Đồng bộ hóa toàn bộ thuật ngữ chuyên biệt trong thế giới trò chơi (Ấn Ký Biển Sâu, Cổ Tộc, Giáo Phái Biển Sâu, Kẻ Toàn Tri, Hũ Linh Hồn, Nghi Thức Máu, Kẻ Giữ Ấn...).
- Bản địa hóa thể thơ và cấu trúc vần điệu cho các bài ca hải tặc (Sea Shanty).
- Xử lý văn phong đối thoại phù hợp với từng tuyến nhân vật (Marcus Ramsey, Ortega, Blackeye, Guru, Leviathan...).

#### Kỹ thuật và Tương thích
- Tích hợp bộ font Serif hoàn chỉnh có đầy đủ bảng mã tiếng Việt trực tiếp vào tài nguyên font asset `.ufont` của Unreal Engine 5, loại bỏ triệt để lỗi ký tự `<?>`.
- Chuẩn hóa toàn bộ dữ liệu văn bản theo chuẩn Unicode NFC.
- Giữ nguyên vẹn 100% các biến định dạng hệ thống `{0}`, `{CurrentGold}`, `{VersionNumber}`, các thẻ màu sắc `<Light>`, `<Emphasis>` và ký tự ngắt dòng `\n`.
- Đóng gói theo cơ chế patch native `pakchunk0-VietHoa_P.pak` cho thư mục `~mods`, hoàn toàn không ảnh hưởng đến tệp gốc 1.9 GB của trò chơi.
- Bổ sung kịch bản `CaiDat_VietHoa.bat` tự động phát hiện đường dẫn cài đặt game và thiết lập gói patch.
