import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/styles/app_colors.dart';
import 'package:movies_app/core/constants/styles/app_styles.dart';

class MovieCast extends StatelessWidget {
  const MovieCast({super.key,required this.image,required this.character,required this.name});

  final String image;
  final String name;
  final String character;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(11),
      decoration: BoxDecoration(
          color: AppColors.grey, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(image),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name :$name',
                  style: AppStyles.regular16Roboto
                      .copyWith(color: AppColors.white),
                ),
                SizedBox(height: 5),
                Text(
                  'Character :$character',
                  style: AppStyles.regular16Roboto
                      .copyWith(color: AppColors.white),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
