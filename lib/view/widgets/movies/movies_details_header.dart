import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app/core/constants/styles/app_assets.dart';
import 'package:movies_app/core/constants/styles/app_colors.dart';
import 'package:movies_app/core/constants/styles/app_styles.dart';

class MoviesDetailsHeader extends StatelessWidget {
  const MoviesDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: screenSize.height * .70,
          width: double.infinity,
          padding: EdgeInsets.only(right: 16, left: 16, top: 29, bottom: 8),
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill, image: AssetImage(AppAssets.test))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 29,
                        color: AppColors.white,
                      )),
                  IconButton(
                      onPressed: () {
                        // add to fav list
                      },
                      icon: Icon(
                        Icons.bookmark,
                        size: 29,
                        color: AppColors.white,
                      )),
                ],
              ),
              SvgPicture.asset(AppAssets.watchIcon),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'Doctor Strange in the Multiverse of Madness',
                      style: AppStyles.bold24Roboto,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    '2022',
                    style: AppStyles.bold20Roboto,
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          color: AppColors.red,
        ),
      ],
    );
  }
}
