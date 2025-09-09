import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/constants/styles/app_theme.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/view/screens/auth/register_screen.dart';
import 'package:movies_app/view/screens/home/bottom_nav_bar.dart';
import 'package:movies_app/view/screens/onboarding/onboarding_screen.dart';
import 'package:movies_app/view/screens/update_profile.dart';
import 'package:movies_app/view_model/auth/auth_cubit.dart';

import 'core/routes/app_routes.dart';
import 'view/screens/auth/forget_password.dart';
import 'view/screens/auth/login_screen.dart';

void main() {
  runApp(const MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.registerRoute,
        theme: AppTheme.appTheme,
        routes: {
          AppRoutes.onBoardingRoute: (context) => OnboardingScreen(),
          AppRoutes.registerRoute: (context) => RegisterScreen(),
          AppRoutes.loginRoute: (context) => LoginScreen(),
          AppRoutes.forgetPasswordRoute: (context) => ForgetPassword(),
          AppRoutes.updateProfileRoute: (context) => UpdateProfile(),
          AppRoutes.bottomNavBarRoute: (context) => BottomNavBar(),
        },
        locale: Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
