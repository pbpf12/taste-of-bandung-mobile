part of '_datasources.dart';

abstract class ProfileRemoteDataSource {
  Future<Either<Exception, List<HistoryModel>>> getHistory();
  Future<Either<Exception, UserModel>> getUserData();
}