<div align="center">

# 📰 Newzly

### A Modern Cross-Platform News App Built with Flutter & Firebase

[![Flutter](https://img.shields.io/badge/Flutter-3.9.2-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.9-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Backend-FFCA28?logo=firebase&logoColor=black)](https://firebase.google.com)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](#license)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-blue)](#)

</div>

---

## 📖 Overview

**Newzly** is a cross-platform mobile news application that delivers real-time news powered by [NewsAPI](https://newsapi.org/). Built with Flutter and backed by Firebase, it offers a clean, fast, and personalized reading experience — from secure authentication to category-based browsing and a favourites list, all wrapped in a polished light/dark UI.

---

## ✨ Key Features

| Feature | Description |
|---|---|
| 🔐 **Secure Authentication** | Email/password sign-up, login, and password recovery via Firebase Auth |
| 📡 **Real-Time News Feed** | Fetches the latest headlines and articles from NewsAPI |
| 🗂️ **Category Browsing** | Explore news by topic — technology, business, sports, and more |
| ⭐ **Favourites** | Bookmark articles to revisit later |
| 🌗 **Light / Dark Theme** | Seamless theme switching powered by Provider |
| 🎬 **Animated Splash Screen** | Smooth onboarding experience using Lottie animations |
| 📱 **Cross-Platform Support** | Runs natively on Android, iOS, Web, Windows, macOS, and Linux |

---

## 🛠️ Tech Stack

- **Framework:** Flutter
- **Language:** Dart
- **State Management:** Provider
- **Backend:** Firebase (Authentication, Firestore, Realtime Database)
- **News Data:** NewsAPI
- **UI/UX:** Google Fonts, Lottie, Cached Network Image

---

## 📂 Project Structure

```
lib/
├── Auth/
│   ├── login_screen.dart
│   ├── Signup_screen.dart
│   └── forgetpassword_screen.dart
├── models/
│   ├── news_model.dart
│   ├── general_model.dart
│   ├── categories_model.dart
│   └── favourite_model.dart
├── view/
│   ├── splash_screen.dart
│   ├── home_screen.dart
│   ├── categories_page.dart
│   ├── categories_details.dart
│   ├── favourite_screen.dart
│   ├── custom_drawer.dart
│   └── theme.dart
├── firebase_options.dart
└── main.dart
```

---

## 🚀 Getting Started

### Prerequisites

Make sure you have the following installed:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) `^3.9.2`
- A configured [Firebase](https://console.firebase.google.com/) project (Auth + Firestore/Realtime Database enabled)
- A free [NewsAPI](https://newsapi.org/) API key

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/<your-username>/Newzly-Flutter.git
   cd Newzly-Flutter
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**

   Set up Firebase for your project using the [FlutterFire CLI](https://firebase.google.com/docs/flutter/setup):
   ```bash
   flutterfire configure
   ```
   This regenerates `lib/firebase_options.dart` for your own Firebase project.

4. **Add your NewsAPI key**

   Set your API key in the model files located under `lib/models/` (referenced as `apiKey`).

5. **Run the app**
   ```bash
   flutter run
   ```

---

## 📱 App Screens

- Splash Screen
- Login / Sign Up / Forgot Password
- Home — Latest Headlines
- Categories
- Category Details
- Favourites
- Custom Navigation Drawer

---

## 🗺️ Roadmap

- [ ] Persist favourites to Firebase instead of local state
- [ ] Add pull-to-refresh on news feeds
- [ ] Implement search functionality
- [ ] Push notifications for breaking news

---

## 🤝 Contributing

Contributions are welcome! To contribute:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/your-feature`)
3. Commit your changes (`git commit -m 'Add your feature'`)
4. Push to the branch (`git push origin feature/your-feature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the **MIT License** — feel free to use it for learning or personal projects.

---

<div align="center">

Made with ❤️ using Flutter

</div>
