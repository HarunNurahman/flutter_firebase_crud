# Flutter Firebase CRUD App

A Flutter application demonstrating CRUD operations using Firebase. This app includes authentication and real-time database operations.

## Prerequisites

Before you begin, ensure you have the following installed:
- [Flutter](https://flutter.dev/docs/get-started/install) (latest version)
- [Git](https://git-scm.com/downloads)
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/)
- A Firebase account

## Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/flutter_firebase_crud.git
cd flutter_firebase_crud
```

2. Install dependencies:
```bash
flutter pub get
```

3. Firebase Setup:
   - Create a new project in [Firebase Console](https://console.firebase.google.com/)
   - Add an Android app to your Firebase project:
     - Package name: `com.example.flutter_firebase_crud`
     - Download `google-services.json` and place it in `android/app/`
   - Add an iOS app to your Firebase project:
     - Bundle ID: `com.example.flutterFirebaseCrud`
     - Download `GoogleService-Info.plist` and place it in `ios/Runner/`

4. Enable Authentication:
   - In Firebase Console, go to Authentication
   - Enable Email/Password authentication

5. Enable Realtime Database:
   - In Firebase Console, go to Realtime Database
   - Create a database
   - Set rules for read/write access

## Running the App

1. Open an emulator or connect a physical device

2. Run the app:
```bash
flutter run
```

## Features

- User Authentication (Sign up, Login, Logout)
- CRUD Operations:
  - Create: Add new members
  - Read: View all members
  - Update: Edit member details
  - Delete: Remove members

## Project Structure

```
lib/
├── core/
│   ├── configs/
│   └── services/
├── modules/
│   ├── bloc/
│   ├── models/
│   └── presentation/
└── main.dart
```

## Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.