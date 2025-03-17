# USoftware_Test
<<<<<<< HEAD
USoftware_Test_Submit
=======

## Overview
This is an iOS application built using **SwiftUI** that fetches and displays a list of characters from an API. It includes search functionality and detailed character views.

## Requirements
- **Xcode 15+**
- **iOS 17+**
- **Swift 5+**

## Installation
### **1. Clone the Repository**
```sh
git clone https://github.com/ShaybazSayyed/USoftware_Test.git
cd USoftware_Test
```

### **2. Open in Xcode**
```sh
open USoftware_Test.xcodeproj
```

## Running the Application
1. Open the project in Xcode.
2. Select a **Simulator** (e.g., iPhone 15 Pro) or a connected iOS device.
3. Click **Run (▶️)** or use the shortcut `Cmd + R`.

## Project Structure
- **Models/** → Contains data structures (`CharacterModel.swift`).
- **ViewModels/** → Handles data fetching & logic (`CharacterListViewModel.swift`).
- **Views/** → UI components (`CharacterListView.swift`, `CharacterDetailView.swift`).
- **Networking/** → API service (`APIService.swift`).
- **Tests/** → Unit & UI Tests (`USoftware_TestTests`, `USoftware_TestUITests`).

## API Integration
- The app fetches data from the **Rick and Morty API**.
- API requests are handled in `APIService.swift` using Combine framework.

## GitHub Actions (CI/CD)
- The app uses a **GitHub Actions workflow** (`.github/workflows/ios-ci.yml`) for continuous integration.
- Ensure your **GitHub token** has `workflow` scope to push updates.

## Contributing
1. **Fork the repository**.
2. **Create a new branch** for your feature:
   ```sh
   git checkout -b feature-name
   ```
3. **Commit your changes**:
   ```sh
   git commit -m "Add new feature"
   ```
4. **Push and create a Pull Request**:
   ```sh
   git push origin feature-name
   ```

## License
This project is licensed under the **MIT License**.

---
Feel free to contribute or report issues! 🚀

>>>>>>> f7c398e (Initial commit)
