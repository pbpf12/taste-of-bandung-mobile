part of '_logic.dart';

class SearchState extends Equatable {
  final bool isLoading;
  final bool isLoaded;
  final bool isError;
  final bool isOffline;
  final List<DishModel> dishes;
  final int currentPage;
  final String name;
  final String category;
  final String priceMin;
  final String priceMax;
  final String sortBy;
  final int minPage;
  final int maxPage;
  final ScrollController scrollController;

  SearchState({
    this.isLoading = true,
    this.isLoaded = false,
    this.isError = false,
    this.isOffline = false,
    this.dishes = const [],
    this.currentPage = 1,
    this.name = "",
    this.category = "",
    this.priceMin = "",
    this.priceMax = "",
    this.sortBy = "",
    this.minPage = 1,
    this.maxPage = 1,
    ScrollController? scrollController,
  }) : scrollController = scrollController ?? ScrollController();

  SearchState copyWith({
    bool? isLoading,
    bool? isLoaded,
    bool? isError,
    bool? isOffline,
    List<DishModel>? dishes,
    int? currentPage,
    String? name,
    String? category,
    String? priceMin,
    String? priceMax,
    String? sortBy,
    int? minPage,
    int? maxPage,
    ScrollController? scrollController,
  }) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      isLoaded: isLoaded ?? this.isLoaded,
      isError: isError ?? this.isError,
      isOffline: isOffline ?? this.isOffline,
      dishes: dishes ?? this.dishes,
      currentPage: currentPage ?? this.currentPage,
      name: name ?? this.name,
      category: category ?? this.category,
      priceMin: priceMin ?? this.priceMin,
      priceMax: priceMax ?? this.priceMax,
      sortBy: sortBy ?? this.sortBy,
      minPage: minPage ?? this.minPage,
      maxPage: maxPage ?? this.maxPage,
      scrollController: scrollController ?? this.scrollController,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isLoaded,
        isError,
        isOffline,
        dishes,
        currentPage,
        name,
        category,
        priceMin,
        priceMax,
        sortBy,
        minPage,
        maxPage,
        scrollController,
      ];
}
