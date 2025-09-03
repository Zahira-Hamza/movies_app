import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/styles/app_theme.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/view/screens/auth/register_screen.dart';
import 'package:movies_app/view/screens/onboarding/onboarding_screen.dart';

import 'core/routes/app_routes.dart';
import 'view/screens/auth/forget_password.dart';

void main() {
  runApp(MoviesApp());
}

class MoviesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.onBoardingRoute,
      theme: AppTheme.appTheme,
      routes: {
        AppRoutes.onBoardingRoute: (context) => OnboardingScreen(),
        AppRoutes.registerRoute: (context) => RegisterScreen(),
        // AppRoutes.loginRoute: (context) => LoginScreen(),
        AppRoutes.forgetPasswordRoute: (context) => ForgetPassword(),
      },
      locale: Locale('ar'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
