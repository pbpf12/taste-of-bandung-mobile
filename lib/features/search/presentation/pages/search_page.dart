part of '_pages.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchCubit _searchCubit;
  late ThemeProvider _themeProvider;

  @override
  void initState() {
    super.initState();
    _searchCubit = get.get<SearchCubit>();
    retrieveData();
  }

  int getCrossAxisCount(double width) {
    if (width >= 1280) {
      return 5;
    } else if (width >= 1024) {
      return 4;
    } else if (width >= 768) {
      return 3;
    } else {
      return 2;
    }
  }

  @override
  void dispose() {
    _searchCubit.close();
    super.dispose();
  }

  void setName(String newName) => _searchCubit.setName(newName);
  void setCategory(String newCategory) => _searchCubit.setCategory(newCategory);
  void setMinPage(int newMinPage) => _searchCubit.setMinPage(newMinPage);
  void setMaxPage(int newMaxPage) => _searchCubit.setMaxPage(newMaxPage);
  void setPriceMin(String newPriceMin) => _searchCubit.setPriceMin(newPriceMin);
  void setPriceMax(String newPriceMax) => _searchCubit.setPriceMax(newPriceMax);
  void setSortBy(String newSortBy) => _searchCubit.setSortBy(newSortBy);
  Future<void> retrieveData() async => _searchCubit.retrieveData();
  Future<void> retrieveMoreData() async => _searchCubit.retrieveMoreData();

  @override
  Widget build(BuildContext context) {
    _themeProvider = Provider.of<ThemeProvider>(context);

    return BlocSelector<SearchCubit, SearchState, ScrollController>(
      bloc: _searchCubit,
      selector: (state) => state.scrollController,
      builder: (context, scrollController) {
        return SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              setName("");
              retrieveData();
            },
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          _themeProvider.isDarkMode
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
                          const Column(
                            children: [
                              SizedBox(height: 10,),
                              Text(
                                'Jelajahi Rasa Autentik Bandung',
                                style: TextStyle(
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 50,
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.search,
                                      color: Colors.grey.shade700,
                                      size: 30,
                                    ),
                                    const SizedBox(width: 10,),
                                    Expanded( // Add this to avoid layout issues with the TextField
                                      child: TextField(
                                        onChanged: (value) => setName(value),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Search Products',
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {

                                      },
                                      child: Icon(
                                        Icons.filter_alt_rounded,
                                        color: Colors.grey.shade700,
                                        size: 25,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  BlocBuilder<SearchCubit, SearchState>(
                    bloc: _searchCubit,
                    builder: (context, state) {
                      if (state.dishes.isEmpty) {
                        if (state.isLoading) {
                          return _buildLoading();
                        } else if (state.isError) {
                          return _buildErrorWarning();
                        }
          
                        return _buildNoData();
                      } else {
                        return Column(
                          children: [
                            _buildDishes(state.dishes),
                            if (state.isLoading) 
                              const CircularProgressIndicator()
                            else if (state.isError)
                              _buildErrorWarning()
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDishes(List<DishModel> dishes) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _themeProvider.isDarkMode
            ? [Colors.brown.shade400, Colors.brown.shade900]
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
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: getCrossAxisCount(MediaQuery.of(context).size.width),
            crossAxisSpacing: 10,
            mainAxisSpacing: 20,
            childAspectRatio: 1.2,
          ),
          children: dishes.map( (dish) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProdetailScreen(dihsId: dish.id)
                  )
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          filterQuality: FilterQuality.low,
                          dish.imageUrl,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.error_outline_sharp),
                                Text(
                                  'Fail to Load this Image',
                                )
                              ],
                            );
                          },
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.black
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.5, 2]
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
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Rp. ${dish.price.toString().split('.').first.replaceAllMapped(
                                RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
                                (match) => '${match.group(1)}.'
                              )}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: List.generate(5, (index) {
                                return Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 17.5,
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
          }).toList(),
        ),
      )
    );
  }

  Widget _buildLoading() {
    return const CircularProgressIndicator();
  }

  Widget _buildErrorWarning() {
    return const Column(
      children: [
        SizedBox(
          height: 150,
        ),
        Text(
          'Fail to get data',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildNoData() {
    return const Column(
      children: [
        SizedBox(
          height: 150,
        ),
        Text(
          'There is no Data',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
