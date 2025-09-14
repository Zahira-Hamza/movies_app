// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:movies_app/core/constants/styles/app_assets.dart';
// import 'package:movies_app/core/constants/styles/app_colors.dart';
// import 'package:movies_app/core/constants/styles/app_styles.dart';
//
// class MoviesDetailsHeader extends StatelessWidget {
//   const MoviesDetailsHeader({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = MediaQuery.of(context).size;
//     return Column(
//       children: [
//         Container(
//           height: screenSize.height * .70,
//           width: double.infinity,
//           padding: EdgeInsets.only(right: 16, left: 16, top: 29, bottom: 8),
//           decoration: BoxDecoration(
//               image: DecorationImage(
//                   fit: BoxFit.fill, image: AssetImage(AppAssets.test))),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   IconButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       icon: Icon(
//                         Icons.arrow_back_ios,
//                         size: 29,
//                         color: AppColors.white,
//                       )),
//                   IconButton(
//                       onPressed: () {
//                         // add to fav list
//                       },
//                       icon: Icon(
//                         Icons.bookmark,
//                         size: 29,
//                         color: AppColors.white,
//                       )),
//                 ],
//               ),
//               SvgPicture.asset(AppAssets.watchIcon),
//               Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12),
//                     child: Text(
//                       'Doctor Strange in the Multiverse of Madness',
//                       style: AppStyles.bold24Roboto,
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   SizedBox(height: 15),
//                   Text(
//                     '2022',
//                     style: AppStyles.bold20Roboto,
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//         Container(
//           color: AppColors.red,
//         ),
//       ],
//     );
//   }
// }
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/styles/app_assets.dart';
import '../../../../core/constants/styles/app_colors.dart';
import '../../../../core/constants/styles/app_styles.dart';
import '../../../../data/models/movies/movie_model.dart';

class MoviesDetailsHeader extends StatelessWidget {
  final MovieModel movie;

  const MoviesDetailsHeader({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: screenSize.height * .70,
          width: double.infinity,
          padding:
              const EdgeInsets.only(right: 16, left: 16, top: 29, bottom: 8),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: movie.backgroundImage != null
                  ? CachedNetworkImageProvider(movie.backgroundImage!)
                  : const AssetImage('assets/images/placeholder.jpg')
                      as ImageProvider,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 29,
                      color: AppColors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // add to fav list
                    },
                    icon: const Icon(
                      Icons.bookmark,
                      size: 29,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
              SvgPicture.asset(AppAssets.watchIcon),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      movie.titleLong ??
                          movie
                              .title, // استخدام title كبديل إذا كان titleLong null
                      style: AppStyles.bold24Roboto,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    movie.year.toString(),
                    style: AppStyles.bold20Roboto,
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
