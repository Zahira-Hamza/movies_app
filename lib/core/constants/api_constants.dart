import 'dart:convert';
import 'package:http/http.dart' as http;
class ApiConstants {
  static const String baseUrl = 'https://yts.mx/api/';
  static const String listMovies = 'v2/list_movies.json';
}
class YtsApi {
  String _buildUrl({
    int? limit,
    int? page,
    String? quality,
    int? minimumRating,
    String? queryTerm,
    String? genre,
    String orderBy = "desc",
    String sortBy = "year",
    bool? withRtRatings,
  }) {
    final uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.listMovies);
    final Map<String, dynamic> queryParameters = {
      'sort_by': sortBy,
      'order_by': orderBy,
    };

    if (limit != null) queryParameters['limit'] = limit.toString();
    if (page != null) queryParameters['page'] = page.toString();
    if (quality != null) queryParameters['quality'] = quality;
    if (minimumRating != null) {
      queryParameters['minimum_rating'] = minimumRating.toString();
    }
    if (queryTerm != null) queryParameters['query_term'] = queryTerm;
    if (genre != null) queryParameters['genre'] = genre;
    if (withRtRatings != null) {
      queryParameters['with_rt_ratings'] = withRtRatings.toString();
    }

    return uri.replace(queryParameters: queryParameters).toString();
  }
}