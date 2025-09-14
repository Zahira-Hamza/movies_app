// // features/movie_details/data/repositories/movie_repository_impl.dart
// import '../../../../core/network/api_exceptions.dart';
// import '../data_sources/movie_api_service.dart';
// import '../models/movies/movie_model.dart'; // تأكد من أن هذا هو المسار الصحيح
//
// /// تطبيق الريبوزيتوري لتفاصيل الفيلم
// class MovieRepositoryImpl {
//   final MovieApiService movieApiService;
//
//   MovieRepositoryImpl({required this.movieApiService});
//
//   /// الحصول على تفاصيل الفيلم
//   Future<MovieModel> getMovieDetails(int movieId) async {
//     try {
//       final response = await movieApiService.getMovieDetails(
//         movieId,
//         true, // with_images
//         true, // with_cast
//       );
//
//       if (response.status != 'ok') {
//         throw ApiException(
//           message: response.statusMessage,
//           statusCode: 400,
//           errorCode: response.status,
//         );
//       }
//
//       return response.data.movie;
//     } on ApiException {
//       rethrow;
//     } catch (e) {
//       throw ApiException(message: 'Failed to load movie details: $e');
//     }
//   }
//
//   /// الحصول على أفلام مشابهة
//   Future<List<MovieModel>> getSimilarMovies(int movieId) async {
//     try {
//       final response = await movieApiService.getMovieSuggestions(movieId);
//
//       // الرد من getMovieSuggestions هو List<MovieModel> مباشرة
//       // كما يظهر في الكود المُنشأ لـ Retrofit
//       return response;
//     } on ApiException {
//       rethrow;
//     } catch (e) {
//       throw ApiException(message: 'Failed to load similar movies: $e');
//     }
//   }
// }
import 'package:movies_app/core/network/api_exceptions.dart';
import 'package:movies_app/data/models/movies/movie_model.dart';

import '../data_sources/movie_api_service.dart';

class MovieRepositoryImpl {
  final MovieApiService movieApiService;

  MovieRepositoryImpl({required this.movieApiService});

  Future<MovieModel> getMovieDetails(int movieId) async {
    try {
      final response = await movieApiService.getMovieDetails(
        movieId,
        true, // with_images
        true, // with_cast
      );

      print('API Response status: ${response.status}');
      print('API Response message: ${response.statusMessage}');

      if (response.status != 'ok') {
        throw ApiException(
          message: response.statusMessage,
          statusCode: 400,
          errorCode: response.status,
        );
      }

      if (response.data.movie == null) {
        throw ApiException(
          message: 'Movie data is null',
          statusCode: 404,
          errorCode: 'MOVIE_NOT_FOUND',
        );
      }

      return response.data.movie!;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: 'Failed to load movie details: $e');
    }
  }

  Future<List<MovieModel>> getSimilarMovies(int movieId) async {
    try {
      final response = await movieApiService.getMovieSuggestions(movieId);
      return response;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: 'Failed to load similar movies: $e');
    }
  }
}
