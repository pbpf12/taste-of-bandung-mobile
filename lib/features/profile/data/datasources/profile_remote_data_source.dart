part of '_datasources.dart';

abstract class ProfileRemoteDataSource {
  Future<Either<Exception, List<HistoryModel>>> getHistory();
  Future<Either<Exception, UserModel>> getUserData();
  Future<Either<Exception, UserModel>> updateUserData(data);
  Future<Either<Exception, List<HistoryModel>>> clearHistory();
  Future<Either<Exception, dynamic>> logout();
  Future<Either<Exception, dynamic>> deleteAccount();
}
