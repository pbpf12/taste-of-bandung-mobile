part of '_environments.dart';

class EndPoints {
  String get prodBaseUrl => "rahardi-salim-tasteofbandung.pbp.cs.ui.ac.id";
  String get devBaseUrlWeb => '127.0.0.1:8000';
  String get devBaseUrlEmulator => '10.0.2.2:8000';

  String get myBaseUrl {
    switch (SelectedBaseUrl().domain) {
      case MyBackend.PRODUCTION:
        return prodBaseUrl;
      case MyBackend.LOCALHOST_WEB:
        return devBaseUrlWeb;
      case MyBackend.LOCALHOST_EMULATOR:
        return devBaseUrlEmulator;
    }
  }

  SearchPaths get searchPaths => SearchPaths();
  BookmarkPaths get bookmarkPaths => BookmarkPaths();
  DetailPaths get detailPaths => DetailPaths();
  ProfilePaths get profilePaths => ProfilePaths();
  HomePaths get homePaths => HomePaths();
}