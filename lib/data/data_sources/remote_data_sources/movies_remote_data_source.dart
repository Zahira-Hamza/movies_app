import 'package:dio/dio.dart';
import 'package:movies_app/core/constants/errors/app_exception.dart';
import 'package:movies_app/data/models/movies/movies_model.dart';

class MoviesRemoteDataSource {
  final Dio _dio = Dio();

  Future<List<MoviesModel>> fetchMovies({
     int? page,
     int? limit,
     String? genre,
     String sortBy = "year",
     String orderBy = "desc",
  }) async {
    try {
      final response = await _dio.get(
        "https://yts.mx/api/v2/list_movies.json",
        queryParameters: {
          "page": page,
          "limit": limit,
          "genre": genre,
          "sort_by": sortBy,
          "order_by": orderBy,
        }..removeWhere((key, value) => value == null),
      );

      if (response.data["status"] != "ok") {
        throw ApiException("Failed to fetch movies");
      }

      final List moviesJson = response.data["data"]["movies"] ?? [];
      return moviesJson
          .map((m) => MoviesModel.fromJson(m as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ApiException(e.toString());
    }
  }
}
