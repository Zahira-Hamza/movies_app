// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:movies_app/core/constants/styles/app_assets.dart';
// import 'package:movies_app/core/constants/styles/app_colors.dart';
// import 'package:movies_app/core/constants/styles/app_styles.dart';
//
// class MovieInfo extends StatelessWidget {
//   const MovieInfo({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: 16,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Info(image: AppAssets.favIcon, info: '15'),
//                 Info(image: AppAssets.timeIcon, info: '90'),
//                 Info(image: AppAssets.rateIcon, info: '7.2'),
//               ],
//             ),
//             SizedBox(
//               height: 18,
//             ),
//             Text(
//               'Screen Shots',
//               style: AppStyles.bold24Roboto,
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             ListView.separated(
//               physics: NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: 3,
//               itemBuilder: (context, index) => ClipRRect(
//                 borderRadius: BorderRadius.circular(16),
//                 child: Image.asset(
//                   'assets/images/test2.jpg',
//                   height: 165,
//                   width: double.infinity,
//                   fit: BoxFit.fill,
//                 ),
//               ),
//               separatorBuilder: (context, index) => SizedBox(
//                 height: 14,
//               ),
//             )
//           ],
//         ));
//   }
// }
//
// class Info extends StatelessWidget {
//   const Info({super.key, required this.image, required this.info});
//
//   final String image;
//   final String info;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 11, horizontal: 14),
//       decoration: BoxDecoration(
//           color: AppColors.grey,
//           borderRadius: BorderRadiusDirectional.circular(16)),
//       child: Row(
//         children: [
//           SvgPicture.asset(
//             image,
//             width: 24,
//             height: 24,
//             fit: BoxFit.scaleDown,
//           ),
//           SizedBox(width: 14),
//           Text(
//             info,
//             style: AppStyles.bold24Roboto,
//           )
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/styles/app_assets.dart';
import '../../../../core/constants/styles/app_colors.dart';
import '../../../../core/constants/styles/app_styles.dart';
import '../../../../data/models/movies/movie_model.dart';

class MovieInfo extends StatelessWidget {
  final MovieModel movie;

  const MovieInfo({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Info(image: AppAssets.favIcon, info: '15'),
              Info(image: AppAssets.timeIcon, info: '${movie.runtime} min'),
              Info(
                  image: AppAssets.rateIcon,
                  info: movie.rating.toStringAsFixed(1)),
            ],
          ),
          const SizedBox(height: 18),
          Text('Screen Shots', style: AppStyles.bold24Roboto),
          const SizedBox(height: 10),
          Container(
            height: 165,
            child: Center(
              child: Text('No screenshots available',
                  style: AppStyles.regular16Roboto),
            ),
          )
        ],
      ),
    );
  }
}

class Info extends StatelessWidget {
  const Info({super.key, required this.image, required this.info});

  final String image;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 11, horizontal: 14),
      decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadiusDirectional.circular(16)),
      child: Row(
        children: [
          SvgPicture.asset(
            image,
            width: 24,
            height: 24,
            fit: BoxFit.scaleDown,
          ),
          SizedBox(width: 14),
          Text(
            info,
            style: AppStyles.bold24Roboto,
          )
        ],
      ),
    );
  }
}
