# Twinfix Project Guide

Tài liệu này cung cấp cái nhìn tổng quan về cấu trúc project, các quy tắc và tiện ích có sẵn để giúp phát triển nhanh chóng và đồng bộ.

---

## 1. Cấu trúc Project (Project Structure)

Project tuân thủ kiến trúc **Clean Architecture** chia thành các lớp chính:

- `lib/core`: Chứa các cấu hình, hằng số, DI, enums, extensions, và các dịch vụ dùng chung.
- `lib/data`: Triển khai các Repository, DataSource, Model (DTO) và thực thể cơ sở dữ liệu (Isar).
- `lib/domain`: Chứa các Business Logic cốt lõi: Entity, Repository Interface, và UseCase.
- `lib/presentation`: Lớp giao diện người dùng, bao gồm:
    - `app`: Cấu hình ứng dụng chính.
    - `features`: Chia theo từng tính năng (màn hình).
    - `theme`: Định nghĩa style, màu sắc, font chữ.
    - `widgets`: Các component dùng chung cho toàn bộ app.

---

## 2. Cấu trúc Folder của một Màn hình (Feature Structure)

Mỗi tính năng trong `lib/presentation/features` nên tuân thủ cấu trúc sau:

```text
feature_name/
├── cubit/          # Quản lý State (Bloc/Cubit)
├── navigator/      # Xử lý điều hướng (Navigator, State, Cubit)
├── page/           # File chứa Widget chính của màn hình
└── widgets/        # Các widget con chỉ dùng riêng cho tính năng này
```

---

## 3. Quy tắc Project (Project Rules)

- **State Management**: Sử dụng `flutter_bloc` (Cubit được ưu tiên).
- **Dependency Injection**: Sử dụng `get_it` kết hợp với `injectable`. Chạy `dart run build_runner build` để generate code.
- **Navigation**: Sử dụng `go_router` và kiến trúc `Navigator` riêng cho từng feature để tách biệt logic điều hướng.
- **Localization**: Sử dụng `flutter_intl`. Các file ngôn ngữ nằm trong `lib/l10n`. Truy cập qua `S.of(context)`.
- **Assets**: Truy cập qua class `AppAssets` trong `lib/core/constants`.
- **Colors**: Sử dụng `AppColors` trong `lib/core/constants` hoặc `Theme.of(context).colorScheme`.

---

## 4. Enums & Extensions ưu tiên dùng

### Core Extensions (`lib/core/extensions`)

Ưu tiên sử dụng các extension này để code ngắn gọn và dễ đọc hơn:

- **NumExtensions (`num_extensions.dart`)**:
    - Khoảng cách: `16.height`, `10.width` (trả về `SizedBox`).
    - Padding: `16.padding`, `8.paddingHorizontal`, `4.paddingTop`.
    - Radius: `12.borderRadius`, `8.radius`.
    - Duration: `500.milliseconds`, `2.seconds`.
- **StringExtensions (`string_extensions.dart`)**:
    - `isValidEmail`: Kiểm tra email.
    - `capitalize`: Viết hoa chữ cái đầu.
    - `toDouble`, `toInt`: Chuyển đổi kiểu dữ liệu an toàn.

### Core Enums (`lib/core/enums`)

Luôn kiểm tra và sử dụng các enum có sẵn trước khi tạo mới:

- `LoadStatus`: `initial`, `loading`, `success`, `failure`.
- `MediaType`: `image`, `video`.
- `ScanMode`: Chế độ scan trong app.
- `FaceCoverType`: Các loại che mặt (blur, emoji, v.v.).

---

## 5. UI Components dùng chung

Trước khi build widget mới, hãy kiểm tra `lib/presentation/widgets`:
- **Buttons**: `PrimaryButton`, `SecondaryButton`, `AppIconButton`.
- **Containers**: `GlassContainer`, `PrimaryContainer`.
- **Scaffold**: `BaseScaffold`.
- **Dialogs & Notifications**: `AppDialog`, `AppSnackBar`.

---

*Lưu ý: Luôn tuân thủ coding convention hiện tại của project để đảm bảo tính nhất quán.*
