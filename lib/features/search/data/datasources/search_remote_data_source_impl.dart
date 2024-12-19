part of '_datasources.dart';

@Injectable(as: SearchRemoteDataSource)
class SearchRemoteDataSourcesImplementation implements SearchRemoteDataSource {
  final baseUrl = EndPoints().myBaseUrl;
  final paths = EndPoints().searchPaths;

  @override
  Future<Either<Exception, Map<String,dynamic>>> retrieveByGetDishes(
    String name,
    String page,
    String category,
    String priceMin,
    String priceMax,
    String sortBy,
  ) async {
    List<DishModel> dishes = [];

    try {
      final uri = Uri.http(baseUrl, paths.getDishes, {
        "name" : name,
        "page": page,
        "category" : category,
        "price_min" : priceMin,
        "price_max" : priceMax,
        "sort_by" : sortBy,
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

  @override
  Future<Either<Exception, Map<String, dynamic>>> retrieveByPostDishes(
    String name,
    String page,
    String category,
    String priceMin,
    String priceMax,
    String sortBy,
  ) async {
    List<DishModel> dishes = [];

    try {
      final uri = Uri.http(baseUrl, paths.getDishes);

      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          "name" : name,
          "page": page,
          "category": category,
          "price_min": priceMin,
          "price_max": priceMax,
          "sort_by": sortBy,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        dishes = (jsonResponse['dishes'] as List)
            .map((json) => DishModel.fromJson(json))
            .toList();

        int minPage = jsonResponse['min_page'] as int;
        int maxPage = jsonResponse['max_page'] as int;

        Map<String, dynamic> data = {
          'dishes': dishes,
          'min_page': minPage,
          'max_page': maxPage,
        };

        return Right(data);
      } else {
        return Left(Exception('Failed to load dishes'));
      }
    } catch (e) {
      return Left(Exception('Error: $e'));
    }
  }
}