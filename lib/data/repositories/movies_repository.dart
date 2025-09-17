import 'package:dio/dio.dart';
import 'package:movies_app/core/network/api_exceptions.dart';
import 'package:movies_app/data/models/movies/movie_model.dart';
import '../data_sources/movie_api_service.dart';

class MoviesRepository {
  final MovieApiService movieApiService;

  MoviesRepository({required this.movieApiService});

  Future<MovieModel> getMovieDetails(int movieId) async {
    try {
      if (movieId == null) {
        throw ApiException(
          message: 'Movie ID cannot be null',
          statusCode: 400,
          errorCode: 'NULL_MOVIE_ID',
        );
      }

      print('🔍 Getting movie details for ID: $movieId');

      final response = await movieApiService.getMovieDetails(
        movieId,
        true,
        true,
      );

      print('✅ API Response status: ${response.status}');
      print('📝 API Response message: ${response.statusMessage}');

      // Handle API errors
      if (response.status == 'error') {
        throw ApiException(
          message: response.statusMessage,
          statusCode: 400,
          errorCode: 'API_ERROR',
        );
      }

      if (response.data?.movie == null) {
        throw ApiException(
          message: 'Movie data is null',
          statusCode: 404,
          errorCode: 'MOVIE_NOT_FOUND',
        );
      }

      return response.data!.movie!;
    } on DioException catch (e) {
      throw ApiException(
        message: 'Network error: ${e.message}',
        statusCode: e.response?.statusCode ?? 500,
        errorCode: 'NETWORK_ERROR',
      );
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: 'Failed to load movie details: $e');
    }
  }

  Future<List<MovieModel>> getSimilarMovies(int movieId) async {
    try {
      if (movieId == null) {
        throw ApiException(
          message: 'Movie ID cannot be null for similar movies',
          statusCode: 400,
          errorCode: 'NULL_MOVIE_ID',
        );
      }

      print('🔍 Getting similar movies for ID: $movieId');

      final response = await movieApiService.getMovieSuggestions(movieId);

      print('✅ Found ${response.length} similar movies');

      return response;
    } on DioException catch (e) {
      throw ApiException(
        message: 'Network error: ${e.message}',
        statusCode: e.response?.statusCode ?? 500,
        errorCode: 'NETWORK_ERROR',
      );
    } on ApiException {
      rethrow;
    } catch (e) {
      print('❌ Error loading similar movies: $e');
      throw ApiException(message: 'Failed to load similar movies: $e');
    }
  }
}
