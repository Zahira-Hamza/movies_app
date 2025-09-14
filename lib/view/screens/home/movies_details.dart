import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/styles/app_colors.dart';
import 'package:movies_app/core/constants/styles/app_styles.dart';
import 'package:movies_app/view/widgets/custome_elevated_button.dart';
import 'package:movies_app/view/widgets/movies/movie_about.dart';
import 'package:movies_app/view/widgets/movies/movie_genres.dart';
import 'package:movies_app/view/widgets/movies/movie_info.dart';
import 'package:movies_app/view/widgets/movies/movies_details_header.dart';
import 'package:movies_app/view/widgets/movies/suggested_movies.dart';

class MoviesDetails extends StatelessWidget {
  const MoviesDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          MoviesDetailsHeader(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomeElevatedButton(
                label: 'Watch',
                labelStyle:
                    AppStyles.bold20Roboto.copyWith(color: AppColors.white),
                backGrounColor: AppColors.red,
                onPressed: () {}),
          ),
          MovieInfo(),
          SuggestedMovies(),
          MovieAbout(),
          MovieGenres()
        ],
      ),
    );
  }
}
