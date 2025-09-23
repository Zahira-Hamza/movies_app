import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/constants/styles/app_assets.dart';
import 'package:movies_app/core/constants/styles/app_colors.dart';
import 'package:movies_app/core/constants/styles/app_styles.dart';
import 'package:movies_app/core/routes/app_routes.dart';
import 'package:movies_app/core/utils/ui_utils.dart';
import 'package:movies_app/data/models/movies/movie_basic_info.dart';
import 'package:movies_app/view/widgets/custome_elevated_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/view/widgets/movies/fav_history_movies.dart';
import 'package:movies_app/view_model/profile/profile_cubit.dart';
import 'package:movies_app/view_model/profile/profile_states.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final List<String> avatars = const [
    AppAssets.avatar1,
    AppAssets.avatar2,
    AppAssets.avatar3,
    AppAssets.avatar4,
    AppAssets.avatar5,
    AppAssets.avatar6,
    AppAssets.avatar7,
    AppAssets.avatar8,
    AppAssets.avatar9,
  ];

  List<MovieBasicInfo> favMovies = [];
  List<MovieBasicInfo> recentMovies = [];
  int avatarId = 0;
  String name = '';

  @override
  void initState() {
    log('i am in init');
    favMovies=context.read<ProfileCubit>().favMovies;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.grey2,
      child: DefaultTabController(
        length: 2,
        child: BlocConsumer<ProfileCubit, ProfileStates>(
          listener: (context, state) {
            if (state is GetProfileLoading || state is GetFavMoviesLoading ) {
              UIUtils.showLoading(context);
            } else if (state is GetProfileError) {
              UIUtils.hideLoading(context);
              UIUtils.showMessage(state.message, context, AppColors.red);
            } else if (state is GetProfileSuccess ||state is GetFavMoviesSuccess) {
              UIUtils.hideLoading(context);
            }
          },
          builder: (context, state) {
            if (state is GetFavMoviesSuccess || state is GetProfileSuccess) {
              avatarId = context.read<ProfileCubit>().user!.avaterId;
              name = context.read<ProfileCubit>().user!.name;
              favMovies = context.read<ProfileCubit>().favMovies;
              recentMovies = context.read<ProfileCubit>().historyMovies;
            }
            log('${favMovies.length}');
            final safeIndex = (avatarId).clamp(0, avatars.length - 1);
            return Column(
              children: [
                SizedBox(height: 52.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(children: [
                        Column(
                          children: [
                            Image.asset(
                              avatars[safeIndex],
                              height: 118.h,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(height: 15.h),
                            Text(
                              name,
                              style: AppStyles.bold20white,
                            ),
                          ],
                        )
                      ]),
                      Column(
                        children: [
                          Text(
                              '${context.read<ProfileCubit>().favMovies.length}',
                              style: AppStyles.bold20white
                                  .copyWith(fontSize: 32.sp)),
                          SizedBox(height: 20.h),
                          Text('Wish List',
                              style: AppStyles.bold20white
                                  .copyWith(fontSize: 22.sp)),
                        ],
                      ),
                      Column(
                        children: [
                          Text('${recentMovies.length}',
                              style: AppStyles.bold20white
                                  .copyWith(fontSize: 32.sp)),
                          SizedBox(height: 20.h),
                          Text('History',
                              style: AppStyles.bold20white
                                  .copyWith(fontSize: 22.sp)),
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
                        label: 'Edit Profile',
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.updateProfileScreenRoute);
                        },
                        width: 253.w,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            backgroundColor: AppColors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            fixedSize: Size(double.infinity, 56),
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Exit', style: AppStyles.regular20white),
                              SizedBox(width: 10.w),
                              Icon(Icons.logout,
                                  color: AppColors.white, size: 20.sp),
                            ],
                          ),
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
                          AppAssets.whishIcon,
                          fit: BoxFit.scaleDown,
                        ),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: EdgeInsets.only(bottom: 18.0.h),
                          child: Text('Wish List',
                              style: AppStyles.regular20white),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SvgPicture.asset(
                          AppAssets.historyIcon,
                          fit: BoxFit.scaleDown,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 18.0.h),
                          child:
                              Text('History', style: AppStyles.regular20white),
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
                        favMovies.isEmpty
                            ? Center(
                                child: Image.asset(
                                  AppAssets.emptyMovies,
                                  height: 124.h,
                                  fit: BoxFit.fill,
                                ),
                              )
                            : FavOrHistoryMovies(movies: favMovies),
                        recentMovies.isEmpty
                            ? Center(
                                child: Image.asset(
                                  AppAssets.emptyMovies,
                                  height: 124.h,
                                  fit: BoxFit.fill,
                                ),
                              )
                            : FavOrHistoryMovies(movies: recentMovies),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
