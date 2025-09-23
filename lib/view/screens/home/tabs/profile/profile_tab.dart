import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/styles/app_colors.dart';
import 'package:movies_app/core/constants/styles/app_styles.dart';
import 'package:movies_app/core/routes/app_routes.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/view/widgets/custome_elevated_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.grey2,
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            SizedBox(height: 52.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/avatars/avatar 1.png',
                        height: 118.h,
                      ),
                      SizedBox(height: 15.h),
                      Text('John Safwat', style: AppStyles.bold20white),
                    ],
                  ),
                  Column(
                    children: [
                      Text('12',
                          style:
                              AppStyles.bold20white.copyWith(fontSize: 32.sp)),
                      SizedBox(height: 20.h),
                      Text(AppLocalizations.of(context)!.wish_list,
                          style:
                              AppStyles.bold20white.copyWith(fontSize: 22.sp)),
                    ],
                  ),
                  Column(
                    children: [
                      Text('10',
                          style:
                              AppStyles.bold20white.copyWith(fontSize: 32.sp)),
                      SizedBox(height: 20.h),
                      Text(AppLocalizations.of(context)!.history,
                          style:
                              AppStyles.bold20white.copyWith(fontSize: 22.sp)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 23.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Row(
                children: [
                  CustomeElevatedButton(
                    label: AppLocalizations.of(context)!.delete,
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.updateProfileScreenRoute);
                    },
                    width: 253.w,
                  ),
                  SizedBox(width: 10.w),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                      backgroundColor: AppColors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      fixedSize: Size(135.w, 56.h),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppLocalizations.of(context)!.delete, style: AppStyles.regular20white),

                        SizedBox(width: 10.w),
                        Icon(Icons.logout, color: AppColors.white, size: 20.sp),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 33.h),
            TabBar(
              dividerColor: AppColors.transparent,
              indicatorColor: AppColors.yellowPrimaryColor,
              indicatorSize: TabBarIndicatorSize.tab,
              isScrollable: false,
              tabs: [
                Column(
                  children: [
                    SvgPicture.asset(
                      'assets/images/icons/watch list.svg',
                      fit: BoxFit.scaleDown,
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.only(bottom: 18.0.h),
                      child:
                          Text('Wish List', style: AppStyles.regular20white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SvgPicture.asset(
                      'assets/images/icons/history.svg',
                      fit: BoxFit.scaleDown,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 18.0.h),
                      child: Text('History', style: AppStyles.regular20white),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: Container(
                color: AppColors.blackPrimaryColor,
                child: TabBarView(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/empty.png',
                        height: 124.h,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Center(
                      child: Image.asset(
                        'assets/images/empty.png',
                        height: 124.h,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
