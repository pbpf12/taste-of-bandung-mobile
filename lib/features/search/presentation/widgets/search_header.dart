part of '_widgets.dart';

class SearchHeader extends StatelessWidget {
  final List<Widget> children;
  const SearchHeader({
    required this.children,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            themeProvider.isDarkMode
              ? Assets.image.bandungMalam : Assets.image.bandungSiang),
          fit: BoxFit.cover
        )
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const SizedBox(height: 10,),
                Text(
                  'Jelajahi Rasa Autentik Bandung',
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
                ),
              ],
            ),
            const SizedBox(height: 20,),
            Column(
              children: children,
            )
          ],
        ),
      ),
    );
  }
}