part of '_datasources.dart';

abstract class SearchRemoteDataSource {
  Future<Either<Exception, Map<String,dynamic>>> getDishes(int page);
}
