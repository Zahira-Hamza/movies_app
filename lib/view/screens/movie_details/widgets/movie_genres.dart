// import 'package:flutter/material.dart';
// import 'package:movies_app/core/constants/styles/app_styles.dart';
//
// import 'genres_item.dart';
//
// class MovieGenres extends StatelessWidget {
//   const MovieGenres({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Genres',
//             style: AppStyles.bold24Roboto,
//           ),
//           SizedBox(height: 12),
//           GridView.builder(
//             shrinkWrap: true,
//             itemCount: 5,
//             padding: EdgeInsets.zero,
//             physics: NeverScrollableScrollPhysics(),
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//                 crossAxisSpacing: 16,
//                 childAspectRatio: 122 / 56),
//             itemBuilder: (context, index) => GenresItem(type: 'Action'),
//           )
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

import '../../../../core/constants/styles/app_styles.dart';
import 'genres_item.dart';

class MovieGenres extends StatelessWidget {
  final List<String> genres;

  const MovieGenres({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Genres', style: AppStyles.bold24Roboto),
          SizedBox(height: 12),
          genres.isEmpty
              ? Container(
                  height: 56,
                  child: Center(
                    child: Text('No genres available',
                        style: AppStyles.regular16Roboto),
                  ),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  itemCount: genres.length,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    childAspectRatio: 122 / 56,
                  ),
                  itemBuilder: (context, index) =>
                      GenresItem(type: genres[index]),
                )
        ],
      ),
    );
  }
}
