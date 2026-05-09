# Checklist Công Việc

## Nội dung đã làm

- [x] Tạm tắt tính năng kiểm tra cập nhật trên macOS bằng cờ trung tâm trong OpenKeyManager.
- [x] Chặn luồng kiểm tra cập nhật tự động khi khởi động bằng cách thoát sớm trong hàm kiểm tra version.
- [x] Vô hiệu hóa nút/checkbox cập nhật trong màn hình Cài đặt (ViewController) khi tính năng đang tạm tắt.
- [x] Vô hiệu hóa nút/checkbox cập nhật trong màn hình Thông tin (AboutViewController) khi tính năng đang tạm tắt.
- [x] Hiển thị thông báo "Tính năng cập nhật tạm thời tắt" khi người dùng bấm kiểm tra thủ công.
- [x] Build xác nhận: BUILD SUCCEEDED.

## Nội dung cần làm tiếp theo

- [ ] Bật lại tính năng cập nhật khi sẵn sàng release:
  - [ ] Đổi cờ `kUpdateCheckTemporarilyDisabled` về `NO`.
  - [ ] Mở lại các control cập nhật trên ViewController/AboutViewController (hiện tại đang disable theo cờ).
- [ ] Đổi endpoint cập nhật sang repo mới (nếu không còn dùng tuyenvm/OpenKey):
  - [ ] URL version.json.
  - [ ] URL releases/homepage/fanpage trong UI.
- [ ] Hoàn tất rebranding tab Thông tin (tên dự án, mô tả, liên kết).
- [ ] Rà soát và cập nhật README/hướng dẫn phát hành theo version 1.0.0.
- [ ] Tạo commit tổng hợp cho đợt thay đổi này.

## Ghi chú

- Phạm vi tạm tắt hiện tại là bản macOS (nhánh code ModernKey).
- Metadata version đã đồng bộ 1.0.0 ở các bước trước đó; file này chỉ dùng để theo dõi công việc thao tác.
