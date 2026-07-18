# TrashBug — Municipal Trash Detection App

Mobile application that helps municipalities identify and track trash-prone areas using crowdsourced geo-location data and image-based trash detection.

## Stack

- **Flutter** (Dart) — cross-platform mobile app
- **Firebase** — Auth, Firestore, Cloud Storage
- **Google Maps API** — geo-location pins, heatmap visualization
- **Flask** backend — REST APIs for image upload and trash detection ML model

## Features

- Crowdsourced trash reporting with geo-tagged photo uploads
- Real-time map visualization of trash-prone zones
- User dashboard with reporting stats and status tracking
- Firebase Auth with login/signup flows
- Image scanning for trash detection classification

## Architecture

```
lib/
├── ui/              # Screens — dashboard, login, profile, scan, status
├── services/        # Firebase auth, Firestore database, backend API
├── models/          # User, DashData models
├── locations/       # Google Maps integration
├── backend/         # Location + timestamp tracking
├── utils/           # Constants, UI helpers
└── style/           # Theming
```

## Impact

- **500+** user-generated geo-location pins in the first month
- **1000+** image uploads and location updates monthly via REST APIs

## Setup

```bash
flutter pub get
# Configure Firebase (google-services.json / GoogleService-Info.plist)
# Set Google Maps API key in AndroidManifest.xml / AppDelegate.swift
flutter run
```
