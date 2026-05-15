# [ViFlow](https://github.com/quangdv09/viflow)

### [Download bản mới nhất](https://github.com/quangdv09/viflow/releases)

[![GitHub release](https://img.shields.io/github/v/release/quangdv09/viflow.svg)](https://github.com/quangdv09/viflow/releases/latest)

### Open source Vietnamese Input App for macOS - Bộ gõ tiếng Việt nguồn mở cho macOS.

Bộ gõ tiếng Việt mới cho macOS, sử dụng kỹ thuật `Backspace`. Loại bỏ lỗi gạch chân khó chịu ở bộ gõ mặc định. Hoàn toàn miễn phí và là nguồn mở, luôn cập nhật và phát triển.

### Mã nguồn của ứng dụng được mở công khai, minh bạch dưới giấy phép GPL. Điều này nghĩa là bạn hoàn toàn có thể tải mã nguồn về tự build, cải tiến theo mục đích của bạn. Nếu bạn tái phân phối bản cải tiến của bạn, thì nó cũng phải là mã nguồn mở và ghi nhận nguồn gốc dự án.

### Lưu ý, khi sử dụng ViFlow, bạn nên tắt hẳn bộ gõ khác vì 2 chương trình bộ gõ sẽ xung đột nhau, dẫn đến thao tác không chính xác.

## Cài đặt:

**Cài đặt thủ công:**
Tải bản ViFlow mới nhất từ [đây](https://github.com/quangdv09/viflow/releases/latest), giải nén file `.zip` rồi kéo thả `ViFlow.app` vào thư mục `Applications`.

## Mở ứng dụng lần đầu (Gatekeeper của macOS):

Vì ViFlow không được ký bởi Apple Developer ID trả phí, macOS sẽ chặn khi mở lần đầu. Thực hiện một trong hai cách sau:

**Cách 1 (khuyến nghị):** Nhấp chuột phải vào `ViFlow.app` → chọn **Open** → bấm **Open** trong hộp thoại cảnh báo.

**Cách 2:** Nếu macOS vẫn chặn, vào **System Settings** → **Privacy & Security**, tìm thông báo về `ViFlow.app`, bấm **Open Anyway**, rồi xác nhận **Open** để mở ứng dụng.

## Lưu ý:

ViFlow cần cấp quyền, vào *System Settings -> Privacy & Security -> Accessibility*, kích hoạt `ViFlow.app`. **Không tắt nó khi đang dùng ViFlow**.

## Hỗ trợ kiểu gõ

- Telex
- VNI

## Bảng mã thông dụng:

- Unicode (Unicode dựng sẵn)

## Tính năng:

- **Modern orthography** (On/Off) - Đặt dấu oà, uý thay vì òa, úy.
- **Quick Telex** (On/Off) - Gõ nhanh (cc=ch, gg=gi, kk=kh, nn=ng, qq=qu, pp=ph, tt=th).
- **Grammar check** (On/Off) - Kiểm tra ngữ pháp.
- **Spelling check** (On/Off) - Kiểm tra chính tả.
- **Restore key if invalid word** (on/off) - Phục hồi phím với từ sai.
- **Run on startup** (On/Off) - Chạy cùng macOS.
- **Gray menu bar icon** (On/Off) - Biểu tượng xám trên thanh menu phù hợp với chế độ Dark mode.
- **Switch input mode by shortcut key** - Đổi chế độ gõ bằng phím tắt tùy chọn.
- **Autocorrect fixed** (On/Off) - Sửa lỗi autocorrect trên trình duyệt như Chrome, Safari, Firefox, Microsoft Excel.
- **Underline issue fixed on macOS** (On/Off) - Sửa lỗi gạch chân trên macOS.
- **Tạm tắt kiểm tra chính tả bằng phím Ctrl** (On/Off) (Bản 1.5 về sau).
- **Tạm tắt ViFlow bằng phím Cmd/Alt** (On/Off) (Bản 2.0.1 về sau).
- **Cho phép dùng f z w j làm phụ âm đầu** (On/Off) (Bản 1.5 về sau).
- **Gõ tắt phụ âm đầu: f->ph, j->gi, w->qu** (On/Off) (Bản 1.6 về sau).
- **Gõ tắt phụ âm cuối: g->ng, h->nh, k->ch** (On/Off) (Bản 1.6 về sau).
- **Hiện biểu tượng trên thanh Dock** (On/Off) (Bản 2.0.1 về sau). Bấm vào icon trên thanh Dock sẽ mở nhanh Bảng điều khiển.
- **Macro** - Tính năng gõ tắt vô cùng tiện lợi. Gõ tắt của macOS chỉ hỗ trợ 20 ký tự, còn ViFlow không giới hạn ký tự.
- **Chuyển chế độ thông minh:** (On/Off) (Bản 1.2 về sau) - Bạn đang dùng chế độ gõ Tiếng Việt trên ứng dụng A, bạn chuyển qua ứng dụng B trước đó bạn dùng chế độ gõ Tiếng Anh, ViFlow sẽ tự động chuyển qua chế độ gõ Tiếng Anh cho bạn, khi bạn quay lại ứng dụng A, ViFlow tất nhiên sẽ chuyển lại chế độ gõ tiếng Việt, rất cơ động.
- **Viết Hoa chữ cái đầu câu** (On/Off) (Bản 1.2 về sau) - Khi gõ văn bản dài, đôi khi bạn quên ghi hoa chữ cái đầu câu khi kết thúc một câu hoặc khi xuống hàng, tính năng này sẽ tự ghi hoa chữ cái đầu câu cho bạn, thật tuyệt vời.
- **Chế độ “Gửi từng phím”:** (On/Off) (Bản 1.1 về sau) mặc định dùng kỹ thuật mới gửi dữ liệu 1 lần thay vì gửi nhiều lần cho chuỗi ký tự, nên nếu có ứng dụng nào không tương thích, hãy bật tính năng này lên, mặc định thì nên tắt vì kỹ thuật mới sẽ chạy nhanh hơn.
- **Cập nhật tự động:** (Bản 1.3 về sau) tính năng hỗ trợ cập nhật phiên bản ViFlow mới nhất mỗi khi mở ViFlow hoặc tự check trong phần mục Giới thiệu.
- **Công cụ chuyển mã:** (Bản 1.4 về sau) hỗ trợ chuyển mã qua lại văn bản, thích hợp cho việc chuyển đổi văn bản cũ viết bằng VNI, TCVN3 qua Unicode,... Hỗ trợ cấu hình phím tắt chuyển mã nhanh, bảng cấu hình tùy chọn chuyển mã.
- **Tự ghi nhớ bảng mã theo ứng dụng:** (Bản 2.0.1 về sau) Phù hợp cho các bạn dùng Photoshop, CAD,... với các bảng mã VNI, TCVN3. ViFlow tự ghi nhớ ứng dụng nào dùng bảng mã nào để lần sau sử dụng Photoshop, CAD,... ViFlow có thể tự chuyển sang bảng mã đó.

## Tác giả

- ViFlow được phát triển từ mã nguồn gốc của tác giả Mai Vũ Tuyên.
- Phát triển và duy trì bởi: Đỗ Vinh Quang
- GitHub: [https://github.com/quangdv09/viflow](https://github.com/quangdv09/viflow)

Cảm ơn các bạn đã sử dụng ViFlow.
