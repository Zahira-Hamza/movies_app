import 'package:flutter/material.dart';
class CustomFilmPoster extends StatelessWidget {
  final String imagePath;
  final String rating;
  final double? height;
  final double? width;

  const CustomFilmPoster({
    Key? key,
    required this.imagePath,
    required this.rating,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        ClipRRect(borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            height: height ?? screenSize.height * 0.26,
            width: width ?? screenSize.width * 0.33,
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
                    height: 20,
                    width: 20,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );

  }

}