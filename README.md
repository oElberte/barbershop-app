# Barbershop App

A modern barbershop management application built with Flutter using Riverpod for state management.

## 📱 About

Barbershop App is a comprehensive mobile application that connects barbershop owners, employees, and customers. It allows barbershop owners to manage their business, employees to view their schedules, and customers to book appointments. The app features a clean and intuitive user interface with a focus on user experience.

## 🏗️ Architecture

This project follows **Clean Architecture with Riverpod** principles:

- **Riverpod**: Manages state and business logic, separating it from the UI
- **Repository Pattern**: Abstracts data sources, providing a clean API for the domain layer
- **Dependency Injection**: Uses Riverpod for dependency management
- **Feature-based Structure**: Organized by features rather than technical concerns

## 🛠️ Tech Stack

- **Flutter**: UI framework
- **Dart**: Programming language
- **Riverpod**: State management
- **AsyncState**: Loading state management
- **Dio**: HTTP client for API communication
- **Shared Preferences**: Local storage
- **Validatorless**: Form validation
- **Table Calendar & SyncFusion Calendar**: Calendar widgets for scheduling
- **Intl**: Internationalization and localization

## 🌟 Features

- User authentication (login/register)
- Different user roles (admin, employee, customer)
- Barbershop registration and management
- Employee management
- Schedule management and appointment booking
- Profile management
- Localization support (Brazilian Portuguese)

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.0.6 <4.0.0)
- Dart SDK
- Android Studio / VS Code
- Android/iOS emulator or physical device

### Installation

1. Clone the repository

   ```
   git clone https://github.com/oElberte/barbershop-app.git
   ```

2. Install dependencies

   ```
   flutter pub get
   ```

3. Run the app
   ```
   flutter run
   ```

## 📂 Project Structure

```
lib/
├── main.dart                 # Entry point
└── src/
    ├── barbershop_app.dart   # Main app widget
    ├── core/                 # Core functionality
    │   ├── constants/        # App constants
    │   ├── exceptions/       # Custom exceptions
    │   ├── fp/               # Functional programming utilities
    │   ├── providers/        # Core providers
    │   ├── rest_client/      # API client configuration
    │   └── ui/               # UI components and theme
    ├── features/             # App features
    │   ├── auth/             # Authentication (login, register)
    │   ├── employee/         # Employee management
    │   ├── home/             # Home screens (admin, employee)
    │   ├── schedules/        # Scheduling functionality
    │   └── splash/           # Splash screen
    ├── models/               # Domain models
    ├── repositories/         # Data repositories
    └── services/             # Business services
```

## 👥 User Roles

- **Admin**: Barbershop owners who can manage their business, employees, and schedules
- **Employee**: Barbers who can view their schedules and manage appointments
- **Customer**: End users who can book appointments with barbers

## 🔒 Authentication

The app uses a token-based authentication system with secure storage of credentials.

## 📸 Screenshots

### Administrator View

The administrator interface allows barbershop owners to manage their business efficiently.

<div style="display: flex; flex-wrap: wrap; gap: 10px; justify-content: center; align-items: flex-start;">
    <img src="screenshots/adm_01.png" width="200" alt="Admin Dashboard">
    <img src="screenshots/adm_02.png" width="200" alt="Admin Management">
    <img src="screenshots/adm_03.png" width="200" alt="Employee Overview">
    <img src="screenshots/adm_04.png" width="200" alt="Schedule Management">
    <img src="screenshots/adm_05.png" width="200" alt="Admin Calendar">
    <img src="screenshots/adm_06.png" width="200" alt="Business Settings">
    <img src="screenshots/adm_07.png" width="200" alt="Customer Management">
    <img src="screenshots/adm_08.png" width="200" alt="Appointment Details">
    <img src="screenshots/adm_09.png" width="200" alt="Analytics Dashboard">
</div>

### Collaborator/User View

The user interface provides a seamless booking experience for customers.

<div style="display: flex; flex-wrap: wrap; gap: 10px; justify-content: center; align-items: flex-start;">
    <img src="screenshots/colab_01.png" width="200" alt="User Dashboard">
    <img src="screenshots/colab_03.png" width="200" alt="Booking Interface">
    <img src="screenshots/colab_04.png" width="200" alt="Appointment Selection">
    <img src="screenshots/colab_05.png" width="200" alt="Confirmation Screen">
</div>
