import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/styles/app_colors.dart';
import 'package:movies_app/core/constants/styles/app_styles.dart';
import 'package:movies_app/view/widgets/custom_text_form_field.dart';
import 'package:movies_app/view/widgets/custome_elevated_button.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

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
                  CustomTextFormField(
                      image: 'assets/icons/person.svg', hint: 'name'),
                  SizedBox(
                    height: screenSize.height * .02,
                  ),
                  CustomTextFormField(
                      image: 'assets/icons/phone.svg', hint: 'phone'),
                  SizedBox(
                    height: screenSize.height * .015,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Reset Password',
                      style: AppStyles.regular16white.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                      height: screenSize.height * .06,
                      width: double.infinity,
                      child: CustomeElevatedButton(
                        label: 'Delete Account',
                        backGrounColor: AppColors.red,
                        labelColor: AppColors.white,
                        onPressed: () {},
                      )),
                  SizedBox(
                    height: screenSize.height * .022,
                  ),
                  SizedBox(
                    height: screenSize.height * .06,
                    width: double.infinity,
                    child: CustomeElevatedButton(
                      label: 'Update Data',
                      onPressed: () {},
                      labelColor: AppColors.blackPrimaryColor,
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
                color: AppColors.grey, borderRadius: BorderRadius.circular(24)),
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
