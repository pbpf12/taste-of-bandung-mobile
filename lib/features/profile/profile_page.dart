import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../../core/bases/widgets/_widgets.dart';
import '../../core/environments/_environments.dart';
import '../../core/themes/color/theme.dart';
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
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: Column(
        children: [
          // Nitip yaa Lex ^w^ Kalo mau ubah buttonnya, 
          // jangan sampe logic onPressed dan onChanged nya keubah
          ElevatedButton(
            onPressed: () async {
              final response = await request.logout(
                "http://${EndPoints().myBaseUrl}/auth/logout/",
              );
              String message = response["message"];
              if (context.mounted) {
                if (response['status']) {
                  // Hapus credentials dari SharedPreferences
                  await request.local.remove('user_credentials');

                  String uname = response["username"];
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                  SuccessMessenger("$message Sampai jumpa, $uname.").show(context);
                } else {
                  ErrorMessenger(message).show(context);
                }
              }
            },
            child: const Text('Logout'),
          ),
          CupertinoSwitch(
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
    );
  }
}
