import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasteofbandung/app_wrapper.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        title: "Taste of Bandung",
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: const AppWrapper()
      ),
    );
  }
}