# Kế hoạch tách GPL và chuẩn bị thương mại hóa

Ngày tạo: 2026-05-11

## Mục tiêu

Tạo một phiên bản mới hoàn toàn để có thể phát hành dưới giấy phép mới trong tương lai, bao gồm khả năng thương mại hóa và có thể đóng mã nguồn nếu cần.

## Kết luận hiện tại

Repo hiện tại không thể được coi là sản phẩm mới hoàn toàn chỉ bằng cách:

- xóa file LICENSE
- đổi tên ViFlow hoặc ViFlow
- sửa header copyright

Lý do:

- Codebase hiện tại là tác phẩm dẫn xuất từ ViFlow, không phải codebase độc lập.
- Nhiều file core engine vẫn mang dấu vết tác giả gốc Tuyen Mai và tên ViFlow.
- README hiện tại tự nhận là fork từ ViFlow và phát hành dưới GPL.
- Có ít nhất một phần mã MIT từ Hammerspoon; phần này có thể tiếp tục sử dụng nếu giữ attribution đúng cách.

## Mục tiêu pháp lý thực tế

Để có đường thương mại hóa sạch, phương án an toàn nhất là:

1. Đóng băng repo hiện tại thành bản tham chiếu GPL.
2. Tạo một codebase mới, tách biệt, viết lại các thành phần có nguồn gốc ViFlow.
3. Chỉ tái sử dụng các thành phần mà bạn có quyền rõ ràng để dùng lại, ví dụ mã MIT kèm attribution.

## Phương án đề xuất

### Phương án A - Xin phép tái cấp phép từ chủ sở hữu ViFlow

Ưu điểm:

- Nhanh nhất nếu có được văn bản đồng ý.
- Có thể giữ lại nhiều mã hiện có.

Nhược điểm:

- Phụ thuộc hoàn toàn vào chủ sở hữu bản quyền gốc.
- Nếu không có văn bản rõ ràng, rủi ro pháp lý vẫn tồn tại.

Kết luận:

- Có thể thử, nhưng không nên xem đây là kế hoạch chính.

### Phương án B - Clean rewrite

Ưu điểm:

- Là con đường sạch nhất để thương mại hóa sau này.
- Bạn chủ động hoàn toàn về license, bản quyền và chiến lược sản phẩm.

Nhược điểm:

- Tốn thời gian.
- Cần kỷ luật để không copy ngược code cũ.

Kết luận:

- Đây là phương án nên làm.

## Quyết định thực hiện

Phương án được chọn: `Phương án B - Clean rewrite`.

Mục tiêu của phương án này không phải là "làm sạch repo hiện tại", mà là:

1. Dùng repo hiện tại như tài liệu tham chiếu hành vi.
2. Tạo một codebase mới hoàn toàn, có lịch sử phát triển độc lập.
3. Thiết kế lại kiến trúc để thuận lợi cho thương mại hóa, bảo trì và mở rộng sau này.
4. Giảm tối đa rủi ro pháp lý khi phát hành bản thương mại trong tương lai.

## Kết quả đầu ra mong muốn

Khi hoàn thành phương án B, bạn cần có các đầu ra sau:

1. Một repo mới private, không chứa mã kế thừa từ ViFlow.
2. Một core engine mới do bạn tự viết, có test tự động.
3. Một app macOS mới dùng engine mới, không reuse class và cấu trúc cũ.
4. Bộ tài liệu nội bộ đủ rõ để chứng minh hướng clean rewrite.
5. Nền tảng sẵn sàng để chọn mô hình kinh doanh sau này:
   - bán license
   - freemium
   - bản miễn phí và bản Pro
   - phân phối thương mại qua website riêng hoặc kênh khác

## Phạm vi dự án mới

### Phạm vi bắt buộc cho bản đầu tiên

Đây là các hạng mục nên có trong bản thương mại đầu tiên:

1. Bật hoặc tắt bộ gõ.
2. Chọn kiểu gõ cơ bản: Telex, VNI.
3. Xử lý dấu tiếng Việt ổn định cho các trường hợp phổ biến.
4. Quản lý cấu hình người dùng.
5. Giao diện thiết lập cơ bản trên macOS.
6. Hook nhập liệu hoạt động ổn định trên các ứng dụng chính.
7. Cơ chế logging nội bộ để debug.
8. Bộ test cho engine.

### Phạm vi nên hoãn lại

Những phần này có thể để sau bản đầu tiên nhằm giảm rủi ro và thời gian rewrite:

