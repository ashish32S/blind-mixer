Mixer UI (Flutter)

This project implements four static, responsive Flutter screens without fetching from Figma:
- Subscription
- Mixer
- Mixer VIP
- Upgrade Homepage

Getting Started
1) Ensure Flutter SDK (3.3+) is installed
2) From project root, run:

```
flutter pub get
flutter run -d chrome   # or a connected device/emulator
```

Project Structure
- lib/
  - main.dart (launcher + routes)
  - theme/app_theme.dart (colors, typography, components)
  - widgets/ (shared UI pieces)
  - screens/ (four screens)

Notes
- The UI is static and aims for pixel-precision style without loading the Figma file.
- Uses Inter via google_fonts.

# blind-mixer