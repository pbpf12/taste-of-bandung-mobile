part of '_datasources.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourcesImplementation
    implements ProfileRemoteDataSource {
  final baseUrl = EndPoints().myBaseUrl;
  final paths = EndPoints().profilePaths;

  @override
  Future<Either<Exception, List<HistoryModel>>> getHistory() async {
    try {
      final request = CookieRequest();
      final response =
          await request.get("http://${EndPoints().myBaseUrl}/show_history/");

      final List<HistoryModel> history = (response['history'] as List)
          .map((item) => HistoryModel(
                dish: DishModel.fromJson(item['dish']),
                createdAt: DateTime.parse(item['created_at']),
              ))
          .toList();

      return Right(history);
    } catch (e) {
      throw Left(Exception('Failed to load history'));
    }
  }

  @override
  Future<Either<Exception, UserModel>> getUserData() async {
    try {
      final request = CookieRequest();
      final response =
          await request.get("http://${EndPoints().myBaseUrl}/show_json/");
      final user = UserModel.fromJson(response);

      return Right(user);
    } catch (e) {
      throw Left(Exception('Error: $e'));
    }
  }

  @override
  Future<Either<Exception, UserModel>> updateUserData(dynamic data) async {
    try {
      final request = CookieRequest();
      print(data);
      final response = await request.postJson(
          "http://${EndPoints().myBaseUrl}/edit_profile_flutter/",
          jsonEncode(data));
      final user = UserModel.fromJson(response);

      return Right(user);
    } catch (e) {
      print(e.toString());
      throw Left(Exception('Error: $e'));
    }
  }

  @override
  Future<Either<Exception, List<HistoryModel>>> clearHistory() async {
    try {
      final request = CookieRequest();
      final response =
          await request.get("http://${EndPoints().myBaseUrl}/clear_history/");

      final List<HistoryModel> history = (response['history'] as List)
          .map((item) => HistoryModel(
                dish: DishModel.fromJson(item['dish']),
                createdAt: DateTime.parse(item['created_at']),
              ))
          .toList();

      return Right(history);
    } catch (e) {
      throw Left(Exception('Error: $e'));
    }
  }
}
