// // features/movie_details/data/repositories/movie_repository_impl.dart
//
// import '../../../../core/network/api_exceptions.dart';
// import '../data_sources/movie_api_service.dart';
// import '../models/movies/movie_model.dart';
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
//       // معالجة البنية المختلفة للاستجابة
//       if (response is Map<String, dynamic>) {
//         if (response['status'] == 'ok' && response['data'] != null) {
//           final movies = response['data']['movies'] as List;
//           return movies.map((movie) => MovieModel.fromJson(movie)).toList();
//         } else {
//           throw ApiException(
//             message:
//                 response['status_message'] ?? 'Failed to load similar movies',
//             statusCode: 400,
//             errorCode: response['status'] ?? 'UNKNOWN_ERROR',
//           );
//         }
//       }
//
//       return response;
//     } on ApiException {
//       rethrow;
//     } catch (e) {
//       throw ApiException(message: 'Failed to load similar movies: $e');
//     }
//   }
// }
// features/movie_details/data/repositories/movie_repository_impl.dart
// features/movie_details/data/repositories/movie_repository_impl.dart
import '../../../../core/network/api_exceptions.dart';
import '../data_sources/movie_api_service.dart';
import '../models/movies/movie_model.dart';

class MovieRepositoryImpl {
  final MovieApiService movieApiService;

  MovieRepositoryImpl({required this.movieApiService});

  /// الحصول على تفاصيل الفيلم
  Future<MovieModel> getMovieDetails(int movieId) async {
    try {
      final response = await movieApiService.getMovieDetails(
        movieId,
        true, // with_images
        true, // with_cast
      );

      if (response.status != 'ok') {
        throw ApiException(
          message: response.statusMessage,
          statusCode: 400,
          errorCode: response.status,
        );
      }

      return response.data.movie;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: 'Failed to load movie details: $e');
    }
  }

  /// الحصول على أفلام مشابهة
  Future<List<MovieModel>> getSimilarMovies(int movieId) async {
    try {
      final response = await movieApiService.getMovieSuggestions(movieId);

      if (response.status != 'ok') {
        throw ApiException(
          message: response.statusMessage,
          statusCode: 400,
          errorCode: response.status,
        );
      }

      return response.data.movies;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: 'Failed to load similar movies: $e');
    }
  }
}