1. Macro nâng cao.
2. Chuyển mã với nhiều bảng mã cũ.
3. Smart switch phức tạp theo từng ứng dụng.
4. Đồng bộ cài đặt.
5. Update tự động.
6. Các tối ưu UI không ảnh hưởng trực tiếp đến giá trị cốt lõi.

## Nguyên tắc clean rewrite chi tiết

Đây là các nguyên tắc bắt buộc để tránh contamination:

1. Không copy bất kỳ đoạn code nào từ repo hiện tại sang repo mới.
2. Không mở song song file nguồn cũ khi đang implement file tương ứng ở repo mới.
3. Chỉ được mang sang repo mới các mô tả hành vi, test case, yêu cầu sản phẩm và ghi chú kiến trúc do bạn tự viết lại.
4. Không giữ nguyên tên class, tên module, tên file, cấu trúc namespace hoặc cấu trúc thư mục mang tính đặc thù của code cũ nếu không thật sự cần.
5. Nếu có dùng lại mã MIT, phải tách riêng danh sách file, nguồn gốc và điều kiện attribution.
6. Mọi feature khi bắt đầu đều phải đi qua bước: mô tả hành vi -> viết test -> implement mới.

## Cấu trúc repo mới đề xuất

Repo mới nên tách rõ để dễ bảo trì và dễ chứng minh tính độc lập:

1. `docs/`
2. `src/core/`
3. `src/platform/macos/`
4. `src/app/`
5. `tests/core/`
6. `tests/integration/`
7. `tools/`

Ý nghĩa từng phần:

- `docs/`: đặc tả sản phẩm, kiến trúc, chính sách nguồn gốc mã.
- `src/core/`: engine xử lý text tiếng Việt, không phụ thuộc UI.
- `src/platform/macos/`: lớp tương tác với macOS event, accessibility, permissions.
- `src/app/`: app settings, state, menu bar, persistence, UI.
- `tests/core/`: test cho quy tắc gõ và biến đổi text.
- `tests/integration/`: test tích hợp cho luồng nhập liệu và cấu hình.
- `tools/`: script build, kiểm tra, packaging.

## Kiến trúc kỹ thuật đề xuất

### Lớp 1 - Core Engine

Chịu trách nhiệm:

- nhận chuỗi phím đầu vào
- quản lý trạng thái từ đang gõ
- áp dụng quy tắc dấu
- trả về kết quả biến đổi

Yêu cầu:

- thuần logic, không phụ thuộc AppKit
- dễ test
- có API nhỏ, rõ ràng

### Lớp 2 - Platform Adapter macOS

Chịu trách nhiệm:

- lắng nghe sự kiện bàn phím
- xác định ngữ cảnh nhập liệu
- gửi input sang core engine
- áp dụng kết quả ra ứng dụng đích
- xử lý quyền Accessibility và các giới hạn hệ điều hành

Yêu cầu:

- không nhồi logic tiếng Việt vào lớp này
- chỉ làm nhiệm vụ cầu nối nền tảng

### Lớp 3 - App Layer

Chịu trách nhiệm:

- quản lý settings
- menu bar
- cửa sổ thiết lập
- persistence
- logging, diagnostics

Yêu cầu:

- không nhúng logic xử lý text vào UI code

## Lộ trình triển khai chi tiết

### Giai đoạn 0 - Chuẩn bị và đóng băng

Mục tiêu:

- xác lập ranh giới giữa code cũ và code mới
- tránh contamination ngay từ đầu

Việc cần làm:

1. Đánh dấu repo hiện tại là bản tham chiếu GPL.
2. Dừng mọi ý định chỉnh trực tiếp repo này để phục vụ bản thương mại.
3. Tạo repo mới private.
4. Tạo các tài liệu gốc trong repo mới:
   - `ORIGIN_POLICY.md`
   - `PRODUCT_SPEC.md`
   - `ARCHITECTURE.md`
   - `TEST_PLAN.md`
5. Ghi rõ trong `ORIGIN_POLICY.md` quy tắc không sao chép mã.

Điều kiện hoàn thành giai đoạn 0:

- repo mới đã tồn tại
- tài liệu khung đã có
- quy tắc clean rewrite đã được viết ra

### Giai đoạn 1 - Đặc tả sản phẩm

Mục tiêu:

- chuyển tri thức từ repo cũ sang dạng tài liệu hành vi

Việc cần làm:

