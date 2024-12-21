part of '_pages.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchCubit _searchCubit;

  @override
  void initState() {
    super.initState();
    _searchCubit = get.get<SearchCubit>();
    retrieveData();
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

  void openFilterDialog() async {
    final result = await showDialog<FilterQuery>(
      context: context,
      builder: (context) {
        return BlocBuilder<SearchCubit, SearchState>(
          bloc: _searchCubit,
          builder: (context, state) {
            return FilterDialog(
              query: FilterQuery(
                category: state.category,
                sortBy: state.sortBy,
                priceMin: state.priceMin,
                priceMax: state.priceMax,
              ),
            );
          },
        );
      },
    );
    if (result != null) {
      setCategory(result.category); setSortBy(result.sortBy);
      setPriceMin(result.priceMin); setPriceMax(result.priceMax);
      retrieveData();
    }
  }
  
  void goToDetailScreen(int dishId) => Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ProdetailScreen(dishId: dishId,)));

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return BlocSelector<SearchCubit, SearchState, ScrollController>(
      bloc: _searchCubit,
      selector: (state) => state.scrollController,
      builder: (context, scrollController) {
        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: themeProvider.isDarkMode
                  ? [Colors.brown.shade700, Colors.brown.shade900]
                  : [Colors.orange.shade300, Colors.yellow.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
            child: RefreshIndicator(
              onRefresh: () => retrieveData(),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    SearchHeader(
                      children: [
                        const SearchTitleText(
                          text: 'Jelajahi Rasa Autentik Bandung'),
                        SearchFilterBar(
                          onChanged: setName,
                          onTap: openFilterDialog
                        ),
                      ]
                    ),
                    BlocBuilder<SearchCubit, SearchState>(
                      bloc: _searchCubit,
                      builder: (context, state) {
                        if (state.dishes.isEmpty) {
                          if (state.isLoading) {
                            return const DishViewSkeleton();
                          } else if (state.isError) {
                            return const ErrorWarningSection();
                          }

                          return const EmptyDataSection();
                        } else {
                          return Column(
                            children: [
                              DishView(
                                dishCardWidgets: state.dishes.map(
                                  (dish) => DishCard(
                                    onTap: goToDetailScreen, 
                                    dish: dish
                                  )
                                ).toList()
                              ),
                              if (state.isLoading)
                                const DishViewSkeleton()
                              else if (state.isError)
                                const ErrorWarningSection()
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
