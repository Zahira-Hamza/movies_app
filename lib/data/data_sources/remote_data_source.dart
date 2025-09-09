
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/constants/api_constants.dart';

class RemoteDataSource {  
  Future<List<Map<String, dynamic>>> fetchMovies({
    int? limit,
    int? page,
    String? quality,
    int? minimumRating,
    String? queryTerm,
    String? genre,
    String orderBy = "desc",
    String sortBy = "year",
    bool? withRtRatings,
  }) async {
    final uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.listMovies);

 final Map<String, String> queryParameters = {
      'sort_by': sortBy,
      'order_by': orderBy,
      if (limit != null) 'limit': limit.toString(),
      if (page != null) 'page': page.toString(),
      if (quality != null) 'quality': quality,
      if (minimumRating != null) 'minimum_rating': minimumRating.toString(),
      if (queryTerm != null) 'query_term': queryTerm,
      if (genre != null) 'genre': genre,
      if (withRtRatings != null) 'with_rt_ratings': withRtRatings.toString(),
    };

    final url = uri.replace(queryParameters: queryParameters).toString();
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final List movies = body['data']['movies'] ?? [];
      return movies.map((e) => e as Map<String, dynamic>).toList();
    } else {
      throw Exception("Failed to load movies.");
    }
  }
}