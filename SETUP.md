# JP Sensei AI - Xcode Setup Guide

## Prerequisites

- Xcode 15+ (để hỗ trợ iOS 17)
- Apple ID (miễn phí, không cần Developer Program cho personal use)
- Google AI Studio API Key (miễn phí): https://aistudio.google.com/apikey

---

## Step 1: Tạo Xcode Project

1. Mở Xcode → File → New → Project
2. Chọn **App** (iOS)
3. Điền thông tin:
   - Product Name: `JPSenseiAI`
   - Team: Personal Team (Apple ID của bạn)
   - Organization Identifier: `com.jpsensei`
   - Interface: **SwiftUI**
   - Language: **Swift**
   - Storage: None
   - Bỏ tick Include Tests
4. Chọn thư mục lưu project

---

## Step 2: Tạo Share Extension Target

1. File → New → Target
2. Chọn **Share Extension** (iOS)
3. Điền:
   - Product Name: `ShareExtension`
   - Embed in Application: JPSenseiAI
4. Khi được hỏi "Activate scheme?" → chọn **Activate**

---

## Step 3: Cấu hình App Group

App Group cho phép Host App và Share Extension chia sẻ dữ liệu.

1. Chọn project (cây bên trái) → Target **JPSenseiAI**
2. Tab **Signing & Capabilities** → + Capability → **App Groups**
3. Thêm group: `group.com.jpsensei.shared`
4. Làm tương tự cho Target **ShareExtension**
   - Signing & Capabilities → + Capability → App Groups
   - Thêm cùng group: `group.com.jpsensei.shared`

---

## Step 4: Cấu hình Keychain Sharing

1. Target **JPSenseiAI** → Signing & Capabilities → + Capability → **Keychain Sharing**
2. Thêm group: `com.jpsensei.shared`
3. Làm tương tự cho Target **ShareExtension**

---

## Step 5: Thêm Source Files

### Host App (Target: JPSenseiAI)

Xóa file ContentView.swift mặc định, sau đó thêm các files từ folder `JPSenseiAI/`:

1. Right-click target JPSenseiAI → Add Files to "JPSenseiAI"
2. Thêm tất cả files trong `JPSenseiAI/App/` và `JPSenseiAI/Views/`

### Shared (Cả 2 targets)

1. Tạo group "Shared" trong project
2. Thêm tất cả files trong `JPSenseiAI/Shared/`
3. **Quan trọng**: Với mỗi file trong Shared, trong File Inspector (bên phải), tick cả 2 targets:
   - ☑ JPSenseiAI
   - ☑ ShareExtension

### Share Extension (Target: ShareExtension)

1. Xóa file ShareViewController.swift mặc định (nếu có)
2. Xóa file MainInterface.storyboard (nếu có)
3. Thêm tất cả files trong `JPSenseiAI/ShareExtension/`
4. Đảm bảo chỉ tick target ShareExtension

---

## Step 6: Cấu hình Share Extension Info.plist

Thay nội dung `Info.plist` của ShareExtension bằng nội dung trong file `JPSenseiAI/ShareExtension/Info.plist` của project này.

Hoặc trong Xcode, chỉnh NSExtension:
- NSExtensionAttributes:
  - NSExtensionActivationRule: `TRUEPREDICATE` (dev) hoặc rule cụ thể
- NSExtensionPointIdentifier: `com.apple.share-services`
- NSExtensionPrincipalClass: `$(PRODUCT_MODULE_NAME).ShareViewController`

---

## Step 7: Lấy API Key (Miễn phí)

1. Truy cập https://aistudio.google.com/apikey
2. Đăng nhập Google
3. Click "Create API Key"
4. Copy key
5. Mở app JP Sensei AI → Settings → dán API Key

---

## Step 8: Build & Run

1. Chọn scheme **ShareExtension**
2. Khi được hỏi "Choose an app to run" → chọn **Safari**
3. Run (⌘R)
4. Trong Safari, highlight text tiếng Nhật → Share → JP Sensei AI

---

## Troubleshooting

### Share Extension không hiển thị trong Share Sheet
- Đảm bảo đã run extension scheme ít nhất 1 lần
- Kiểm tra Edit Actions trong Share Sheet → bật JP Sensei AI

### "No such module" error
- Đảm bảo Shared files được thêm vào đúng target

### API Key không hoạt động
- Đảm bảo App Group đã được cấu hình đúng cho cả 2 targets
- Đảm bảo Keychain Sharing group giống nhau

---

## Free Tier Limits (Google Gemini)

- Model: gemini-2.0-flash
- 15 requests/phút
- 1,500 requests/ngày
- 1,000,000 tokens/phút

Quá đủ cho personal use!
