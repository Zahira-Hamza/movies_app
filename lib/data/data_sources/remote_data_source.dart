import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/core/constants/api_constants.dart';
import 'package:movies_app/data/models/movies/movie.dart';

class RemoteDataSource {
  Future<List<Movie>> fetchMovies({
    int page = 1,
    int limit = 20,
    String? quality,
    String? queryTerm,
    String? genre,
    String orderBy = "desc",
    String sortBy = "year",
    bool? withRtRatings,
  }) async {
    final uri = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.listMovies}");
    final Map<String, dynamic> queryParameters = {
      'page_number': page.toString(),
      'limit': limit.toString(),
      'order_by': orderBy,
      'sort_by': sortBy,
    };

    if (quality != null) queryParameters['quality'] = quality;
    if (queryTerm != null) queryParameters['query_term'] = queryTerm;
    if (genre != null) queryParameters['genre'] = genre;
    if (withRtRatings != null) {
      queryParameters['with_rt_ratings'] = withRtRatings.toString();
    }

    final url = uri.replace(queryParameters: queryParameters);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final data = body["data"];
      final List results = data["movies"] ?? [];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load movies. Status code: ${response.statusCode}");
    }
  }

}
