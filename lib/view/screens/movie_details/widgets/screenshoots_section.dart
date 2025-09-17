import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/styles/app_colors.dart';
import 'package:movies_app/core/constants/styles/app_styles.dart';
import 'package:movies_app/data/models/movies/movie_model.dart';

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

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      color: AppColors.grey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Screen Shots',
            style: AppStyles.bold24Roboto.copyWith(color: AppColors.white),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: screenshotsToShow.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      screenshotsToShow[index],
                      width: 300,
                      height: 200,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          width: 300,
                          height: 200,
                          color: AppColors.grey,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.yellowPrimaryColor,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 300,
                          height: 200,
                          color: AppColors.grey,
                          child: const Icon(
                            Icons.broken_image,
                            color: AppColors.white,
                            size: 40,
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
