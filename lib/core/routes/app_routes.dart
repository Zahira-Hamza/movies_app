// import 'package:flutter/material.dart';
//
// import '../../data/models/movies/movie_model.dart';
//
// class AppRoutes {
//   static const String onBoardingScreenRoute = "onboarding_screen";
//   static const String registerScreenRoute = "register_screen";
//   static const String loginScreenRoute = "login_screen";
//   static const String forgetPasswordScreenRoute = "forget_screen";
//   static const String updateProfileScreenRoute = "update_profile_screen";
//   static const String homeScreenRoute = "home_screen";
//   static const String movieDetailsRoute = "movie_details";
//   //
//   // /// دالة مساعدة للتنقل إلى صفحة تفاصيل الفيلم
//   // static void navigateToMovieDetails(
//   //   BuildContext context, {
//   //   required int movieId,
//   //   MovieModel? movie,
//   // }) {
//   //   Navigator.pushNamed(
//   //     context,
//   //     AppRoutes.movieDetailsRoute,
//   //     arguments: {'movieId': movieId, 'movie': movie},
//   //   );
//   // }
//   static void navigateToMovieDetails(
//     BuildContext context, {
//     required int movieId,
//     MovieModel? movie, // Make this optional
//   }) {
//     Navigator.pushNamed(
//       context,
//       AppRoutes.movieDetailsRoute,
//       arguments: {'movieId': movieId, 'movie': movie},
//     );
//   }
// }
import 'package:flutter/material.dart';

class AppRoutes {
  static const String onBoardingScreenRoute = "onboarding_screen";
  static const String registerScreenRoute = "register_screen";
  static const String loginScreenRoute = "login_screen";
  static const String forgetPasswordScreenRoute = "forget_screen";
  static const String updateProfileScreenRoute = "update_profile_screen";
  static const String homeScreenRoute = "home_screen";
  static const String movieDetailsRoute = "movie_details_page";

  // دالة مساعدة للتنقل إلى صفحة تفاصيل الفيلم
  static void navigateToMovieDetails(BuildContext context,
      {required int movieId}) {
    Navigator.pushNamed(
      context,
      AppRoutes.movieDetailsRoute,
      arguments: movieId,
    );
  }
}
