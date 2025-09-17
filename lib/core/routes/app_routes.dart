import 'package:flutter/material.dart';

class AppRoutes {
  static const String onBoardingScreenRoute = "onboarding_screen";
  static const String registerScreenRoute = "register_screen";
  static const String loginScreenRoute = "login_screen";
  static const String forgetPasswordScreenRoute = "forget_screen";
  static const String updateProfileScreenRoute = "update_profile_screen";
  static const String homeScreenRoute = "home_screen";

  // يفضل توحيد الاسم عشان ميبقاش فيه لخبطة
  static const String movieDetailsRoute = "movie_details";

  // دالة مساعدة للتنقل إلى صفحة تفاصيل الفيلم
 static void navigateToMovieDetails(
  BuildContext context, {
  required int movieId,
}) {
  Navigator.pushNamed(
    context,
    AppRoutes.movieDetailsRoute,
    arguments: movieId,
  );
}
}
