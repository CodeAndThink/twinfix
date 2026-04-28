# TwinFix - Mobile Application for Motorcycle Repair Service

TwinFix is a comprehensive Flutter-based mobile application designed to connect motorcycle owners with skilled mechanics for repair services. The app facilitates easy booking of mechanic services, real-time tracking, and seamless communication between users and service providers.

## 📋 Project Overview

This project is a dual-interface application catering to two primary user types: **Users** (motorcycle owners seeking repairs) and **Mechanics** (service providers offering repair services).

### 🎯 Key Features

#### For Users
- **Service Booking**: Browse and book motorcycle repair services.
- **Service History**: View past repair jobs and service records.
- **Mechanic Management**: Manage assigned mechanics and service providers.

#### For Mechanics
- **Work Orders**: Receive and manage job requests from users.
- **Job Management**: View current jobs, job details, and service history.
- **User Management**: Access information about the users requesting service.

## 🛠️ Tech Stack

- **Framework**: Flutter
- **Language**: Dart
- **State Management**: Bloc
- **Navigation**: GoRouter
- **HTTP Client**: Dio
- **Local Storage**: SharedPreferences
- **Background Location**: Flutter Background Location

## 📂 Project Structure

The project follows a clean architecture pattern, separating concerns between UI, business logic, and data layers.

```
lib/
├── common/                # Shared utilities, constants, and helpers
│   └── services/          # External service integrations (Location, HTTP)
├── data/                  # Data layer
│   ├── models/            # Data models and DTOs
│   └── repositories/      # Repository implementations
├── presentation/          # Presentation layer (UI)
│   ├── app/               # App-level configurations (App, Routes, Bloc Providers)
│   ├── blocs/             # BLoC instances and event handlers
│   ├── screens/           # Individual screen widgets
│   │   ├── auth/          # Authentication screens
│   │   ├── user/          # User/Customer specific screens
│   │   ├── mechanic/      # Mechanic specific screens
│   │   ├── profile/       # Profile management screens
│   │   └── splash/        # Splash screen
│   └── widgets/           # Reusable UI components
└── main.dart              # Application entry point
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK installed (version 3.x recommended)
- Dart SDK installed
- Android Studio / VS Code with Flutter extensions

### Installation

1. **Clone the repository** (or download the source code).

2. **Install dependencies**:
   Run the following command in the project root directory:
   ```bash
   flutter pub get
   ```

3. **Configure Environment Variables**:
   Create a `.env` file in the root directory (if not present) and add the following:
   ```env
   API_URL=http://[IP_ADDRESS]/api
   ```

4. **Run the application**:
   ```bash
   flutter run
   ```

## 🧭 App Navigation Flow

### User Authentication Flow
```
Splash Screen -> Login/Signup -> Home Screen (User)
```

### Mechanic Authentication Flow
```
Splash Screen -> Login/Signup -> Home Screen (Mechanic)
```

## 📋 Current Features in Detail

### 1. Authentication System
- **Login**: Email and password-based login for both users and mechanics.
- **Registration**: Separate registration flows for Users and Mechanics.
- **Password Reset**: Forgot password functionality.
- **Session Management**: Automatic token storage and retrieval using SharedPreferences.

### 2. User Features
- **Service Booking**: Users can view available mechanics and request services.
- **Job History**: Complete log of all past services and repair jobs.
- **Profile Management**: Update personal information and contact details.
- **Address Management**: Add, edit, and delete delivery/service addresses.

### 3. Mechanic Features
- **Dashboard**: Overview of assigned jobs and upcoming tasks.
- **Work Order Management**: Detailed views of job requirements and user information.
- **Profile & Settings**: Manage availability status and profile details.

### 4. Location Services
- **Background Location**: The app uses the `flutter_background_location` package to track the mechanic's location in the background (requires user permission).

## 🧩 State Management

The application uses the BLoC (Business Logic Component) pattern to manage state:
- **Events**: Trigger actions (e.g., `LoginRequested`).
- **States**: Represent the current state of the UI (e.g., `LoginLoading`, `LoginSuccess`).
- **Blocs**: Handle the logic and emit new states based on events.

## 🤝 Contributing

1. Create a feature branch (`git checkout -b feature/AmazingFeature`).
2. Commit your changes (`git commit -m 'Add some AmazingFeature'`).
3. Push to the branch (`git push origin feature/AmazingFeature`).
4. Open a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Contact

- **Project Lead**: [truongngo]
- **Email**: [trg1432001.tu@gmail.com]
