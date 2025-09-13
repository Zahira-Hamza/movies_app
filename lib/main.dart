import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/view/screens/auth/forget_password.dart';
import 'package:movies_app/view/screens/auth/login_screen.dart';
import 'package:movies_app/view/screens/auth/register_screen.dart';
import 'package:movies_app/view/screens/home/home_screen.dart';
import 'package:movies_app/view/screens/onboarding/onboarding_screen.dart';
import 'package:movies_app/view/screens/update_profile/update_profile_screen.dart';
import 'package:movies_app/view_model/auth/auth_cubit.dart';
import 'package:movies_app/view_model/profile/profile_cubit.dart';

import 'core/constants/styles/app_theme.dart';
import 'core/routes/app_routes.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(const MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutes.onBoardingScreenRoute,
            theme: AppTheme.appTheme,
            routes: {
              AppRoutes.onBoardingScreenRoute: (context) => OnboardingScreen(),
              AppRoutes.registerScreenRoute: (context) => RegisterScreen(),
              AppRoutes.loginScreenRoute: (context) => LoginScreen(),
              AppRoutes.forgetPasswordScreenRoute: (context) =>
                  ForgetPassword(),
              AppRoutes.updateProfileScreenRoute: (context) => UpdateProfile(),
              AppRoutes.homeScreenRoute: (context) => HomeScreen(),
            },
            locale: const Locale('en'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          );
        },
      ),
    );
  }
}
