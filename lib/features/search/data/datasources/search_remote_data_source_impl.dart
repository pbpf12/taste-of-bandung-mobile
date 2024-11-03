part of '_datasources.dart';

@Injectable(as: SearchRemoteDataSource)
class SearchRemoteDataSourcesImplementation implements SearchRemoteDataSource {
  final baseUrl = EndPoints().prodBaseUrl;
  final paths = EndPoints().searchPaths;

  @override
  Future<Either<Exception, Map<String,dynamic>>> getDishes(int page) async {
    List<DishModel> dishes = [];

    try {
      final uri = Uri.http(baseUrl, paths.getDishes, {
        "page": "1"
      });

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        dishes = (jsonResponse['dishes'] as List)
            .map((json) => DishModel.fromJson(json))
            .toList();
        
        int minPage = jsonResponse['min_page'] as int;
        int maxPage = jsonResponse['max_page'] as int;

        Map<String,dynamic> data = {
          'dishes': dishes,
          'min_page': minPage,
          'max_page': maxPage,
        };

        return Right(data);
      } else {
        throw Left(Exception('Failed to load dishes'));
      }
    } catch (e) {
      throw Left(Exception('Error: $e'));
    }
  }

}