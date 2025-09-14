import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomFilmPoster extends StatelessWidget {
  final String imagePath;
  final String rating;
  final double? height;
  final double? width;
  final VoidCallback? onTap;

  const CustomFilmPoster({
    super.key,
    required this.imagePath,
    required this.rating,
    this.height,
    this.width,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: imagePath.isNotEmpty // التحقق من أن imagePath ليست فارغة
                ? CachedNetworkImage(
                    imageUrl: imagePath,
                    fit: BoxFit.cover,
                    height: height ?? screenSize.height * 0.26,
                    width: width ?? screenSize.width * 0.33,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                : Container(
                    // صورة بديلة إذا كانت imagePath فارغة
                    height: height ?? screenSize.height * 0.26,
                    width: width ?? screenSize.width * 0.33,
                    color: Colors.grey,
                    child: const Icon(Icons.movie, size: 50),
                  ),
          ),
          Positioned(
            top: 5,
            left: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Text(
                    rating,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  const SizedBox(width: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/star.png',
                      height: 15,
                      width: 15,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
