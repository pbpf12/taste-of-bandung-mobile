import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../authentication/screens/login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return SafeArea(
      child: Column(
        children: [
          // Nitip yaa Lex ^w^ Kalo mau ubah buttonnya, jangan sampe logic onPressed nya keubah
          ElevatedButton(
            onPressed: () async {
              final response = await request.logout(
                "http://10.0.2.2:8000/auth/logout/",
              );
              String message = response["message"];
              if (context.mounted) {
                if (response['status']) {
                  // Hapus credentials dari SharedPreferences
                  await request.local.remove('user_credentials');

                  String uname = response["username"];
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("$message Sampai jumpa, $uname."),
                    ),
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                    ),
                  );
                }
              }
            },
            child: const Text('Logout'),
          )
        ],
      ),
    );
  }
}