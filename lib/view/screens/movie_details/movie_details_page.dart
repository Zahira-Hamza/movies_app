// import 'package:flutter/material.dart';
// import 'package:movies_app/core/constants/styles/app_colors.dart';
// import 'package:movies_app/core/constants/styles/app_styles.dart';
// import 'package:movies_app/view/screens/movie_details/widgets/movie_about.dart';
// import 'package:movies_app/view/screens/movie_details/widgets/movie_genres.dart';
// import 'package:movies_app/view/screens/movie_details/widgets/movie_info.dart';
// import 'package:movies_app/view/screens/movie_details/widgets/movies_details_header.dart';
// import 'package:movies_app/view/screens/movie_details/widgets/suggested_movies.dart';
// import 'package:movies_app/view/widgets/custome_elevated_button.dart';
//
// class MovieDetailsPage extends StatelessWidget {
//   const MovieDetailsPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           MoviesDetailsHeader(),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: CustomeElevatedButton(
//                 label: 'Watch',
//                 labelStyle:
//                     AppStyles.bold20Roboto.copyWith(color: AppColors.white),
//                 backGrounColor: AppColors.red,
//                 onPressed: () {}),
//           ),
//           MovieInfo(),
//           SuggestedMovies(),
//           MovieAbout(),
//           MovieGenres()
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/constants/styles/app_colors.dart';
import 'package:movies_app/core/constants/styles/app_styles.dart';
import 'package:movies_app/view/screens/movie_details/widgets/movie_about.dart';
import 'package:movies_app/view/screens/movie_details/widgets/movie_genres.dart';
import 'package:movies_app/view/screens/movie_details/widgets/movie_info.dart';
import 'package:movies_app/view/screens/movie_details/widgets/movies_details_header.dart';
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

            // تحويل similarMovies إلى List<MovieModel> إذا لزم الأمر
            List<MovieModel> similarMovies = [];
            if (state is MovieDetailsSuccessState) {
              if (state.similarMovies is List<MovieModel>) {
                similarMovies = state.similarMovies as List<MovieModel>;
              } else if (state.similarMovies is List<dynamic>) {
                similarMovies = (state.similarMovies as List<dynamic>)
                    .map((item) =>
                        MovieModel.fromJson(item as Map<String, dynamic>))
                    .toList();
              }
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
        children: [
          MoviesDetailsHeader(movie: movie),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomeElevatedButton(
              label: 'Watch',
              labelStyle:
                  AppStyles.bold20Roboto.copyWith(color: AppColors.white),
              backGrounColor: AppColors.red,
              onPressed: () {},
            ),
          ),
          MovieInfo(movie: movie),
          SuggestedMovies(similarMovies: similarMovies),
          MovieAbout(movie: movie),
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
