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
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            themeProvider.isDarkMode
              ? Colors.brown.shade300.withOpacity(0.25) : Colors.orange.shade300.withOpacity(0.25),
            BlendMode.srcOver, 
          ),
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
              children: List.generate(
                children.length, (index) {
                  final child = children[index];
                  return Column(
                    children: [
                      if (index != 0)
                        const SizedBox(height: 20,),
                      child,
                    ],
                  );
              })
            ),
          ],
        ),
      ),
    );
  }
}