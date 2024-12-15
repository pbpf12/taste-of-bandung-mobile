import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tasteofbandung/app_wrapper.dart';
import 'package:tasteofbandung/core/themes/color/theme.dart';

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
      theme: Provider.of<ThemeProvider>(context).themeData
        .copyWith(
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
      debugShowCheckedModeBanner: false,
      home: const AppWrapper(),
    );
  }
}
