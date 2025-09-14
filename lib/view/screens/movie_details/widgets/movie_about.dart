// import 'package:flutter/material.dart';
// import 'package:movies_app/core/constants/styles/app_colors.dart';
// import 'package:movies_app/core/constants/styles/app_styles.dart';
//
// import 'movie_cast.dart';
//
// class MovieAbout extends StatelessWidget {
//   const MovieAbout({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             height: 12,
//           ),
//           Text(
//             'Summary',
//             style: AppStyles.bold24Roboto,
//           ),
//           SizedBox(
//             height: 8,
//           ),
//           Text(
//             'Following the events of Spider-Man No Way Home, Doctor Strange unwittingly casts a forbidden spell that accidentally opens up the multiverse. With help from Wong and Scarlet Witch, Strange confronts various versions of himself as well as teaming up with the young America Chavez while traveling through various realities and working to restore reality as he knows it. Along the way, Strange and his allies realize they must take on a powerful new adversary who seeks to take over the multiverse.—Blazer346',
//             style: AppStyles.regular16Roboto
//                 .copyWith(color: AppColors.white, height: 1.5),
//           ),
//           SizedBox(
//             height: 16,
//           ),
//           Text(
//             'Cast',
//             style: AppStyles.bold24Roboto,
//           ),
//           SizedBox(height: 5),
//           ListView.separated(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: 3,
//             itemBuilder: (_, index) => MovieCast(
//               name: 'Elizabeth Olsen',
//               character: 'Wanda Maximoff / The Scarlet Witch',
//               image: 'assets/images/test3.jpg',
//             ),
//             separatorBuilder: (context, index) => SizedBox(
//               height: 8,
//             ),
//           ),
//           SizedBox(
//             height: 16,
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

import '../../../../core/constants/styles/app_colors.dart';
import '../../../../core/constants/styles/app_styles.dart';
import '../../../../data/models/movies/movie_model.dart';

class MovieAbout extends StatelessWidget {
  final MovieModel movie;

  const MovieAbout({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Text('Summary', style: AppStyles.bold24Roboto),
          const SizedBox(height: 8),
          Text(
            movie.descriptionFull ??
                movie.summary ??
                'No description available', // استخدام قيم افتراضية
            style: AppStyles.regular16Roboto
                .copyWith(color: AppColors.white, height: 1.5),
          ),
          const SizedBox(height: 16),
          Text('Cast', style: AppStyles.bold24Roboto),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text('Cast information not available',
                  style: AppStyles.regular16Roboto),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
