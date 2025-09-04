# Soil Health Monitoring App

A Flutter application that connects to a Bluetooth device to retrieve soil temperature and moisture readings, stores them in Firebase, and displays current and historical data.

---

## 📲 Download / Demo
- **App Link (APK/Play Store):** [Download App](https://your-app-link.com)  
- **Demo Video:** [Watch Demo](https://your-video-link.com)  

---

## ⚙️ Setup Instructions

### Prerequisites
- Flutter SDK (version 3.0.0 or higher)
- Android Studio or VS Code
- Firebase account

### Installation
1. Clone or download the project
2. Run `flutter pub get` to install dependencies
3. Set up Firebase project:
   - Create a new project in Firebase Console
   - Add an Android app to your project
   - Download `google-services.json` and place it in `android/app/` directory
   - Enable Email/Password authentication in Authentication section
   - Enable Firestore Database

4. Run the app:
   - `flutter run` to run on a connected device/emulator

---

## 📡 Bluetooth Assumptions
- The app currently uses mock data for Bluetooth readings
- For real implementation, you would need to:
  - Add Bluetooth permissions to `AndroidManifest.xml`
  - Implement actual Bluetooth device scanning and connection
  - Parse the data format from your specific device
  - The `BluetoothService` class is structured to make this transition straightforward

---

## ✨ Features
- User authentication (email/password)
- Mock Bluetooth data retrieval
- Firebase Firestore integration for data storage
- Current reading display
- Historical data viewing with charts
- Clean, intuitive UI

---

## 📦 Dependencies
- `provider`: State management
- `firebase_core`, `cloud_firestore`, `firebase_auth`: Firebase integration
- `flutter_blue_plus`: Bluetooth functionality (currently used for mock data)
- `syncfusion_flutter_charts`: Data visualization

---

## 📂 Project Structure
- `/lib/models`: Data models  
- `/lib/services`: External service integrations  
- `/lib/providers`: State management using Provider  
- `/lib/screens`: UI screens  
- `/lib/widgets`: Reusable UI components  
