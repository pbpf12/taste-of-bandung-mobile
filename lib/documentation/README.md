# Getting Started IMPORTANT!
### Deskripsi:
MUST IMPLEMENT !!!!
### Langkah:
- pastikan *django taste of bandung* sudah up to date dengan commit terakhir
- run *django taste of bandung*
- buat file `selected_base_url.dart` di `lib/core/environments`, dan isi dengan:
    ```dart
    import '../bases/enums/my_backend.dart';

    class SelectedBaseUrl {
        final domain = MyBackend.LOCALHOST_EMULATOR; // Sesuaikan dengan Perangkat Debugging
    }
    ```
- run flutter
### Detail:
* pilihan dari MyBackend ada PRODUCTION, LOCALHOST_EMULATOR, LOCALHOST_WEB
* contoh penggunaan dapat dilihat di lib/features/authentication/login.dart
* berikut detail gambar yang dapat membantu
    ![Lokasi File `selected_base_url.dart`](file_location.png)
    ![Isi dari File `selected_base_url.dart`](isi_file.png)

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