# SquareGPS Test App

Test assignment for Navixy — GPS tracker monitoring (iOS, SwiftUI)

---

## 📱 Description

This app allows you to:
- View a list of your GPS trackers (offline-first)
- See detailed info about any tracker
- Track coordinates (latitude/longitude) and heading for selected tracker
- Visualize tracker position on a map
- Use the app even without internet using local cache (CoreData)
- Refresh the data via pull-to-refresh

---

## 📺 Screenshots
<img width="1320" height="2868" alt="Simulator Screenshot - iPhone 17 Pro Max - 2026-05-04 at 00 41 09" src="https://github.com/user-attachments/assets/4d941892-7b3f-44d6-a61f-94d79a10242e" />
<img width="1320" height="2868" alt="Simulator Screenshot - iPhone 17 Pro Max - 2026-05-04 at 00 41 25" src="https://github.com/user-attachments/assets/b9e07fea-75da-4014-8fa8-e71e0cbe0f28" />


## 🚀 How to run

1. Clone the repository or download the archive:
git clone https://github.com/YOUR_REPO/SquareGPS_Test_App.git
2. Open the project in Xcode (recommended: Xcode 15+).
3. Build (`⌘B`) and run (`⌘R`) on a simulator or iOS device (iOS 17+ recommended).
4. No login screen needed - the demo account is preconfigured in the app.

---

## 🏗 Project Structure

- **UI (Views):**
 - `TrackersListView` — tracker list, with pull-to-refresh and navigation to details
 - `TrackerDetailView` — detailed info (label, model, deviceId, coordinates, map)
 - `TrackersMapView` — displays the tracker position on MapKit
 - Loading/activity indicator and offline/error banner support
- **ViewModels:**
 - `TrackersListViewModel`, `TrackerDetailViewModel` — manage state, polling, error/offline states
- **Domain:**
 - `Tracker` — main business model
 - Use case classes: `GetTrackersUseCase`, `GetTrackerDetailUseCase`
 - Protocol: `TrackerRepository`
- **Data:**
 - `ApiService` — handles API requests to Navixy, manages session hash, async/await
 - `TrackerDao`, `CoreDataStack` — CoreData local DB for offline-first
 - Mapping: `TrackerMapper`
 - DTO/Entities: all server and local data structures
 - Logging: `NetworkLogger`
- **Mocks/Preview:** minimal mock repositories for SwiftUI previews

---

## 💡 Features implemented

- **Offline-first:** all data is read from local DB, even offline; network refresh writes into CoreData.
- **Two screens:** tracker list and tracker details.
- **Pull-to-refresh:** immediate manual refresh support.
- **Error handling:** offline/error banner or message displayed.
- **Local caching:** CoreData for persistence and offline support.
- **Coordinate polling:** timer-based polling on tracker detail screen (every 10 seconds).
- **Map:** single tracker marker with label shown.
- **Architectural layering (UI / ViewModel / Domain / Data).**
- **Full logging of all network requests and responses to console.**
- **Session hash is stored and reused between runs (UserDefaults).**

---

## ⚡️ Optional

- [x] Coordinate and heading display for tracker
- [x] Map marker with label
- [x] Correct polling lifecycle control (stops when screen is left)
- [ ] Marker rotation by heading (could be added for extra credit)

---

## 😅 Trade-offs and possible improvements

- No separate login screen (not required by assignment)
- Error display is banner/text (not snackbar)
- Preview/Mocks are defined in UI files for convenience (in production, should be moved to test target)
- No unit tests due to limited time (architecture makes it easy to add)

---

## 🧩 Architecture used

- SwiftUI + MVVM + Clean Architecture
- Data Layer: CoreData, URLSession, DTOs, mappers
- Domain: business models and use cases
- UI: simple Views + ViewModels using ObservableObject/@Published, **no business logic in UI**

---

## 💬 Questions & contacts

Feel free to ask me any questions about architecture, logic, or implementation — happy to discuss or explain details!

---
