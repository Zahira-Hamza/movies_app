//
// import 'package:flutter/material.dart';
// import 'package:movies_app/core/constants/styles/app_colors.dart';
// import 'package:movies_app/core/constants/styles/app_styles.dart';
//
// class MovieCast extends StatelessWidget {
//   const MovieCast({
//     super.key,
//     required this.image,
//     required this.character,
//     required this.name,
//   });
//
//   final String image;
//   final String character;
//   final String name;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(11),
//       decoration: BoxDecoration(
//         color: AppColors.grey,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         children: [
//           // Cast member image with network support
//           ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: image.startsWith('http')
//                 ? Image.network(
//                     image,
//                     width: 50,
//                     height: 50,
//                     fit: BoxFit.cover,
//                     loadingBuilder: (context, child, loadingProgress) {
//                       if (loadingProgress == null) return child;
//                       return Container(
//                         width: 50,
//                         height: 50,
//                         color: AppColors.grey,
//                         child: const Center(
//                           child: CircularProgressIndicator(
//                             color: AppColors.yellowPrimaryColor,
//                           ),
//                         ),
//                       );
//                     },
//                     errorBuilder: (context, error, stackTrace) =>
//                         _buildPlaceholderImage(),
//                   )
//                 : Image.asset(
//                     image,
//                     width: 50,
//                     height: 50,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) =>
//                         _buildPlaceholderImage(),
//                   ),
//           ),
//           const SizedBox(width: 10),
//
//           // Cast member details
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   name,
//                   style: AppStyles.regular16Roboto.copyWith(
//                     color: AppColors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 5),
//                 Text(
//                   'as $character',
//                   style: AppStyles.regular16Roboto.copyWith(
//                     color: AppColors.grey,
//                     fontStyle: FontStyle.italic,
//                   ),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPlaceholderImage() {
//     return Container(
//       width: 50,
//       height: 50,
//       color: AppColors.grey,
//       child: const Icon(
//         Icons.person,
//         color: AppColors.white,
//         size: 30,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/styles/app_colors.dart';
import 'package:movies_app/core/constants/styles/app_styles.dart';

import '../../../../data/models/movies/movie_model.dart';

class MovieCast extends StatelessWidget {
  const MovieCast({
    super.key,
    required this.image,
    required this.character,
    required this.name,
  });

  final String image;
  final String character;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Cast member image with network support and error handling
          _buildCastImage(),
          const SizedBox(width: 16),

          // Cast member details with the format you want
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Name : ',
                        style: AppStyles.regular16Roboto.copyWith(
                          color: AppColors.yellowPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: name,
                        style: AppStyles.regular16Roboto.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Character : ',
                        style: AppStyles.regular16Roboto.copyWith(
                          color: AppColors.yellowPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: character,
                        style: AppStyles.regular16Roboto.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCastImage() {
    // If no image or invalid URL, show placeholder
    if (image.isEmpty ||
        image == 'null' ||
        image == 'assets/images/placeholder_cast.png' ||
        !image.startsWith('http')) {
      return _buildPlaceholderImage();
    }

    // Try to load network image
    try {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          image,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.yellowPrimaryColor,
                  strokeWidth: 2,
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            print('❌ Failed to load cast image: $image, error: $error');
            return _buildPlaceholderImage();
          },
        ),
      );
    } catch (e) {
      print('❌ Exception loading cast image: $e');
      return _buildPlaceholderImage();
    }
  }

  Widget _buildPlaceholderImage() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(
        Icons.person,
        color: AppColors.white,
        size: 40,
      ),
    );
  }
}

class MovieCastHandling extends StatelessWidget {
  final MovieModel movie;

  const MovieCastHandling({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final hasCast = movie.cast != null && movie.cast!.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cast Section
          if (hasCast) ...[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Cast',
                style: AppStyles.bold24Roboto.copyWith(color: AppColors.white),
              ),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: movie.cast!.length,
              itemBuilder: (context, index) {
                final castMember = movie.cast![index];
                final characterName =
                    castMember['character'] ?? 'Unknown Character';

                return MovieCast(
                  name: castMember['name'] ?? 'Unknown',
                  character: characterName,
                  image: castMember['image'] ??
                      'assets/images/placeholder_cast.png',
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 16),
            ),
          ] else ...[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Cast',
                style: AppStyles.bold24Roboto.copyWith(color: AppColors.white),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'No cast information available',
              style: AppStyles.regular16Roboto.copyWith(color: AppColors.grey),
            ),
          ],
        ],
      ),
    );
  }
}
