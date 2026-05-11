# ViFlow - Checklist công việc

## ✅ Đã hoàn thành
- [x] Import source OpenKey, setup repo GitHub
- [x] Cải thiện UI tab (raise panel, z-order, bỏ mask)
- [x] Xóa label "Điều khiển", căn chỉnh vị trí khung trên
- [x] Cập nhật version lên 1.0.1
- [x] Setup git tag cho từng version (v1.0.0, v1.0.1)
- [x] Tạo UPDATE_SYSTEM_NOTES.txt (tài liệu hệ thống cập nhật)

## 🔲 Việc tiếp theo — Rebranding OpenKey → ViFlow (macOS)

### Bước 1: Bundle ID & Product Name (Xcode project)
- [ ] Đổi `PRODUCT_BUNDLE_IDENTIFIER` từ `com.tuyenmai.openkey` → `com.quangdv09.viflow` trong `project.pbxproj` (2 chỗ: Debug + Release của target chính)
- [ ] Đổi tên target `OpenKey` → `ViFlow` trong `project.pbxproj`
- [ ] Đổi tên project `OpenKey` → `ViFlow` trong `project.pbxproj`

### Bước 2: Info.plist — Main App
- [ ] Đổi `CFBundleName` từ `OpenKey` → `ViFlow` trong `ModernKey/Info.plist`
- [ ] Kiểm tra và đổi các key khác có chứa `OpenKey` trong `ModernKey/Info.plist`

### Bước 3: Title cửa sổ & chuỗi UI
- [ ] Đổi chuỗi `@"OpenKey %@ - Bộ gõ Tiếng Việt"` → `@"ViFlow %@ - Bộ gõ Tiếng Việt"` trong `ViewController.m`
- [ ] Kiểm tra các chuỗi hiển thị khác trong `ViewController.m`, `AboutViewController.m`, `MacroViewController.mm`, `ConvertToolViewController.mm`

### Bước 4: Đổi tên class OpenKeyManager → ViFlowManager
- [ ] Đổi tên class `OpenKeyManager` → `ViFlowManager` trong `OpenKeyManager.h` và `OpenKeyManager.m`
- [ ] Cập nhật tất cả file import `#import "OpenKeyManager.h"` → `#import "ViFlowManager.h"` (các file: `ViewController.m`, `AboutViewController.m`, `MacroViewController.mm`, `ConvertToolViewController.mm`, `AppDelegate.m`, `OpenKey.mm`)
- [ ] Đổi tên file vật lý: `OpenKeyManager.h` → `ViFlowManager.h`, `OpenKeyManager.m` → `ViFlowManager.m`
- [ ] Cập nhật tham chiếu file trong `project.pbxproj` sau khi đổi tên

### Bước 5: Đổi tên file OpenKey.mm → ViFlow.mm
- [ ] Đổi tên file vật lý `ModernKey/OpenKey.mm` → `ModernKey/ViFlow.mm`
- [ ] Cập nhật tham chiếu file trong `project.pbxproj`

### Bước 6: Helper App — OpenKeyHelper → ViFlowHelper
- [ ] Đổi bundle ID của target `OpenKeyHelper` trong `project.pbxproj`
- [ ] Đổi tên target `OpenKeyHelper` → `ViFlowHelper` trong `project.pbxproj`
- [ ] Cập nhật `Info.plist` của OpenKeyHelper (CFBundleName, CFBundleIdentifier)
- [ ] Đổi tên class/references trong `OpenKeyHelper/AppDelegate.h` và `AppDelegate.m`
- [ ] Đổi tên file entitlements `OpenKeyHelper.entitlements` → `ViFlowHelper.entitlements`
- [ ] Đổi tên thư mục vật lý `OpenKeyHelper/` → `ViFlowHelper/` và cập nhật pbxproj

### Bước 7: Entitlements & Signing
- [ ] Kiểm tra `OpenKey.entitlements` — đổi tên thành `ViFlow.entitlements` nếu cần
- [ ] Kiểm tra `ModernKey.entitlements` — đổi tên thành `ViFlow.entitlements` nếu cần
- [ ] Cập nhật tham chiếu entitlements trong `project.pbxproj`

### Bước 8: URL & Social links trong UI
- [ ] Đổi URL GitHub `https://github.com/tuyenvm/OpenKey` → `https://github.com/quangdv09/viflow` trong `AboutViewController.m`
- [ ] Đổi URL releases `https://github.com/tuyenvm/OpenKey/releases` → `https://github.com/quangdv09/viflow/releases` trong `AboutViewController.m`
- [ ] Đổi URL Facebook `https://www.facebook.com/OpenKeyVN` (hoặc xóa) trong `AboutViewController.m` và `ViewController.m`

### Bước 9: Localizable strings
- [ ] Kiểm tra `vi-VN.lproj/Main.strings` — đổi các chuỗi chứa `OpenKey`
- [ ] Kiểm tra `Base.lproj/Main.storyboard` — đổi các label/title chứa `OpenKey`

### Bước 10: README & CHANGELOG
- [ ] Cập nhật `README.md` gốc — đổi tên thương hiệu
- [ ] Cập nhật `Sources/README.md` nếu có
- [ ] Cập nhật `CHANGELOG.md`

### Bước 11: Icon & Assets
- [ ] Thay thế icon app trong `ModernKey/Assets.xcassets/`
- [ ] Thay thế icon helper trong `OpenKeyHelper/Assets.xcassets/`

### Bước 12: Kiểm tra sau rebranding
- [ ] Build thử trên Xcode — đảm bảo không lỗi compile
- [ ] Chạy thử app — kiểm tra title, menu, about dialog
- [ ] Scan lại toàn bộ `Sources/` tìm chuỗi `OpenKey` còn sót (dùng grep)
- [ ] Chú ý KHÔNG đổi các API/symbol hệ thống như `NSOpenPanel`, `RegOpenKeyEx`, v.v.

## 📌 Ghi chú
- Build command: xem session memory hoặc CHANGELOG
- DerivedData: `~/Library/Developer/Xcode/DerivedData/OpenKey-hadsgrobhfvdqbgvcboeobrwxfsa/...`
- Remote: https://github.com/quangdv09/viflow.git (nhánh main)
- Quy trình release: commit → push → git tag vX.X.X → push tag
