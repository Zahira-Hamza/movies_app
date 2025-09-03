import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/constants/styles/app_colors.dart';
import 'package:movies_app/core/constants/styles/app_styles.dart';

class UpdateProfile extends StatefulWidget {
  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final List<String> avatars = [
    'assets/images/avatars/avatar 1.png',
    'assets/images/avatars/avatar 2.png',
    'assets/images/avatars/avatar 3.png',
    'assets/images/avatars/avatar 4.png',
    'assets/images/avatars/avatar 5.png',
    'assets/images/avatars/avatar 6.png',
    'assets/images/avatars/avatar 7.png',
    'assets/images/avatars/avatar 8.png',
    'assets/images/avatars/avatar 9.png',
  ];

  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.blackPrimaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.blackPrimaryColor,
        centerTitle: true,
        title: Text(
          'Pick Avatar',
          style: AppStyles.regular16white
              .copyWith(color: AppColors.yellowPrimaryColor, fontSize: 18),
        ),
       
      ),
      body: Column(
        children: [
          SizedBox(
            height: screenSize.height * .03,
          ),
          GestureDetector(
            onTap: () => bottomSheet(context),
            child: Center(
              child: Image.asset(
                avatars[selectedIndex],
                height: screenSize.height * .16,
                width: screenSize.height * .16,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            height: screenSize.height * .03,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                        fillColor: AppColors.grey,
                        filled: true,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 18.0, right: 15),
                          child: SvgPicture.asset(
                            'assets/icons/person.svg',
                            height: screenSize.height * .03,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                  ),
                  SizedBox(
                    height: screenSize.height * .02,
                  ),
                  TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                        fillColor: AppColors.grey,
                        filled: true,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 18, right: 15),
                          child: SvgPicture.asset(
                            'assets/icons/phone.svg',
                            height: screenSize.height * .03,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                  ),
                  SizedBox(
                    height: screenSize.height * .015,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Reset Password',
                      style: AppStyles.semiBold20black.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    height: screenSize.height * .06,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          backgroundColor: AppColors.red),
                      child: Text('Delete Account',
                          style: AppStyles.semiBold20black
                              .copyWith(color: AppColors.white)),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * .022,
                  ),
                  SizedBox(
                    height: screenSize.height * .06,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          backgroundColor: AppColors.yellowPrimaryColor),
                      child:
                          Text('Update Data', style: AppStyles.semiBold20black),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * .036,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void bottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(14.0),
          child: Container(
            padding: EdgeInsets.all(16),
            height: MediaQuery.sizeOf(context).height * .42,
            decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(24)),
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    itemCount: avatars.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 19,
                      crossAxisSpacing: 18,
                    ),
                    itemBuilder: (context, index) {
                      bool isSeleected = index == selectedIndex;

                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            Navigator.of(context).pop();
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: isSeleected
                                ? AppColors.yellowPrimaryColor
                                : Colors.transparent,
                            border:
                                Border.all(color: AppColors.yellowPrimaryColor),
                          ),
                          child: CircleAvatar(
                            backgroundImage: AssetImage(avatars[index]),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
