part of '_widgets.dart';

class DishCard extends StatelessWidget {
  final DishModel dish;
  final void Function(int dishId)? onTap;
  const DishCard({
    required this.onTap,
    required this.dish,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return InkWell(
      onTap: () => onTap!(dish.id),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: themeProvider.isDarkMode
              ? Colors.grey.shade900 : Colors.white
          )
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl: dish.imageUrl,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.low,
                 
                  errorWidget: (context, url, error) => const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline_sharp),
                      Text(
                        'Fail to Load this Image',
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        themeProvider.isDarkMode
                          ? Colors.black.withOpacity(0.8) : Colors.grey.shade700,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.5, 2]
                    )
                  ),
                )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children : [
                    Text(
                      dish.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Rp. ${dish.price.toString().split('.').first.replaceAllMapped(
                        RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
                        (match) => '${match.group(1)}.'
                      )}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: List.generate(5, (index) {
                        return const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 14,
                        );
                      }),
                      
                    )
                  ]
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}