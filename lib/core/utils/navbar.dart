part of '_utils.dart';

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
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20)
        ),
        border: Border(
          top: BorderSide(color: Colors.white)
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          features.length, (index) {
            final feature = features[index];
            return Expanded(
              child: InkWell(
                borderRadius: 
                  index == 0 || index == features.length - 1
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)
                      )
                    : BorderRadius.circular(0),
                onTap: () => onTap(feature),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      feature.icon,
                      shadows: List.generate(2, (index) {
                        if (feature == selectedFeauture) {
                          return const Shadow(
                            offset: Offset(1, 1),
                            color: Colors.white,
                            blurRadius: 50
                          );
                        }
                        return const Shadow();
                      })
                    ),
                    Text(
                      feature.text,
                      style: const TextStyle(fontSize: 10),
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

