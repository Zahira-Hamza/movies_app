import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/styles/app_colors.dart';
import 'package:movies_app/core/constants/styles/app_styles.dart';

 class CustomeElevatedButton extends StatelessWidget {
 const CustomeElevatedButton(
      {super.key,
      required this.label,
      this.width,
      required this.onPressed,
      this.backGrounColor,
      this.labelColor = AppColors.blackPrimaryColor});

  final String label;
  final double? width;
  final VoidCallback onPressed;
  final Color? backGrounColor;
  final Color? labelColor ;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: backGrounColor,
          fixedSize: Size(width ?? MediaQuery.sizeOf(context).width, 56)),
      child: Text(
        label,
        style:
            AppStyles.regularRoboto.copyWith(color: labelColor, fontSize: 20),
      ),
    );
  }
}
