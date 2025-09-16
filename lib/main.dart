import 'package:dio/dio.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:movies_app/core/constants/styles/app_theme.dart';

import 'package:movies_app/data/data_sources/remote_data_sources/movies_remote_data_source.dart';

import 'package:movies_app/l10n/app_localizations.dart';

import 'package:movies_app/view/screens/auth/register_screen.dart';

import 'package:movies_app/view/screens/home/home_screen.dart';

import 'package:movies_app/view/screens/movie_details/movie_details_page.dart';

import 'package:movies_app/view/screens/onboarding/onboarding_screen.dart';

import 'package:movies_app/view/screens/update_profile/update_profile_screen.dart';

import 'package:movies_app/view_model/auth/auth_cubit.dart';

import 'package:movies_app/view_model/movies/movie_details_cubit.dart';

import 'package:movies_app/view_model/movies/movies_cubit.dart';

import 'package:movies_app/view_model/profile/profile_cubit.dart';



import 'core/routes/app_routes.dart';

import 'data/data_sources/movie_api_service.dart';

import 'data/repositories/movie_repository_impl.dart';

import 'view/screens/auth/forget_password.dart';

import 'view/screens/auth/login_screen.dart';



void main() {

  runApp(const MoviesApp());

}



class MoviesApp extends StatelessWidget {

  const MoviesApp({super.key});



  @override

  Widget build(BuildContext context) {

    final dio = Dio();

    final movieApiService = MovieApiService(dio);

    final movieRepository =

    MovieRepositoryImpl(movieApiService: movieApiService);



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

          ],

          child: MaterialApp(

            debugShowCheckedModeBanner: false,

            initialRoute: AppRoutes.homeScreenRoute,

            theme: AppTheme.appTheme,

            routes: {

              AppRoutes.onBoardingScreenRoute: (context) => OnboardingScreen(),

              AppRoutes.registerScreenRoute: (context) => RegisterScreen(),

              AppRoutes.loginScreenRoute: (context) => LoginScreen(),

              AppRoutes.forgetPasswordScreenRoute: (context) =>

                  ForgetPassword(),

              AppRoutes.updateProfileScreenRoute: (context) => UpdateProfile(),

              AppRoutes.homeScreenRoute: (context) => HomeScreen(),

              AppRoutes.movieDetailsRoute: (context) => MovieDetailsPage(

                movieId: ModalRoute.of(context)!.settings.arguments as int,

              ),

            },

            locale: const Locale('en'),

            localizationsDelegates: AppLocalizations.localizationsDelegates,

            supportedLocales: AppLocalizations.supportedLocales,

          ),

        );

      },

    );

  }

}
