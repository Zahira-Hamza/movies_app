import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/constants/styles/app_colors.dart';
import 'package:movies_app/core/constants/styles/app_styles.dart';
import 'package:movies_app/view/screens/movie_details/widgets/movie_cast.dart';
import 'package:movies_app/view/screens/movie_details/widgets/movie_description.dart';
import 'package:movies_app/view/screens/movie_details/widgets/movie_genres.dart';
import 'package:movies_app/view/screens/movie_details/widgets/movie_info.dart';
import 'package:movies_app/view/screens/movie_details/widgets/movies_details_header.dart';
import 'package:movies_app/view/screens/movie_details/widgets/screenshoots_section.dart';
import 'package:movies_app/view/screens/movie_details/widgets/suggested_movies.dart';
import 'package:movies_app/view/widgets/custome_elevated_button.dart';

import '../../../data/models/movies/movie_model.dart';
import '../../../view_model/movies/movie_details_cubit.dart';

class MovieDetailsPage extends StatefulWidget {
  final int movieId;

  const MovieDetailsPage({super.key, required this.movieId});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  void initState() {
    super.initState();
    log('🎬 Loading movie details for ID: ${widget.movieId}');
    _loadMovieDetails();
  }

  void _loadMovieDetails() {
    if (widget.movieId == null) {
      log('❌ ERROR: Movie ID is null!');
      return;
    }
    context.read<MovieDetailsCubit>().getMovieDetails(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MovieDetailsCubit, MovieDetailsStates>(
        listener: (context, state) {
          if (state is MovieDetailsErrorState && state.isNetworkError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is MovieDetailsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MovieDetailsErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.errorMessage),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => context
                        .read<MovieDetailsCubit>()
                        .getMovieDetails(widget.movieId),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is MovieDetailsSuccessState ||
              state is MovieDetailsPartialSuccessState) {
            final movie = state is MovieDetailsSuccessState
                ? state.movie
                : (state as MovieDetailsPartialSuccessState).movie;

            List<MovieModel> similarMovies = [];
            if (state is MovieDetailsSuccessState) {
              similarMovies = state.similarMovies;
            }

            return _buildSuccessContent(movie, similarMovies, state);
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildSuccessContent(
    MovieModel movie,
    List<MovieModel> similarMovies,
    MovieDetailsStates state,
  ) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MoviesDetailsHeader(movie: movie),
          SizedBox(
            height: 13.h,
          ),
          // 1. Watch Button
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: CustomeElevatedButton(
              label: 'Watch',
              labelStyle:
                  AppStyles.bold20Roboto.copyWith(color: AppColors.white),
              backGrounColor: AppColors.red,
              onPressed: () {},
            ),
          ),
          SizedBox(
            height: 18.h,
          ),
          // 2. Movie Info (Rating, Runtime)
          MovieInfo(movie: movie),
          SizedBox(height: 32.h),
          // 3. Screenshots
          ScreenshotsSection(movie: movie),
          SizedBox(height: 32.h),
          // 4. Suggested Movies
          SuggestedMovies(similarMovies: similarMovies),
          SizedBox(height: 22.h),
          // 5. DESCRIPTION
          MovieDescription(movie: movie),
          SizedBox(
            height: 22.h,
          ),
          //6.movie cast
          MovieCastHandling(movie: movie),
          SizedBox(
            height: 22.h,
          ),
          // 7. Genres
          MovieGenres(genres: movie.genres),
          if (state is MovieDetailsPartialSuccessState)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    state.errorMessage,
                    style: const TextStyle(color: Colors.orange),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => context
                        .read<MovieDetailsCubit>()
                        .retryLoadingSimilarMovies(widget.movieId),
                    child: const Text('Retry Loading Similar Movies'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
