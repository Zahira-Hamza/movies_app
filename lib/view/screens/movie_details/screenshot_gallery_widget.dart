// features/movie_details/presentation/widgets/screenshot_gallery_widget.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../data/models/movies/movie_model.dart';

/// ويدجت لعرض لقطات الشاشة في معرض شرائح
class ScreenshotGalleryWidget extends StatelessWidget {
  final MovieModel movie;

  const ScreenshotGalleryWidget({Key? key, required this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // في التطبيق الحقيقي، ستحصل على لقطات الشاشة من API
    // هنا نستخدم صورة الغلاف كبديل للعرض التوضيحي
    final demoImages = [
      movie.largeCoverImage,
      movie.mediumCoverImage,
      movie.backgroundImage,
    ];

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: demoImages.length,
        itemBuilder: (context, index) {
          return Container(
            width: 300,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: demoImages[index],
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[300],
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