1. Liệt kê tất cả tính năng hiện có.
2. Chia thành 3 mức: bắt buộc, nên có, để sau.
3. Viết user flow cho các hành vi chính.
4. Viết acceptance criteria cho từng tính năng P0.
5. Chốt phạm vi bản đầu tiên.

Deliverable:

- `PRODUCT_SPEC.md`
- `FEATURE_MATRIX.md`

Điều kiện hoàn thành:

- có danh sách feature rõ ràng
- có phạm vi MVP rõ ràng

### Giai đoạn 2 - Thiết kế engine mới

Mục tiêu:

- tạo thiết kế logic cho bộ xử lý tiếng Việt độc lập với nền tảng

Việc cần làm:

1. Xác định input model và output model.
2. Thiết kế state machine hoặc processing pipeline.
3. Xác định rule set tối thiểu cho Telex và VNI.
4. Thiết kế API cho core engine.
5. Viết test case trước cho các quy tắc quan trọng.

Deliverable:

- tài liệu thiết kế engine trong `ARCHITECTURE.md`
- bộ test core ban đầu

Điều kiện hoàn thành:

- có thể implement engine chỉ dựa vào tài liệu và test

### Giai đoạn 3 - Implement core engine

Mục tiêu:

- có engine mới chạy được cho các trường hợp cơ bản

Việc cần làm:

1. Implement pipeline xử lý input.
2. Implement trạng thái từ hiện tại.
3. Implement quy tắc Telex.
4. Implement quy tắc VNI.
5. Sửa cho qua test.
6. Bổ sung test hồi quy khi phát hiện lỗi.

Deliverable:

- `src/core/`
- `tests/core/`

Điều kiện hoàn thành:

- engine chạy được độc lập
- test core đủ tin cậy cho phạm vi P0

### Giai đoạn 4 - Tích hợp macOS

Mục tiêu:

- nối engine mới với hệ thống nhập liệu trên macOS

Việc cần làm:

1. Tạo lớp bắt phím.
2. Chuẩn hóa dữ liệu đầu vào gửi vào core.
3. Áp dụng output từ core ra ứng dụng đích.
4. Xử lý các trường hợp cơ bản với app phổ biến.
5. Thêm logging để debug các case lỗi thực tế.

Deliverable:

- `src/platform/macos/`
- `tests/integration/` ban đầu

Điều kiện hoàn thành:

- app chạy được trên macOS cho luồng gõ cơ bản

### Giai đoạn 5 - App settings và độ ổn định

Mục tiêu:

- đủ mức dùng thực tế cho người dùng đầu tiên

Việc cần làm:

1. Tạo giao diện bật hoặc tắt bộ gõ.
2. Tạo giao diện chọn kiểu gõ.
3. Lưu và đọc cấu hình.
4. Tạo trang chẩn đoán cơ bản.
5. Test tay trên các ứng dụng chính.

Deliverable:

- `src/app/`
- checklist test tay

Điều kiện hoàn thành:

- có thể phát hành alpha nội bộ

### Giai đoạn 6 - Chuẩn bị thương mại hóa

Mục tiêu:

- chuẩn bị hạ tầng và pháp lý cho bản phát hành tương lai

Việc cần làm:

1. Chốt license hoặc chính sách proprietary cho repo mới.
2. Tách các thành phần miễn phí và trả phí nếu cần.
3. Chuẩn bị tên thương mại, bundle id, website, branding mới.
4. Viết điều khoản sử dụng và chính sách riêng tư nếu có telemetry.
5. Chuẩn bị quy trình build, ký app, và phân phối.

Deliverable:

- tài liệu phát hành
- danh sách việc pháp lý và vận hành

Điều kiện hoàn thành:

- sẵn sàng cho private beta hoặc phát hành thương mại thử nghiệm

## Kế hoạch theo tuần đề xuất

### Tuần 1

1. Tạo repo mới.
2. Viết `ORIGIN_POLICY.md`.
3. Viết `PRODUCT_SPEC.md`.
4. Chốt phạm vi MVP.

### Tuần 2

1. Viết `ARCHITECTURE.md`.
2. Thiết kế API core.
3. Viết test case cho Telex và VNI.

### Tuần 3

1. Implement core engine bản đầu.
2. Cho toàn bộ test core chạy ổn định.
3. Tạo regression suite đầu tiên.

### Tuần 4

1. Nối engine với macOS input hook.
2. Tạo logging và diagnostics cơ bản.
3. Test tay trên app thường dùng.

