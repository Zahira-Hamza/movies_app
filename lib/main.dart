import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/constants/styles/app_theme.dart';
import 'package:movies_app/data/data_sources/remote_data_sources/movies_remote_data_source.dart';
import 'package:movies_app/data/repositories/movies_repository.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/view/screens/auth/register_screen.dart';
import 'package:movies_app/view/screens/home/home_screen.dart';
import 'package:movies_app/view/screens/movie_details/movie_details_page.dart';
import 'package:movies_app/view/screens/onboarding/onboarding_screen.dart';
import 'package:movies_app/view/screens/update_profile/update_profile_screen.dart';
import 'package:movies_app/view_model/auth/auth_cubit.dart';
import 'package:movies_app/view_model/movies/fav_movies_cubit.dart';
import 'package:movies_app/view_model/movies/movie_details_cubit.dart';
import 'package:movies_app/view_model/movies/movies_cubit.dart';
import 'package:movies_app/view_model/profile/profile_cubit.dart';
import 'core/routes/app_routes.dart';
import 'data/data_sources/movie_api_service.dart';
import 'view/screens/auth/forget_password.dart';
import 'view/screens/auth/login_screen.dart';

void main() {
  runApp(const MoviesApp());
}

class MoviesApp extends StatefulWidget {
  const MoviesApp({super.key});

  @override
  State<MoviesApp> createState() => _MoviesAppState();
}

class _MoviesAppState extends State<MoviesApp> {
  Locale _locale = const Locale('en');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final movieApiService = MovieApiService(dio);
    final movieRepository = MoviesRepository(movieApiService: movieApiService);

    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthCubit>(
              create: (context) => AuthCubit(),
            ),
            BlocProvider<ProfileCubit>(
              create: (context) => ProfileCubit(),
            ),
            BlocProvider<MoviesCubit>(
              create: (context) => MoviesCubit(MoviesRemoteDataSource()),
            ),
            BlocProvider<MovieDetailsCubit>(
              create: (context) =>
                  MovieDetailsCubit(movieRepository: movieRepository),
            ),
            BlocProvider<FavMoviesCubit>(create: (context) => FavMoviesCubit()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutes.loginScreenRoute,
            theme: AppTheme.appTheme,
            routes: {
              AppRoutes.onBoardingScreenRoute: (context) => OnboardingScreen(),
              AppRoutes.registerScreenRoute: (context) =>
                  RegisterScreen(onLocaleChange: setLocale),
              AppRoutes.loginScreenRoute: (context) =>
                  LoginScreen(onLocaleChange: setLocale),
              AppRoutes.forgetPasswordScreenRoute: (context) =>
                  ForgetPassword(),
              AppRoutes.updateProfileScreenRoute: (context) => UpdateProfile(),
              AppRoutes.homeScreenRoute: (context) => HomeScreen(),
              AppRoutes.movieDetailsRoute: (context) => MovieDetailsPage(
                    movieId: ModalRoute.of(context)!.settings.arguments as int,
                  ),
            },
            locale: _locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          ),
        );
      },
    );
  }
}
