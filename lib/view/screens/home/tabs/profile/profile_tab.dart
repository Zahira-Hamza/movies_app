import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/styles/app_colors.dart';
import 'package:movies_app/core/constants/styles/app_styles.dart';
import 'package:movies_app/core/routes/app_routes.dart';
import 'package:movies_app/view/widgets/custome_elevated_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return  Container(
      color: AppColors.grey2,
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            SizedBox(height: screenSize.height * .05),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/avatars/avatar 1.png',
                        height: screenSize.height * .126,
                      ),
                      SizedBox(height: 15),
                      Text('John Safwat', style: AppStyles.bold20white),
                    ],
                  ),
                  Column(
                    children: [
                      Text('12',
                          style: AppStyles.bold20white.copyWith(fontSize: 32)),
                      SizedBox(height: screenSize.height * .02),
                      Text('Wish List',
                          style: AppStyles.bold20white.copyWith(fontSize: 22)),
                    ],
                  ),
                  Column(
                    children: [
                      Text('10',
                          style: AppStyles.bold20white.copyWith(fontSize: 32)),
                      SizedBox(height: screenSize.height * .02),
                      Text('History',
                          style: AppStyles.bold20white.copyWith(fontSize: 22)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: screenSize.height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  CustomeElevatedButton(
                    label: 'Edit Profile',
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.updateProfileScreenRoute);
                    },
                    width: screenSize.width * .56,
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      backgroundColor: AppColors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      fixedSize: Size(screenSize.width * .33, 56),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Exit', style: AppStyles.regular20white),
                        SizedBox(width: 10),
                        Icon(Icons.logout, color: AppColors.white, size: 20),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: screenSize.height * 0.04),
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
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child:
                          Text('Watch List', style: AppStyles.regular20white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SvgPicture.asset(
                      'assets/images/icons/history.svg',
                      fit: BoxFit.scaleDown,
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
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
                        height: screenSize.width * .20,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Center(
                      child: Image.asset(
                        'assets/images/empty.png',
                        height: screenSize.width * .20,
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
