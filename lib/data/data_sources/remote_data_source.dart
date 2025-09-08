

import '../../core/constants/api_constants.dart';

class RemoteDataSource {
  final ApiConstants _api = ApiConstants();

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
    return await ApiConstants.fetchItems(
      limit: limit,
      page: page,
      quality: quality,
      minimumRating: minimumRating,
      queryTerm: queryTerm,
      genre: genre,
      orderBy: orderBy,
      sortBy: sortBy,
      withRtRatings: withRtRatings,
    );
  }
}
