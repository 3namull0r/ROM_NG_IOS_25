# ROM_NG_IOS_25
# 📚 Don't Judge

**Don't Judge** is a SwiftUI-based iOS app that lets users search for books and browse results in a clean, cover-focused UI. The goal is to encourage exploration beyond just the book cover — tap to reveal full details.

## ✨ Features

- 🔍 **Search** for books using the Google Books API.
- 🖼️ **Browse results** in two views:
  - **Carousel View**: Swipeable covers.
  - **List View**: Titled rows with thumbnails.
- 📖 **Detail View**: Displays book info, description, and cover.
- 🧪 **Test coverage**:
  - Unit tests for view models.
  - Snapshot and UI tests with accessibility identifiers.

## 🛠️ Tech Stack

- SwiftUI & Combine
- MVVM architecture
- Alamofire & Async/Await networking
- XCTest + Snapshot Testing
- Accessibility identifiers for UI testing

## 🚀 Getting Started

1. Clone this repo
2. Open in Xcode 15+
3. Run on iOS 17+ Simulator or Device

Note: The Google Books Api can rate limit the requests if a valid api key is not provided. You can get one by following the steps here: https://developers.google.com/books/docs/v1/using#APIKey
A valid apikey can be added as an environment variable in the project with the key "GOOGLE_BOOKS_API_KEY"

