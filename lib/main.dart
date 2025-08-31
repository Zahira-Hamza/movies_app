import 'package:flutter/material.dart';
import 'package:movies_app/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:movies_app/presentation/screens/update_profile.dart';

import 'core/routes/app_routes.dart';

void main() {
  runApp(MoviesApp());
}

class MoviesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.updateProfileRoute,
      routes: {
        AppRoutes.OnBoardingRoute: (_) => OnboardingScreen(),
        AppRoutes.updateProfileRoute: (_) => UpdateProfile()
      },
    );
  }
}
