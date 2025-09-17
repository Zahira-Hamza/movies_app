import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/constants/styles/app_colors.dart';
import 'package:movies_app/core/constants/styles/app_styles.dart';
import 'package:movies_app/data/models/movies/movie_model.dart';
import 'package:movies_app/view/screens/movie_details/widgets/screen_shot_item.dart';

class ScreenshotsSection extends StatelessWidget {
  final MovieModel movie;

  const ScreenshotsSection({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final hasScreenshots =
        movie.screenshots != null && movie.screenshots!.isNotEmpty;

    if (!hasScreenshots) {
      return const SizedBox.shrink();
    }

    // أخذ أول 4 screenshots فقط
    final screenshotsToShow = movie.screenshots!.take(4).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Screen Shots',
            style: AppStyles.bold24Roboto.copyWith(color: AppColors.white),
          ),
          SizedBox(height: 9.h),
          ListView.separated(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: screenshotsToShow.length,
            itemBuilder: (context, index) {
              return ScreenShotItem(screenshot: screenshotsToShow[index]);
            },
            separatorBuilder: (context, index) => SizedBox(
              height: 13.h,
            ),
          ),
        ],
      ),
    );
  }
}
