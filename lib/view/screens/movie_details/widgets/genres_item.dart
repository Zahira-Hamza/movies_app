import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/styles/app_colors.dart';
import 'package:movies_app/core/constants/styles/app_styles.dart';

class GenresItem extends StatelessWidget {
  const GenresItem({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      margin: EdgeInsets.only(bottom: 11),
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: AppColors.grey, borderRadius: BorderRadius.circular(12)),
      child: Text(
        type,
        style: AppStyles.regular16Roboto.copyWith(color: AppColors.white),
      ),
    );
  }
}
