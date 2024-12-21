part of '_widgets.dart';

class SearchTitleText extends StatelessWidget {
  final String text;
  const SearchTitleText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Text(
      text,
      style: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.bold,
        color: themeProvider.isDarkMode
          ? Colors.grey : Colors.white,
        shadows: List.generate(1, (index) {
          return const Shadow(
            color: Colors.black,
            offset: Offset(1, 1),
            blurRadius: 10
          );
        })
      ),
    );
  }
}