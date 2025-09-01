import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/app_theme.dart';
import 'package:movies_app/presentation/screens/auth/register_screen.dart';
import 'package:movies_app/presentation/screens/onboarding/onboarding_screen.dart';

import 'core/routes/app_routes.dart';

void main() {
  runApp(const MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.registerRoute,
      theme: AppTheme.appTheme,
      routes: {
        AppRoutes.onBoardingRoute: (context) => OnboardingScreen(),
        AppRoutes.registerRoute: (context) => RegisterScreen(),
      },
    );
  }
}
