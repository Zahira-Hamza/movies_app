import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/styles/app_colors.dart';
import 'package:movies_app/core/constants/styles/app_styles.dart';

class CustomeElevatedButton extends StatelessWidget {
  const CustomeElevatedButton({
    Key? key,
    required this.label,
    this.width,
    required this.onPressed,
  }) : super(key: key);

  final String label;
  final double? width;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          backgroundColor: AppColors.yellowPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            label,
            style: AppStyles.regularRoboto.copyWith(
              color: AppColors.blackPrimaryColor,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
            maxLines: 2, // ← مهم عشان يدعم سطرين لو النص طويل
            softWrap: true,
          ),
        ),
      ),
    );
  }
}

