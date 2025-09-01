import 'package:flutter/material.dart';
import 'package:movies_app/presentation/screens/login/login_screen.dart';
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
      initialRoute: AppRoutes.OnBoardingRoute,
      routes: {
        AppRoutes.OnBoardingRoute: (context) => OnboardingScreen(),
        AppRoutes.loginScreenRoute:(context)=>LoginScreen()
      },
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
    );
  }
}
