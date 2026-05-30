# Twinfix Project Guide

This document provides an overview of the project structure, rules, and available utilities to help develop quickly and consistently.

---

## 1. Project Structure

The project follows **Clean Architecture** divided into the following main layers:

- `lib/core`: Contains configurations, constants, Dependency Injection (DI), enums, extensions, and shared services.
- `lib/data`: Implementation of Repositories, DataSources, Models (DTOs), and database entities (Isar).
- `lib/domain`: Contains core Business Logic: Entities, Repository Interfaces, and UseCases.
- `lib/presentation`: The UI layer, including:
    - `app`: Main application configurations.
    - `features`: Divided by features (screens).
    - `theme`: Styles, colors, and fonts definitions.
    - `widgets`: Shared components used across the app.

---

## 2. Feature Folder Structure

Each feature in `lib/presentation/features` should follow this structure:

```text
feature_name/
├── cubit/          # State Management (Bloc/Cubit)
├── navigator/      # Navigation handling (Navigator, State, Cubit)
├── page/           # Contains the main Widget of the screen
└── widgets/        # Sub-widgets exclusively used by this feature
```

---

## 3. Project Rules

- **State Management**: Use `flutter_bloc` (Cubit is preferred).
- **Dependency Injection**: Use `get_it` combined with `injectable`. Run `dart run build_runner build` to generate code.
- **Navigation**: Use `go_router` and a dedicated `Navigator` architecture for each feature to isolate navigation logic.
- **Localization**: Use `flutter_intl`. Language files are located in `lib/l10n`. Access them via `S.of(context)`.
- **Assets**: Access via the `AppAssets` class in `lib/core/constants`.
- **Colors**: Use `AppColors` in `lib/core/constants` or `Theme.of(context).colorScheme`.

---

## 4. Preferred Enums & Extensions

### Core Extensions (`lib/core/extensions`)

Prioritize using these extensions to keep the code concise and readable:

- **NumExtensions (`num_extensions.dart`)**:
    - Spacing: `16.height`, `10.width` (returns `SizedBox`).
    - Padding: `16.padding`, `8.paddingHorizontal`, `4.paddingTop`.
    - Radius: `12.borderRadius`, `8.radius`.
    - Duration: `500.milliseconds`, `2.seconds`.
- **StringExtensions (`string_extensions.dart`)**:
    - `isValidEmail`: Checks for valid email format.
    - `capitalize`: Capitalizes the first letter.
    - `toDouble`, `toInt`: Safe data type conversion.

### Core Enums (`lib/core/enums`)

Always check and use existing enums before creating new ones:

- `LoadStatus`: `initial`, `loading`, `success`, `failure`.
- `MediaType`: `image`, `video`.
- `ScanMode`: Scanning modes in the app.
- `FaceCoverType`: Face cover types (blur, emoji, etc.).

---

## 5. Shared UI Components

Before building a new widget, check `lib/presentation/widgets`:
- **Buttons**: `PrimaryButton`, `SecondaryButton`, `AppIconButton`.
- **Containers**: `GlassContainer`, `PrimaryContainer`.
- **Scaffold**: `BaseScaffold`.
- **Dialogs & Notifications**: `AppDialog`, `AppSnackBar`.

---

*Note: Always follow the current coding conventions of the project to ensure consistency.*
