import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/core/constants/app_styles.dart';

class CustomeElevatedButton extends StatelessWidget {
  const CustomeElevatedButton({super.key, required this.label, this.width,required this.onPressed});

  final String label;
  final double? width;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            fixedSize: Size(width ?? MediaQuery.sizeOf(context).width, 56)),
        child: Text(
          label,
          style: AppStyles.regularRoboto
              .copyWith(color: AppColors.blackPrimaryColor, fontSize: 20),
        ));
  }
}
