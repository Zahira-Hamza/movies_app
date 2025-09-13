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
// features/movie_details/data/datasources/movie_api_service.dart
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../models/movies/movie_details_model.dart';
import '../models/movies/movie_model.dart';
import '../models/movies/movie_suggestions_response.dart';

part 'movie_api_service.g.dart';

/// واجهة API للفيلم باستخدام Retrofit
@RestApi(baseUrl: ApiEndpoints.baseUrl)
abstract class MovieApiService {
  factory MovieApiService(Dio dio, {String baseUrl}) = _MovieApiService;

  /// الحصول على تفاصيل الفيلم
  @GET(ApiEndpoints.movieDetails)
  Future<MovieDetailsResponse> getMovieDetails(
    @Query('movie_id') int movieId,
    @Query('with_images') bool withImages,
    @Query('with_cast') bool withCast,
  );

  /// الحصول على أفلام مشابهة
  @GET(ApiEndpoints.movieSuggestions)
  Future<MovieSuggestionsResponse> getMovieSuggestions(
    @Query('movie_id') int movieId,
  );
}
