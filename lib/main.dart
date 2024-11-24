import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:tasteofbandung/core/themes/color/theme.dart';
import 'app.dart';
import 'services/dependencies/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  CookieRequest request = CookieRequest();
  await request.init(); 

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => request),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(request),
        ),
      ],
      child: const App(),
    ),
  );
}
