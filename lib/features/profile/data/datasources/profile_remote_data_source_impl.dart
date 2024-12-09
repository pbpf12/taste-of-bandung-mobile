part of '_datasources.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourcesImplementation
    implements ProfileRemoteDataSource {
  final baseUrl = EndPoints().myBaseUrl;
  final paths = EndPoints().profilePaths;

  @override
  Future<Either<Exception, List<HistoryModel>>> getHistory() async {
    try {
      final uri = Uri.http(baseUrl, paths.getHistory);

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        final List<HistoryModel> history = (jsonResponse['data'] as List)
            .map((item) => HistoryModel.fromJson(item))
            .toList();

        return Right(history);
      } else {
        throw Left(Exception('Failed to load history'));
      }
    } catch (e) {
      throw Left(Exception('Error: $e'));
    }
  }

  @override
  Future<Either<Exception, UserModel>> getUserData(BuildContext context) async {
    try {
      final request = context.watch<CookieRequest>();
      final response = await request.get("http://${EndPoints().myBaseUrl}/auth/login/");

      if (response['status'] == 'success') {
        final UserModel user = UserModel.fromJson(response['data']);
        return Right(user);
      } else {
        throw Left(Exception('Failed to load user data'));
      }
    } catch (e) {
      throw Left(Exception('Error: $e'));
    }
  }
}
