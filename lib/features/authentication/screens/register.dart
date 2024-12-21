import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../../../core/bases/widgets/_widgets.dart';
import '../../../core/environments/_environments.dart';
import '../../../core/themes/color/theme.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: themeProvider.isDarkMode
              ? [Colors.brown.shade700, Colors.brown.shade900]
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
              color: themeProvider.isDarkMode
                ? Colors.brown.shade200
                : Colors.amber.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.isDarkMode
                          ? Colors.brown.shade800
                          : Colors.brown.shade300
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    TextFormField(
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
                        hintText: 'Enter your username',
                        labelStyle: TextStyle(
                          color: Colors.brown.shade500
                        ),
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12.0),
                    TextFormField(
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
                        hintText: 'Enter your password',
                        labelStyle: TextStyle(
                          color: Colors.brown.shade500
                        ),
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
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12.0),
                    TextFormField(
                      controller: _confirmPasswordController,
                      cursorColor: themeProvider.isDarkMode
                          ? Colors.brown.shade800
                          : Colors.brown.shade300,
                      style: TextStyle(
                        color: themeProvider.isDarkMode
                          ? Colors.grey.shade200 : Colors.brown.shade900,
                        fontWeight: FontWeight.bold
                      ),
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        hintText: 'Confirm your password',
                        labelStyle: TextStyle(
                          color: Colors.brown.shade500
                        ),
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
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: () async {
                        String username = _usernameController.text;
                        String password1 = _passwordController.text;
                        String password2 = _confirmPasswordController.text;
        
                        final response = await request.postJson(
                            "http://${EndPoints().myBaseUrl}/auth/register/",
                            jsonEncode({
                              "username": username,
                              "password1": password1,
                              "password2": password2,
                            }));
                        if (context.mounted) {
                          if (response['status'] == 'success') {
                            ErrorMessenger('Successfully registered!').show(context);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          } else {
                            ErrorMessenger("Failed to register!").show(context);
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
                        'Register',
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
                              builder: (context) => const LoginPage()),
                        );
                      },
                      child: Text(
                        'Already have an account? Login',
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