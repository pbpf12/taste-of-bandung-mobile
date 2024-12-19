part of '_widgets.dart';

class Features {
  Widget widget;
  IconData icon;
  String text;

  Features({
    required this.widget,
    required this.icon,
    required this.text
  });
}

class TobBottomNavigationBar extends StatelessWidget {
  const TobBottomNavigationBar({
    required this.features,
    required this.selectedFeauture,
    required this.onTap,
    super.key
  });

  final List<Features> features;
  final Features selectedFeauture;
  final void Function(Features newSelectedFeature) onTap;

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: themeProvider.isDarkMode
              ? Colors.white : Colors.black
          )
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          features.length, (index) {
            final feature = features[index];
            return Expanded(
              child: InkWell(
                onTap: () => onTap(feature),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      feature.icon,
                      shadows: List.generate(2, (index) {
                        if (feature == selectedFeauture) {
                          return Shadow(
                            offset: const Offset(1, 1),
                            color: themeProvider.isDarkMode
                              ? Colors.white : Colors.black,
                            blurRadius: 50
                          );
                        }
                        return const Shadow();
                      })
                    ),
                    Text(
                      feature.text,
                      style: TextStyle(
                        fontSize: 10,
                        color: themeProvider.isDarkMode
                          ? Colors.white : Colors.black
                      ),
                    )
                  ],
                ),
              ),
            );
        }),
      ),
    );
  }
}

