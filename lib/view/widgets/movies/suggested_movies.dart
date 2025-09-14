import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/styles/app_styles.dart';
import 'package:movies_app/view/widgets/movies/custom_film_poster.dart';

class SuggestedMovies extends StatelessWidget {
  const SuggestedMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 16,
          ),
          Text(
            'Similar ',
            style: AppStyles.bold24Roboto,
          ),
          SizedBox(
            height: 2,
          ),
          GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 189 / 279,
              ),
              itemCount: 4,
              itemBuilder: (context, index) => CustomFilmPoster(
                  height: double.infinity,
                  width: double.infinity,
                  imagePath:
                      'https://resizing.flixster.com/7HYZbJjMdMiJnl6yAGxK7dej7wI=/fit-in/705x460/v2/https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p8129393_k_h9_aa.jpg',
                  rating: '7.2'))
        ],
      ),
    );
  }
}
