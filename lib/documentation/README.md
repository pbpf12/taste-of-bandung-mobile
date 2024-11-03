# App Routing Structure

App Wrapper
├── AuthenticationScreen
└── MainScreen
    ├── HomePage
    ├── SearchPage
    ├── BookmarkPage
    └── ProfilePage
        └── ProfileDetailScreen

# Starting Development Commands Prompts

```bash
flutter install
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```