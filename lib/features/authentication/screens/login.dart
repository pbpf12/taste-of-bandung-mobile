import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:tasteofbandung/main_screen.dart';
import '../../../core/bases/widgets/_widgets.dart';
import '../../../core/environments/_environments.dart';
import '../../../core/themes/color/theme.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: themeProvider.isDarkMode
              ? [Colors.brown.shade400, Colors.brown.shade900]
              : [Colors.yellow.shade100, Colors.orange.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight, 
          )
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              color: themeProvider.isDarkMode
                ? Colors.brown.shade200
                : Colors.amber.shade50,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.isDarkMode
                          ? Colors.brown.shade800
                          : Colors.brown.shade300
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    TextField(
                      controller: _usernameController,
                      cursorColor: themeProvider.isDarkMode
                          ? Colors.brown.shade800
                          : Colors.brown.shade300,
                      style: TextStyle(
                        color: themeProvider.isDarkMode
                          ? Colors.grey.shade200 : Colors.brown.shade900,
                        fontWeight: FontWeight.bold
                      ),
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(
                          color: Colors.brown.shade500
                        ),
                        hintText: 'Enter your username',
                        hintStyle: TextStyle(
                          color: themeProvider.isDarkMode
                            ? Colors.grey.shade300 : null
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(color: themeProvider.isDarkMode
                            ? Colors.grey.shade700 : Colors.grey.shade500)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(
                            color: themeProvider.isDarkMode
                              ? Colors.brown.shade500 : Colors.brown.shade200, width: 2)
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                        floatingLabelBehavior: FloatingLabelBehavior.always
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    TextField(
                      controller: _passwordController,
                      cursorColor: themeProvider.isDarkMode
                          ? Colors.brown.shade800
                          : Colors.brown.shade300,
                      style: TextStyle(
                        color: themeProvider.isDarkMode
                          ? Colors.grey.shade200 : Colors.brown.shade900,
                        fontWeight: FontWeight.bold
                      ),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: Colors.brown.shade500
                        ),
                        hintStyle: TextStyle(
                          color: themeProvider.isDarkMode
                            ? Colors.grey.shade300 : null
                        ),
                        hintText: 'Enter your password',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(color: themeProvider.isDarkMode
                            ? Colors.grey.shade700 : Colors.grey.shade500)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(
                            color: themeProvider.isDarkMode
                              ? Colors.brown.shade500 : Colors.brown.shade200, width: 2)
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                        floatingLabelBehavior: FloatingLabelBehavior.always
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: () async {
                        String username = _usernameController.text;
                        String password = _passwordController.text;
        
                        final response = await request.login(
                          "http://${EndPoints().myBaseUrl}/auth/login/",
                          {
                            'username': username,
                            'password': password,
                          },
                        );
        
                        if (request.loggedIn) {
                          // Simpan username dan password ke SharedPreferences
                          final credentials = jsonEncode({'username': username, 'password': password});
                          await request.local.setString('user_credentials', credentials);
        
                          // Ambil pesan dari response dan arahkan ke MainScreen
                          String message = response['message'];
                          String uname = response['username'];
                          if (context.mounted) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const MainScreen()),
                            );
                            SuccessMessenger("$message Selamat datang, $uname.").show(context);
                          }
                        } else {
                          // Tampilkan dialog jika login gagal
                          if (context.mounted) {
                            ErrorMessenger(response['message']).show(context);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: themeProvider.isDarkMode
                            ? Colors.brown.shade900 : Colors.brown,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: themeProvider.isDarkMode
                            ? null : Colors.amber.shade50
                        ),
                      ),
                    ),
                    const SizedBox(height: 36.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()),
                        );
                      },
                      child: Text(
                        'Don\'t have an account? Register',
                        style: TextStyle(
                          color: themeProvider.isDarkMode
                            ? Colors.brown.shade500 : Colors.brown.shade300,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}