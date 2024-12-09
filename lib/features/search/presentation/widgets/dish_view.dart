part of '_widgets.dart';

class DishView extends StatelessWidget {
  final List<DishModel> dishes;
  final void Function(int id)? onTap;

  const DishView({
    required this.dishes,
    required this.onTap,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    ThemeProvider _themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _themeProvider.isDarkMode
            ? [Colors.brown.shade700, Colors.brown.shade900]
            : [Colors.yellow.shade100, Colors.orange.shade300],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight, 
        )
      ),
      child: Padding(
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
          children: dishes.map( (dish) {
            return DishCard(dish: dish, onTap: onTap,);
          }).toList(),
        ),
      )
    );
  }
}