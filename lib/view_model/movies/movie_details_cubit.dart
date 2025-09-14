// // features/movie_details/presentation/cubit/movie_details_cubit.dart
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../core/network/api_exceptions.dart';
// import '../../../data/repositories/movie_repository_impl.dart';
// import '../../data/models/movies/movie_model.dart';
//
// // هنا بتربط الملف التابع
// part 'movie_details_state.dart';
//
// /// Cubit لإدارة حالة تفاصيل الفيلم
// class MovieDetailsCubit extends Cubit<MovieDetailsStates> {
//   final MovieRepositoryImpl movieRepository;
//
//   MovieDetailsCubit({required this.movieRepository})
//       : super(MovieDetailsInitialState());
//
//   /// تحميل تفاصيل الفيلم والأفلام المشابهة
//   Future<void> getMovieDetails(int movieId) async {
//     try {
//       emit(MovieDetailsLoadingState());
//       final movie = await movieRepository.getMovieDetails(movieId);
//
//       try {
//         final similarMovies = await movieRepository.getSimilarMovies(movieId);
//         emit(MovieDetailsSuccessState(
//           movie: movie,
//           similarMovies: similarMovies,
//         ));
//       } on ApiException catch (e) {
//         emit(MovieDetailsPartialSuccessState(
//           movie: movie,
//           errorMessage: e.message,
//         ));
//       }
//     } on ApiException catch (e) {
//       final isNetworkError =
//           e.statusCode == 503 || e.errorCode == 'NO_INTERNET';
//
//       emit(MovieDetailsErrorState(
//         errorMessage: e.message,
//         statusCode: e.statusCode,
//         errorCode: e.errorCode,
//         isNetworkError: isNetworkError,
//       ));
//     } catch (e) {
//       emit(MovieDetailsErrorState(
//         errorMessage: 'An unexpected error occurred: $e',
//       ));
//     }
//   }
//
//   /// إعادة محاولة تحميل الأفلام المشابهة
//   Future<void> retryLoadingSimilarMovies(int movieId) async {
//     try {
//       final similarMovies = await movieRepository.getSimilarMovies(movieId);
//
//       if (state is MovieDetailsPartialSuccessState) {
//         final currentState = state as MovieDetailsPartialSuccessState;
//         emit(MovieDetailsSuccessState(
//           movie: currentState.movie,
//           similarMovies: similarMovies,
//         ));
//       } else if (state is MovieDetailsSuccessState) {
//         final currentState = state as MovieDetailsSuccessState;
//         emit(MovieDetailsSuccessState(
//           movie: currentState.movie,
//           similarMovies: similarMovies,
//         ));
//       }
//     } on ApiException catch (e) {
//       print('Failed to retry loading similar movies: ${e.message}');
//     }
//   }
// }
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/network/api_exceptions.dart';
import 'package:movies_app/data/models/movies/movie_model.dart';

import '../../data/repositories/movie_repository_impl.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsStates> {
  final MovieRepositoryImpl movieRepository;

  MovieDetailsCubit({required this.movieRepository})
      : super(MovieDetailsInitialState());

  Future<void> getMovieDetails(int movieId) async {
    try {
      emit(MovieDetailsLoadingState());
      final movie = await movieRepository.getMovieDetails(movieId);

      try {
        final similarMovies = await movieRepository.getSimilarMovies(movieId);
        emit(MovieDetailsSuccessState(
          movie: movie,
          similarMovies: similarMovies,
        ));
      } on ApiException catch (e) {
        emit(MovieDetailsPartialSuccessState(
          movie: movie,
          errorMessage: e.message,
        ));
      }
    } on ApiException catch (e) {
      final isNetworkError =
          e.statusCode == 503 || e.errorCode == 'NO_INTERNET';
      emit(MovieDetailsErrorState(
        errorMessage: e.message,
        statusCode: e.statusCode,
        errorCode: e.errorCode,
        isNetworkError: isNetworkError,
      ));
    } catch (e) {
      emit(MovieDetailsErrorState(
        errorMessage: 'An unexpected error occurred: $e',
      ));
    }
  }

  Future<void> retryLoadingSimilarMovies(int movieId) async {
    try {
      final similarMovies = await movieRepository.getSimilarMovies(movieId);

      if (state is MovieDetailsPartialSuccessState) {
        final currentState = state as MovieDetailsPartialSuccessState;
        emit(MovieDetailsSuccessState(
          movie: currentState.movie,
          similarMovies: similarMovies,
        ));
      } else if (state is MovieDetailsSuccessState) {
        final currentState = state as MovieDetailsSuccessState;
        emit(MovieDetailsSuccessState(
          movie: currentState.movie,
          similarMovies: similarMovies,
        ));
      }
    } on ApiException catch (e) {
      print('Failed to retry loading similar movies: ${e.message}');
    }
  }
}