### Tuần 5

1. Hoàn thiện settings UI tối thiểu.
2. Lưu cấu hình.
3. Đóng gói alpha nội bộ.

### Tuần 6

1. Rà lỗi thực tế.
2. Quyết định phạm vi beta.
3. Chuẩn bị thương hiệu và mô hình phát hành.

## Danh sách tài liệu cần viết trong repo mới

### Tài liệu bắt buộc ngay từ đầu

- `ORIGIN_POLICY.md`
- `PRODUCT_SPEC.md`
- `ARCHITECTURE.md`
- `TEST_PLAN.md`

### Tài liệu nên có trước khi alpha

- `FEATURE_MATRIX.md`
- `RISK_REGISTER.md`
- `RELEASE_PLAN.md`
- `DIAGNOSTICS_GUIDE.md`

## Rủi ro chính và cách giảm thiểu

### Rủi ro 1 - Contamination từ code cũ

Cách giảm thiểu:

1. Không copy code.
2. Chỉ làm việc qua spec.
3. Ghi lại nguồn gốc của mọi file được tái sử dụng.

### Rủi ro 2 - Rewrite quá rộng, không ra được bản đầu tiên

Cách giảm thiểu:

1. Chỉ chốt MVP nhỏ.
2. Hoãn macro, convert tool, smart switch nâng cao.
3. Chốt tiêu chí ra bản alpha sớm.

### Rủi ro 3 - Kiến trúc mới vẫn lặp lại cấu trúc cũ

Cách giảm thiểu:

1. Đặt tên lại module.
2. Thiết kế API từ đầu dựa trên use case mới.
3. Viết tài liệu kiến trúc trước khi code.

### Rủi ro 4 - Khó debug trên macOS

Cách giảm thiểu:

1. Thêm logging từ đầu.
2. Có trang diagnostics nội bộ.
3. Tách bug nền tảng khỏi bug engine.

## Checklist ngày đầu tiên

Đây là checklist cụ thể để bắt đầu ngay ngày mai:

1. Tạo repo mới private.
2. Tạo thư mục `docs/`, `src/`, `tests/`, `tools/`.
3. Tạo 4 file đầu tiên:
   - `docs/ORIGIN_POLICY.md`
   - `docs/PRODUCT_SPEC.md`
   - `docs/ARCHITECTURE.md`
   - `docs/TEST_PLAN.md`
4. Viết 10 đến 15 tính năng hiện có dưới dạng hành vi người dùng.
5. Đánh dấu tính năng P0 cho bản đầu tiên.
6. Viết 20 test case cho quy tắc gõ cơ bản.
7. Chốt tên sản phẩm mới nếu muốn tách thương hiệu khỏi ViFlow.

## Tiêu chí ra quyết định trong quá trình làm

Nếu gặp một tính năng đang phân vân có nên đưa vào bản đầu tiên hay không, dùng 3 câu hỏi này:

1. Tính năng này có bắt buộc để người dùng gõ được tiếng Việt ổn định không?
2. Tính năng này có làm chậm bản alpha quá nhiều không?
3. Tính năng này có thể để sau mà không ảnh hưởng giá trị lõi không?

Nếu câu trả lời là "không bắt buộc" và "có thể để sau", hãy hoãn.

## Định nghĩa hoàn thành của phương án B

Phương án B được coi là đi đúng và đủ khi:

1. Repo mới có lịch sử phát triển độc lập.
2. Core engine được viết mới và có test.
3. App macOS mới dùng engine mới.
4. Không có mã copy từ repo hiện tại.
5. Có đủ tài liệu để hỗ trợ phát hành thương mại sau này.

## Việc tôi có thể làm tiếp

Nếu tiếp tục vào ngày mai, có thể làm ngay 1 trong 3 việc sau:

1. Tạo bộ khung repo mới cho bạn.
2. Trích xuất danh sách tính năng từ repo cũ thành `PRODUCT_SPEC.md` để làm tài liệu clean rewrite.
3. Lập bảng inventory file nào buộc phải viết lại, file nào có thể tham khảo, và file nào có thể giữ lại theo MIT.

## Ghi chú

Tài liệu này là định hướng kỹ thuật và quản trị rủi ro, không phải tư vấn pháp lý chính thức. Nếu bạn sắp thương mại hóa nghiêm túc, nên có một luật sư sở hữu trí tuệ xem qua trước khi phát hành.