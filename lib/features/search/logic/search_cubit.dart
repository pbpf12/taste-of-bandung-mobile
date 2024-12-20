part of '_logic.dart';

@injectable
class SearchCubit extends Cubit<SearchState>{
  final SearchRemoteDataSource _remoteDataSource;

  SearchCubit(
    this._remoteDataSource
  ) : super(SearchState(scrollController: ScrollController())) {
    state.scrollController.addListener(onScrollChange);
  }

  Future<void> onScrollChange() async {
    if (_isBottom && !_isMaxPage) {
      setCurrentPage(state.currentPage + 1);
      retrieveMoreData();
    }
  }

  void setApiRequestStatus(String status) async {
    if (kDebugMode) {
      print('Current API Request Status : $status');
    }

    emit(
      state.copyWith(
        isLoading: status == 'LOADING',
        isLoaded: status == 'LOADED',
        isError: status == 'ERROR',
      ),
    );
  }
  void setInitialDishes(List<DishModel> newDishes)
    => emit(state.copyWith(dishes: newDishes));
  void setMoreDishes(List<DishModel> newDishes) 
    => emit(state.copyWith(dishes: [...state.dishes, ...newDishes],));
  void setName(String newName) {
    emit(state.copyWith(name: newName));
    Timer(const Duration(milliseconds: 2000), () => retrieveData());
  }
  void setCategory(String newCategory)
    => emit(state.copyWith(category: newCategory));
  void setCurrentPage(int newCurrentPage)
    => emit(state.copyWith(currentPage: newCurrentPage));
  void setMinPage(int newMinPage) 
    => emit(state.copyWith(minPage: newMinPage));
  void setMaxPage(int newMaxPage) 
    => emit(state.copyWith(maxPage: newMaxPage));
  void setPriceMin(String newPriceMin) 
    => emit(state.copyWith(priceMin: newPriceMin));
  void setPriceMax(String newPriceMax) 
    => emit(state.copyWith(priceMax: newPriceMax));
  void setSortBy(String newSortBy) 
    => emit(state.copyWith(sortBy: newSortBy));
  

  Future<void> retrieveData() async {
    try {
      setApiRequestStatus('LOADING');
      
      final previousDishes = state.dishes;
      setInitialDishes([]);

      setCurrentPage(1);
      final resp = await _remoteDataSource.retrieveByGetDishes(
        state.name,
        state.currentPage.toString(), 
        state.category, 
        state.priceMin, 
        state.priceMax, 
        state.sortBy
      );

      await resp.fold((failure) async {
        setApiRequestStatus('ERROR');
        if (previousDishes.isNotEmpty) setInitialDishes(previousDishes);
      }, (success) async {
        setApiRequestStatus('LOADED');
        final data = success;
        setInitialDishes(data["dishes"] as List<DishModel>);
        setMinPage(data["min_page"] as int);
        setMaxPage(data["max_page"] as int);
      });
    } catch (e) {
      setApiRequestStatus('ERROR');
    }
  }

  Future<void> retrieveMoreData() async {
    try {
      setApiRequestStatus('LOADING');
      final resp = await _remoteDataSource.retrieveByPostDishes(
        state.name,
        state.currentPage.toString(), 
        state.category, 
        state.priceMin, 
        state.priceMax, 
        state.sortBy
      );

      await resp.fold((failure) async {
        setApiRequestStatus('ERROR');
      }, (success) async {
        setApiRequestStatus('LOADED');
        final data = success;
        setMoreDishes(data["dishes"] as List<DishModel>);
        setMinPage(data["min_page"] as int);
        setMaxPage(data["max_page"] as int);
      });
    } catch (e) {
      setApiRequestStatus('ERROR');
    }
  }

  bool get _isBottom {
    final maxScroll = state.scrollController.position.maxScrollExtent;
    final currentScroll = state.scrollController.offset;
    return currentScroll >= (maxScroll * 0.95);
  }

  bool get _isMaxPage {
    return state.maxPage == state.currentPage;
  }
}