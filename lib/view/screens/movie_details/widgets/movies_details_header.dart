import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app/core/utils/ui_utils.dart';
import 'package:movies_app/view_model/movies/fav_movies_cubit.dart';
import 'package:movies_app/view_model/movies/fav_movies_states.dart';

import '../../../../core/constants/styles/app_assets.dart';
import '../../../../core/constants/styles/app_colors.dart';
import '../../../../core/constants/styles/app_styles.dart';
import '../../../../data/models/movies/movie_model.dart';

class MoviesDetailsHeader extends StatefulWidget {
  final MovieModel movie;

  const MoviesDetailsHeader({super.key, required this.movie});

  @override
  State<MoviesDetailsHeader> createState() => _MoviesDetailsHeaderState();
}

class _MoviesDetailsHeaderState extends State<MoviesDetailsHeader> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<FavMoviesCubit>(context)
          .isFavMovie(widget.movie.id.toString());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    final imageUrl = widget.movie.largeCoverImage ??
        widget.movie.mediumCoverImage ??
        widget.movie.backgroundImage;

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
          right: 1.w,
          child: BlocConsumer<FavMoviesCubit, FavMoviesStates>(
            listener: (context, state) {
              if (state is FavMoviesError) {
                UIUtils.showMessage(state.message, context, AppColors.red);
              }
            },
            builder: (context, state) {
              if (state is IsFavMovieSuccess) {
                return IconButton(
                  onPressed: () {},
                  icon: Icon(
                      state.isFav ? Icons.bookmark : Icons.bookmark_border,
                      color: Colors.white,
                      size: 29),
                );
              } else {
                return SizedBox.shrink();
              }
            },
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
                  widget.movie.titleLong ?? widget.movie.title,
                  style:
                      AppStyles.bold24Roboto.copyWith(color: AppColors.white),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 15),
                Text(
                  widget.movie.year.toString(),
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
