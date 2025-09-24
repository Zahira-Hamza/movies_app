import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/constants/styles/app_assets.dart';
import 'package:movies_app/core/constants/styles/app_colors.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ToggleSwitchLanguage extends StatelessWidget {
  final Function(Locale) onLocaleChange;
  final int initialIndex;

  const ToggleSwitchLanguage({
    super.key,
    required this.onLocaleChange,
    this.initialIndex = 1, 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: AppColors.yellowPrimaryColor),
          borderRadius: BorderRadius.circular(30)),
      child: ToggleSwitch(
        minWidth: 50,
        minHeight: 30,
        activeBgColor: const [AppColors.yellowPrimaryColor],
        inactiveBgColor: Colors.transparent,
        initialLabelIndex: initialIndex,
        totalSwitches: 2,
        customWidgets: [
          SvgPicture.asset(AppAssets.arabicIcon),
          SvgPicture.asset(AppAssets.englishIcon),
        ],
        onToggle: (index) {
          if (index == 0) {
            onLocaleChange(const Locale('ar'));
          } else {
            onLocaleChange(const Locale('en'));
          }
        },
      ),
    );
  }
}
