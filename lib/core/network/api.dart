import 'package:dio/dio.dart';
import 'package:pokemon_riverpod/core/network/api_routes.dart';

class Api {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiRoutes.domain(),
  ));
  final Dio _simpleDio = Dio();

  // GET
  Future<Response?> get({
    String? endpoint,
    String? completeUrl,
    Map<String, dynamic>? queryParam,
  }) async {
    if (endpoint != null) {
      return await _dio.get(endpoint, queryParameters: queryParam);
    }
    if (completeUrl != null) {
      return await _simpleDio.get(completeUrl);
    }
    return null;
  }

  void close() {
    _dio.close();
    _simpleDio.close();
  }
}
