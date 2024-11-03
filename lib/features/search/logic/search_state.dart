part of '_logic.dart';

class SearchState extends Equatable {
  final bool isLoading;
  final bool isLoaded;
  final bool isError;
  final bool isOffline;
  final List<DishModel> dishes;
  final int page;
  final int minPage;
  final int maxPage;

  const SearchState({
    this.isLoading = true,
    this.isLoaded = false,
    this.isError = false,
    this.isOffline = false,
    this.dishes = const [],
    this.page = 1,
    this.minPage = 1,
    this.maxPage = 1,
  });

  SearchState copyWith({
    bool? isLoading,
    bool? isLoaded,
    bool? isError,
    bool? isOffline,
    List<DishModel>? dishes,
    int? page,
    int? minPage,
    int? maxPage,
  }) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      isLoaded: isLoaded ?? this.isLoaded,
      isError: isError ?? this.isError,
      isOffline: isOffline ?? this.isOffline,
      dishes: dishes ?? this.dishes,
      page: page ?? this.page,
      minPage: minPage ?? this.minPage,
      maxPage: maxPage ?? this.maxPage,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isLoaded,
        isError,
        isOffline,
        dishes,
        page,
        minPage,
        maxPage,
      ];
}
