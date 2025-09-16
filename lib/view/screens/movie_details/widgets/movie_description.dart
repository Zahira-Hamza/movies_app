import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/styles/app_colors.dart';
import 'package:movies_app/core/constants/styles/app_styles.dart';
import 'package:movies_app/data/models/movies/movie_model.dart';

class MovieDescription extends StatelessWidget {
  final MovieModel movie;

  const MovieDescription({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final description = movie.descriptionFull ?? movie.summary;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Description',
              style: AppStyles.bold24Roboto.copyWith(color: AppColors.white),
            ),
          ),
          const SizedBox(height: 16),
          if (description != null && description.isNotEmpty)
            Text(
              description,
              style: AppStyles.regular16gray.copyWith(color: AppColors.white),
              textAlign: TextAlign.justify,
            )
          else
            Text(
              'No description available for this movie.',
              style: AppStyles.regular16Roboto.copyWith(color: AppColors.grey),
            ),
        ],
      ),
    );
  }
}
