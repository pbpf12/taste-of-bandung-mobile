part of '_datasources.dart';

abstract class SearchRemoteDataSource {
  Future<Either<Exception, Map<String,dynamic>>> retrieveByGetDishes(
    String name,
    String page,
    String category,
    String priceMin,
    String priceMax,
    String sortBy,
  );

  Future<Either<Exception, Map<String,dynamic>>> retrieveByPostDishes(
    String name,
    String page,
    String category,
    String priceMin,
    String priceMax,
    String sortBy,
  );
}
