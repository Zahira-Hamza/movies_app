import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

    final imageUrl = movie.largeCoverImage ??
        movie.mediumCoverImage ??
        movie.backgroundImage;

    return Stack(
      children: [
        Container(
          height: screenSize.height * .70,
          width: double.infinity,
          decoration: BoxDecoration(
            image: imageUrl != null
                ? DecorationImage(
                    fit: BoxFit.fill,
                    image: CachedNetworkImageProvider(imageUrl),
                  )
                : null,
            color: AppColors.grey,
          ),
          child: imageUrl == null
              ? const Icon(Icons.movie, size: 100, color: Colors.white54)
              : null,
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                AppColors.blackPrimaryColor.withValues(alpha: .9),
                AppColors.blackPrimaryColor.withValues(alpha: 0.7),
                Colors.transparent,
                AppColors.blackPrimaryColor.withValues(alpha: 0.7),
                AppColors.blackPrimaryColor,
              ],
              stops: [0.0, 0.1, 0.5, 0.7, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
          ),
        ),
        Positioned(
          top: 29.h,
          left: 16.w,
          child: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon:
                const Icon(Icons.arrow_back_ios, color: Colors.white, size: 29),
          ),
        ),
        Positioned(
          top: 29.h,
          right: 16.w,
          child: IconButton(
            onPressed: () {
              // add to fav list
            },
            icon: const Icon(Icons.bookmark, color: Colors.white, size: 29),
          ),
        ),
        Positioned.fill(
          top: 250.h,
          child: SizedBox(
            child: Column(
              children: [
                SvgPicture.asset(AppAssets.watchIcon),
                Spacer(),
                Text(
                  movie.titleLong ?? movie.title,
                  style:
                      AppStyles.bold24Roboto.copyWith(color: AppColors.white),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 15),
                Text(
                  movie.year.toString(),
                  style:
                      AppStyles.bold20Roboto.copyWith(color: AppColors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
