# HealthAppTec

This iOS application was developed as part of the **Aplicaciones Móviles** course during 2021. The project showcases basic functionality for fetching information from remote services and interacting with Firebase for authentication.

## Features

- **Onboarding**: Several introductory screens guide the user through the main purpose of the app.
- **Firebase Login**: Uses Firebase Authentication to sign in with email and password.
- **News Section**: Retrieves COVID‑19 news from an external JSON endpoint and displays them in a horizontal collection view. Each news card includes an image, source and title with a button that opens the full article in the browser.
- **Reports Section**: Loads vaccination reports from a remote JSON service and shows them in a searchable table view. Tapping a row presents the detailed information about the patient, vaccine and symptoms reported.
- **Map Integration**: A dedicated view shows a map of nearby hospitals with an option to open directions in Waze.
- **Profile Section**: Simple screen displaying an account image.

The app was built with Swift and UIKit using storyboards. CocoaPods manages dependencies such as Firebase/Firestore and Firebase/Auth.

## Remote Endpoints

The application fetches JSON data from the following URLs (as defined in the controllers):

- News: `http://martinmolina.com.mx/202113/tc2024/equipo1/Noticias.json`
- Reports: `http://martinmolina.com.mx/202113/tc2024/equipo1/formulario.json`

## Setup

1. Install [CocoaPods](https://cocoapods.org/) if not already available.
2. Run `pod install` in the project directory to install dependencies.
3. Open `HealthApp.xcworkspace` in Xcode.
4. Build and run on an iOS device or simulator.

Firebase configuration is included via `GoogleService-Info.plist` which contains the project identifiers and API keys for the demo application.

## License

This repository is intended for educational purposes as part of the Tec de Monterrey mobile applications coursework.
