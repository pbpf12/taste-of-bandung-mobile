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

  void showFilterDialog() 
    => showDialog(context: context, builder: (context) 
      => const FilterDialog());
  void goToDetailScreen(int dishId) 
    => Navigator.of(context).push(MaterialPageRoute(builder: (context) 
      => ProdetailScreen(dishId: dishId)));

  @override
  Widget build(BuildContext context) {

    return BlocSelector<SearchCubit, SearchState, ScrollController>(
      bloc: _searchCubit,
      selector: (state) => state.scrollController,
      builder: (context, scrollController) {
        return SafeArea(
          child: RefreshIndicator(
            onRefresh: () => retrieveData(),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  SearchHeader(
                    children: [
                      SearchFilterBar(
                        onChanged: setName,
                        onTap: showFilterDialog,
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
                                  onTap: goToDetailScreen, dish: dish) 
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
        );
      },
    );
  }
}
