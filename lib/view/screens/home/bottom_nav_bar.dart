import 'package:flutter/material.dart';
import 'package:movies_app/view/screens/home/tabs/browse/browse_tab.dart';
import 'package:movies_app/view/screens/home/tabs/home/home_tab.dart';
import 'package:movies_app/view/screens/home/tabs/profile/profile_tab.dart';
import 'package:movies_app/view/screens/home/tabs/search/search_tab.dart';

import '../../../core/constants/styles/app_assets.dart';
import '../../../core/constants/styles/app_colors.dart';
import '../../../data/models/categories/category_model.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    List<Widget> tabs = [
      HomeTab(
        selectedCategoryIndex: selectedCategoryIndex,
        onCategoryChanged: (newIndex) {
          setState(() {
            selectedCategoryIndex = newIndex;
          });
        },
      ),
      const SearchTab(),
      const BrowseTab(),
      const ProfileTab(),
    ];

    return Scaffold(
      extendBody: true,
      body: tabs[selectedIndex],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.02, vertical: screenHeight * 0.01),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index) {
              // If we're returning to the home tab, change the category
              if (index == 0 && selectedIndex != 0) {
                setState(() {
                  selectedCategoryIndex = (selectedCategoryIndex + 1) % CategoryModel.categories.length;
                });
              }

              setState(() {
                selectedIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              _buildBottomNavigationBarItem(
                index: 0,
                unselectedIconName: AppAssets.homeTab,
                selectedIconName: AppAssets.homeTabSelected,
              ),
              _buildBottomNavigationBarItem(
                index: 1,
                unselectedIconName: AppAssets.searchTab,
                selectedIconName: AppAssets.searchTabSelected,
              ),
              _buildBottomNavigationBarItem(
                index: 2,
                unselectedIconName: AppAssets.browseTab,
                selectedIconName: AppAssets.browseTabSelected,
              ),
              _buildBottomNavigationBarItem(
                index: 3,
                unselectedIconName: AppAssets.profileTab,
                selectedIconName: AppAssets.profileTab,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({
    required String unselectedIconName,
    required String selectedIconName,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: ImageIcon(
        AssetImage(unselectedIconName),
        color: selectedIndex == index
            ? AppColors.yellowPrimaryColor
            : AppColors.white,
      ),
      activeIcon: ImageIcon(
        AssetImage(selectedIconName),
        color: AppColors.yellowPrimaryColor,
      ),
      label: '',
    );
  }
}