part of '_logic.dart';

@injectable
class SearchCubit extends Cubit<SearchState>{
  final SearchRemoteDataSource _remoteDataSource;

  SearchCubit(
    this._remoteDataSource
  ) : super(const SearchState());

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
  void setDishes(List<DishModel> newDishes) {
    emit(state.copyWith(dishes: newDishes));
  }
  void setMinPage(int newMinPage) {
    emit(state.copyWith(minPage: newMinPage));
  }
  void setMaxPage(int newMaxPage) {
    emit(state.copyWith(maxPage: newMaxPage));
  }

  Future<void> retrieveData() async {
    try {
      setApiRequestStatus('LOADING');
      final resp = await _remoteDataSource.getDishes(state.page);

      await resp.fold((failure) async {
        setApiRequestStatus('ERROR');
      }, (success) async {
        setApiRequestStatus('LOADED');
        final data = success;
        setDishes(data["dishes"] as List<DishModel>);
        setMinPage(data["min_page"] as int);
        setMaxPage(data["max_page"] as int);
      });
    } catch (e) {
      setApiRequestStatus('ERROR');
    }
  }


}