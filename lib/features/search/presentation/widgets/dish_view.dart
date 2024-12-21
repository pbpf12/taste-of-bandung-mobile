part of '_widgets.dart';

class DishView extends StatelessWidget {
  final List<DishCard> dishCardWidgets;

  const DishView({
    required this.dishCardWidgets,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20, vertical: 20),
      child: GridView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 10,),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 20,
          childAspectRatio: 1.2,
        ),
        children: dishCardWidgets,
      ),
    );
  }
}