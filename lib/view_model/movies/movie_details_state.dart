// part of 'movie_details_cubit.dart';
//
// /// حالات مختلفة لصفحة تفاصيل الفيلم
// abstract class MovieDetailsStates {}
//
// /// الحالة الأولية
// class MovieDetailsInitialState extends MovieDetailsStates {}
//
// /// حالة التحميل
// class MovieDetailsLoadingState extends MovieDetailsStates {}
//
// /// حالة النجاح
// class MovieDetailsSuccessState extends MovieDetailsStates {
//   final MovieModel movie;
//   final List<MovieModel> similarMovies;
//
//   MovieDetailsSuccessState({
//     required this.movie,
//     required this.similarMovies,
//   });
// }
//
// /// حالة الخطأ
// class MovieDetailsErrorState extends MovieDetailsStates {
//   final String errorMessage;
//   final int? statusCode;
//   final String? errorCode;
//   final bool isNetworkError;
//
//   MovieDetailsErrorState({
//     required this.errorMessage,
//     this.statusCode,
//     this.errorCode,
//     this.isNetworkError = false,
//   });
// }
//
// /// حالة نجاح جزئي (الفيلم نجح ولكن الأفلام المشابهة فشلت)
// class MovieDetailsPartialSuccessState extends MovieDetailsStates {
//   final MovieModel movie;
//   final String errorMessage;
//
//   MovieDetailsPartialSuccessState({
//     required this.movie,
//     required this.errorMessage,
//   });
// }
part of 'movie_details_cubit.dart';

/// حالات مختلفة لصفحة تفاصيل الفيلم
abstract class MovieDetailsStates {}

/// الحالة الأولية
class MovieDetailsInitialState extends MovieDetailsStates {}

/// حالة التحميل
class MovieDetailsLoadingState extends MovieDetailsStates {}

/// حالة النجاح
class MovieDetailsSuccessState extends MovieDetailsStates {
  final MovieModel movie;
  final List<MovieModel> similarMovies;

  MovieDetailsSuccessState({
    required this.movie,
    required this.similarMovies,
  });
}

/// حالة الخطأ
class MovieDetailsErrorState extends MovieDetailsStates {
  final String errorMessage;
  final int? statusCode;
  final String? errorCode;
  final bool isNetworkError;

  MovieDetailsErrorState({
    required this.errorMessage,
    this.statusCode,
    this.errorCode,
    this.isNetworkError = false,
  });
}

/// حالة نجاح جزئي (الفيلم نجح ولكن الأفلام المشابهة فشلت)
class MovieDetailsPartialSuccessState extends MovieDetailsStates {
  final MovieModel movie;
  final String errorMessage;

  MovieDetailsPartialSuccessState({
    required this.movie,
    required this.errorMessage,
  });
}
