import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasteofbandung/app_wrapper.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: "Taste of Bandung",
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const AppWrapper()
    );
  }
}