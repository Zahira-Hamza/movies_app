import 'package:flutter/material.dart';

import '../../../../core/constants/styles/app_styles.dart';
import '../../../../data/models/movies/movie_model.dart';
import 'custom_film_poster.dart';

class SuggestedMovies extends StatelessWidget {
  final List<MovieModel> similarMovies;

  const SuggestedMovies({super.key, required this.similarMovies});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text('Similar', style: AppStyles.bold24Roboto),
          const SizedBox(height: 2),
          similarMovies.isEmpty
              ? Container(
                  height: 200,
                  child: Center(
                    child: Text('No similar movies found',
                        style: AppStyles.regular16Roboto),
                  ),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 189 / 279,
                  ),
                  itemCount: similarMovies.length,
                  itemBuilder: (context, index) => CustomFilmPoster(
                    height: double.infinity,
                    width: double.infinity,
                    imagePath: similarMovies[index].mediumCoverImage ??
                        '', // استخدام سلسلة فارغة إذا كانت null
                    rating: similarMovies[index].rating.toStringAsFixed(1),
                  ),
                )
        ],
      ),
    );
  }
}
