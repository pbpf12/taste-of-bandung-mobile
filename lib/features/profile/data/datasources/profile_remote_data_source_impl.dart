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
          await request.get("http://${EndPoints().myBaseUrl}/show_json");
      print(response);

      final UserModel user = UserModel.fromJson(response['data']);
      print(user);
      return Right(user);
    } catch (e) {
      throw Left(Exception('Error: $e'));
    }
  }
}
