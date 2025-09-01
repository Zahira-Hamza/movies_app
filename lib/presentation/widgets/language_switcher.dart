import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/app_colors.dart';

class LanguageSwitcher extends StatefulWidget {

  @override
  _LanguageSwitcherState createState() => _LanguageSwitcherState();
}

class _LanguageSwitcherState extends State<LanguageSwitcher> {
  bool isEnglish = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isEnglish = !isEnglish;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        width: 100,
        height: 45,
        decoration: BoxDecoration(
          color: AppColors.blackPrimaryColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: AppColors.yellowPrimaryColor,
            width: 2,
          ),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              left: isEnglish ? 0 : 57,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color:AppColors.yellowPrimaryColor,
                    width: 3,
                  ),
                  color: AppColors.blackPrimaryColor,
                  image: DecorationImage(
                    image: AssetImage(
                      isEnglish ? 'assets/images/usa_flag.png' : 'assets/images/eg_flag.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
