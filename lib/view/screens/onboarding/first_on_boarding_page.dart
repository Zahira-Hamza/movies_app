import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/styles/app_assets.dart';

import '../../../core/constants/styles/app_colors.dart';
import '../../../core/constants/styles/app_styles.dart';

class FirstOnboardingPage extends StatelessWidget {
  final VoidCallback onNext;

  const FirstOnboardingPage({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          AppAssets.onBoardingPage1,
          fit: BoxFit.cover,
        ),

        /////////////////////text,button////////////////////////////////
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.07,
            vertical: screenHeight * 0.03, // مسافة من تحت
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min, // يخلي العمود على قد محتوياته
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Find Your Next Favorite Movie Here",
                  style: AppStyles.medium28white,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.015),
                Text(
                  maxLines: 2,
                  "Get access to a huge library of movies to suit all tastes. You will surely like it.",
                  style: AppStyles.regular16gray,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.04),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: onNext,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.015,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: AppColors.yellowPrimaryColor,
                      ),
                      child:
                          Text("Explore Now", style: AppStyles.semiBold20black),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
