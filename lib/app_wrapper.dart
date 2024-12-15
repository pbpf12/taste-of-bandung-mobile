import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasteofbandung/core/bases/widgets/_widgets.dart';
import 'package:tasteofbandung/features/authentication/screens/login.dart';
import 'package:tasteofbandung/main_screen.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import 'core/environments/_environments.dart';

class AppWrapper extends StatefulWidget {
  const AppWrapper({super.key});

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  Widget? screen;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final request = context.read<CookieRequest>();
    await request.init();

    try {
      final storedCredentials = request.local.getString('user_credentials');
      if (storedCredentials != null) {
        final credentials = jsonDecode(storedCredentials);

        await request.login(
          "http://${EndPoints().myBaseUrl}/auth/login/",
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
        screen = const LoginPage();
      }
    } catch (e) {
      screen = const LoginPage();
    }

    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (screen == null) {
      return const LoadingAppSkeleton();
    }

    return screen!;
  }
}
