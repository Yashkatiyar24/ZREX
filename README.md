# Instagram Home Feed Clone - Flutter

A high-fidelity, production-quality Instagram Home Feed replication built with Flutter. This project focuses on visual accuracy, smooth interactions, and robust architecture.

## 🚀 Features

- **Pixel-Perfect UI**: Replicates the Instagram Home Feed layout including the Top Bar, Stories Tray, and Post Cards.
- **Stories Tray**: Horizontal scrollable tray with Instagram's signature gradient borders.
- **Rich Post Feed**:
  - Support for single images and **Carousel posts**.
  - Custom dot indicators for carousel navigation.
  - **Pinch-to-Zoom**: Smooth zoom interaction on post images using `PhotoView`.
- **Interactions**:
  - Like & Save state toggling with local optimistic updates.
  - Animated like heart scaling.
  - Custom Snackbar feedback for unimplemented features (Comment, Share).
- **Infinite Scrolling**: Automatic pagination as the user scrolls, with smooth data appending.
- **Shimmer Loading**: Professional loading placeholders that match the feed layout.
- **High Performance**: 60fps scrolling using `ListView.builder` and memory-efficient image caching.

## 🛠 Tech Stack

- **Framework**: Flutter (Latest Stable)
- **State Management**: [Riverpod](https://riverpod.dev/) (StateNotifier for robust state handling)
- **Networking/Data**: Mock Repository with simulated latency (1.5s)
- **UI Components**:
  - `cached_network_image`: For efficient image loading and caching.
  - `shimmer`: For skeleton loading states.
  - `carousel_slider`: For multi-image posts.
  - `photo_view`: For high-performance pinch-to-zoom logic.
  - `google_fonts`: For typography (Inter).
  - `font_awesome_flutter`: For Instagram-style iconography.

## 🏗 Architecture

The project follows **Clean Architecture** principles:

- **Models**: `Post` model representing the data structure.
- **Services**: `PostRepository` handles data fetching (simulated API).
- **Providers**: Riverpod providers manage the application state and business logic.
- **Widgets**: Highly modular and reusable components (e.g., `PostCard`, `LikeButton`, `StoriesBar`).
- **Screens**: Top-level UI containers like `HomeFeedScreen`.
- **Utils**: Global constants for themes, colors, and styles.

## 🧠 Implementation Detail: Pagination

The pagination is handled by the `PostNotifier` (Riverpod). It keeps track of the `currentPage` and `isLoadingMore` state. The `HomeFeedScreen` uses a `ScrollController` to detect when the user is within 1000 pixels (roughly 2 posts) of the bottom and triggers `fetchMorePosts()`. This ensures a seamless "infinite scroll" experience without UI flickering.

## 🔍 Implementation Detail: Pinch-to-Zoom

Pinch-to-zoom is implemented using the `PhotoView` package wrapped in a `PinchToZoomImage` widget. It allows users to zoom into images while maintaining a smooth return-to-center animation upon release, mimicking the real Instagram user experience.

## 🏁 How to Run

1.  **Clone the repository** (if applicable).
2.  **Navigate to the project directory**:
    ```bash
    cd instagram_clone
    ```
3.  **Install dependencies**:
    ```bash
    flutter pub get
    ```
4.  **Run the app**:
    ```bash
    flutter run
    ```

---

*Built with ❤️ by Yash*
