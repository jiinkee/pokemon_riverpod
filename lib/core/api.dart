import 'package:dio/dio.dart';
import 'package:pokemon_riverpod/core/api_routes.dart';

class Api {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiRoutes.domain(),
  ));

  // GET
  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParam}) async {
    return await _dio.get(endpoint, queryParameters: queryParam);
  }
}
