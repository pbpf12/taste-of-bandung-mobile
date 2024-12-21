part of '_widgets.dart';

class ThemeToggler extends StatelessWidget {
  const ThemeToggler({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return CupertinoSwitch(
      value: themeProvider.isDarkMode,
      onChanged: (value) {
        themeProvider.toggleTheme();
      },
    );
  }
}