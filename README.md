✅ Main Features
- Implemented Home Screen with:
  • Recommended experiences (horizontal list)
  • Recent experiences (vertical list)
  • Dynamic offline/online data caching (via CacheManager + File storage)
  • Like Experience (syncs with API + updates cache)
  • Search functionality with IME search and clear support
  • Fully responsive layout using SwiftUI + Kingfisher
  • Navigation to Detail View via sheet

- Implemented Experience Detail Screen:
  • Full-screen presentation with smooth transition
  • Dynamic content display with title, description, stats
  • Like button with local + remote update
  • Share action (UIActivityViewController integration)

✅ Architecture & Structure
- MVVM layered structure:
  • Network Layer → APIRequest + NetworkManager
  • Repository Layer → HomeRepository, ExperienceRepository
  • Cache Layer → CacheManager with JSON file persistence
  • Presentation Layer → SwiftUI Views (Home, SearchResults, Details)
  • Models → Experience (shared model)
- Dependency Injection for repositories and testing

✅ Offline/Online Sync
- Unified cache for all experience data
- Repositories automatically fallback to cache when offline
- Like state persists across Home / Search / Detail synchronously

✅ Testing
- Unit Tests:
  • HomeRepositoryTests (network, cache, fallback, like)
  • HomeViewModelTests (state, search, like)
  • MockNetwork & MockCache for isolation
  • Static mock data (Abu Simbel Temples)
- UI Tests:
  • Search flow, open detail, share, and close actions
  • Dynamic wait handling for screen transitions

✅ Tools & Dependencies
- SwiftUI (programmatic UI)
- Kingfisher for image caching
- Combine for state binding
- XCTest for Unit & UI testing
- Offline-friendly architecture (no UserDefaults usage)

🧱 Project Ready for Review
- Fully responsive and pixel-accurate design (Figma reference)
- Clean, maintainable, testable codebase
- Organized folder structure and dependency injection
- Production-grade SwiftUI implementation

🚀 Ready for submission.
