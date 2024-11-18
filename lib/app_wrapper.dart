import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasteofbandung/features/authentication/screens/login.dart';
import 'package:tasteofbandung/main_screen.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class AppWrapper extends StatefulWidget {
  const AppWrapper({super.key});

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  Widget? screen; // Ubah menjadi nullable untuk menandakan belum terisi.

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final request = context.read<CookieRequest>();
    await request.init(); // Pastikan SharedPreferences diinisialisasi

    try {
      // Ambil username dan password dari local storage
      final storedCredentials = request.local.getString('user_credentials');
      if (storedCredentials != null) {
        final credentials = jsonDecode(storedCredentials);

        final response = await request.login(
          "http://10.0.2.2:8000/auth/login/",
          {
            'username': credentials['username'],
            'password': credentials['password'],
          },
        );

        if (request.loggedIn) {
          screen = const MainScreen();
        } else {
          screen = const LoginPage();
        }
      } else {
        // Jika tidak ada credentials di local storage
        screen = const LoginPage();
      }
    } catch (e) {
      // Handle error
      screen = const LoginPage();
    }

    // Refresh UI setelah selesai proses async
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Tampilkan spinner jika `screen` belum diinisialisasi
    if (screen == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Tampilkan screen yang sesuai setelah inisialisasi selesai
    return screen!;
  }
}
