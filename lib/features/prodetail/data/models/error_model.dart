import 'dart:convert';
import 'package:http/http.dart' as http;
class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  factory ApiException.fromResponse(http.Response response) {
    try {
      final data = json.decode(response.body);
      if (data['error'] != null) {
        return ApiException(data['error']);
      } else {
        return ApiException('Unknown error occurred');
      }
    } catch (_) {
      return ApiException('Failed to parse error response');
    }
  }

  @override
  String toString() => message;
}
