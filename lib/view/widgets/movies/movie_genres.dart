import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/styles/app_styles.dart';
import 'package:movies_app/view/widgets/movies/genres_item.dart';

class MovieGenres extends StatelessWidget {
  const MovieGenres({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Genres',
            style: AppStyles.bold24Roboto,
          ),
          SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            itemCount: 5,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                childAspectRatio: 122 / 56),
            itemBuilder: (context, index) => GenresItem(type: 'Action'),
          )
        ],
      ),
    );
  }
}
