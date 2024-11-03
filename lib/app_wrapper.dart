import 'package:flutter/material.dart';
import 'package:tasteofbandung/main_screen.dart';

class AppWrapper extends StatefulWidget {
  const AppWrapper({super.key});

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {

  // Nanti bikin logic buat arahin ke
  // - Authentication Page
  // - Main Page

  @override
  Widget build(BuildContext context) {
    return const MainScreen();
  }
}