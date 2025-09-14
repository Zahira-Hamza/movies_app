// // features/movie_details/data/datasources/movie_api_service.dart
// import 'package:dio/dio.dart';
// import 'package:retrofit/retrofit.dart';
//
// import '../../../../core/constants/api_endpoints.dart';
// import '../models/movies/movie_details_model.dart';
// import '../models/movies/movie_model.dart';
//
// part 'movie_api_service.g.dart'; // سيتم توليد هذا الملف تلقائياً بواسطة Retrofit
//
// /// واجهة API للفيلم باستخدام Retrofit
// @RestApi(baseUrl: ApiEndpoints.baseUrl)
// abstract class MovieApiService {
//   factory MovieApiService(Dio dio, {String baseUrl}) = _MovieApiService;
//
//   /// الحصول على تفاصيل الفيلم
//   @GET(ApiEndpoints.movieDetails)
//   Future<MovieDetailsResponse> getMovieDetails(
//     @Query('movie_id') int movieId,
//     @Query('with_images') bool withImages,
//     @Query('with_cast') bool withCast,
//   );
//
//   /// الحصول على أفلام مشابهة
//   @GET(ApiEndpoints.movieSuggestions)
//   Future<List<MovieModel>> getMovieSuggestions(
//     @Query('movie_id') int movieId,
//   );
// }
import 'package:dio/dio.dart';
import 'package:movies_app/core/constants/api_endpoints.dart';
import 'package:movies_app/data/models/movies/movie_model.dart';

import '../models/movies/movie_details_model.dart';

class MovieApiService {
  final Dio dio;

  MovieApiService(this.dio);

  Future<MovieDetailsResponse> getMovieDetails(
    int movieId,
    bool withImages,
    bool withCast,
  ) async {
    try {
      final response = await dio.get(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.movieDetails}',
        queryParameters: {
          'movie_id': movieId,
          'with_images': withImages,
          'with_cast': withCast,
        },
      );

      return MovieDetailsResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load movie details: $e');
    }
  }

  Future<List<MovieModel>> getMovieSuggestions(int movieId) async {
    try {
      final response = await dio.get(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.movieSuggestions}',
        queryParameters: {'movie_id': movieId},
      );

      // افترض أن الرد بيكون List<MovieModel>
      final data = response.data as List;
      return data.map((json) => MovieModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load similar movies: $e');
    }
  }
}
