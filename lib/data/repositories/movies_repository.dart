import 'package:dio/dio.dart';
import 'package:movies_app/data/models/movies/movies_model.dart';

class MoviesRepository {
  final Dio dio;

  MoviesRepository(this.dio);

  Future<List<MoviesModel>> getMovies() async {
    return _fetchMovies();
  }

  Future<List<MoviesModel>> searchMovies(String query) async {
    return _fetchMovies(query: query);
  }
  Future<List<MoviesModel>> _fetchMovies({String? query}) async {
    try {
      final response = await dio.get(
        "https://yts.mx/api/v2/list_movies.json",
        queryParameters: {
          if (query != null && query.isNotEmpty) "query_term": query,
        },
      );

      final data = response.data?["data"];
      final moviesJson = data?["movies"];

      if (moviesJson == null) return [];

      return (moviesJson as List)
          .map((movie) => MoviesModel.fromJson(movie))
          .toList();
    } catch (e) {
      throw Exception("Failed to load movies: $e");
    }
  }
}