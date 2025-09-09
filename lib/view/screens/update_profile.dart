import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/styles/app_colors.dart';
import 'package:movies_app/core/constants/styles/app_styles.dart';
import 'package:movies_app/core/routes/app_routes.dart';
import 'package:movies_app/data/models/auth/reset_password_data.dart';
import 'package:movies_app/data/models/user/user_profile.dart';
import 'package:movies_app/view/screens/update_profile/reset_password_dialog.dart';
import 'package:movies_app/view/widgets/custom_text_form_field.dart';
import 'package:movies_app/view/widgets/custome_elevated_button.dart';
import 'package:movies_app/view_model/auth/auth_api_service.dart';
import 'package:movies_app/view_model/profile_api_service.dart';

import '../../core/constants/styles/app_assets.dart';

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

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  UserProfile userProfile = UserProfile();

  int selectedIndex = 0;
  final profileApiService = ProfileApiService();

  @override
  void initState() {
    super.initState();
    nameController.text = userProfile.name ?? '';
    phoneController.text = userProfile.phone ?? '';
  }

  final _updateFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
              child: Form(
                key: _updateFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormField(
                      controller: nameController,
                      image: 'assets/images/icons/person.svg',
                      hint: 'name',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your name';
                        }
                        if (value.trim().length < 3) {
                          return 'Name must be at least 3 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: screenSize.height * .02,
                    ),
                    CustomTextFormField(
                      controller: phoneController,
                      image: AppAssets.phoneIcon,
                      hint: 'phone',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your phone number';
                        }
                        final phoneRegExp = RegExp(r'^\+201[0-9]{8,9}$');
                        if (!phoneRegExp.hasMatch(value.trim())) {
                          return 'Enter a valid phone number starting with +201';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: screenSize.height * .015,
                    ),
                    TextButton(
                      onPressed: () => showResetPasswordDialog(
                        context,
                        (oldPassword, newPassword) async {
                          ResetPasswordData resetData = ResetPasswordData(
                              oldPassword: oldPassword,
                              newPassword: newPassword);
                          try {
                            final AuthApiService apiService = AuthApiService();
                            final message = await apiService.resetPassword(
                                data: resetData,
                                token:
                                    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4YzA5YmU5ZThhOGZmNWEyN2M3NGQ3MCIsImVtYWlsIjoib29tbWFhcnIxMTFAZ21haWwuY29tIiwiaWF0IjoxNzU3NDUzMzMwfQ.nsb2sYAb-5P1ImsDVdsyASbfNV5rWs3K7Vwu-iBGbK4');
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                message,
                                style: TextStyle(
                                    color: AppColors.white, fontSize: 16),
                              ),
                              backgroundColor: Colors.green,
                              duration: Duration(milliseconds: 800),
                            ));
                          } catch (error) {
                            print(error.toString());
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                'Failed To Reset The Password',
                                style: TextStyle(
                                    color: AppColors.white, fontSize: 16),
                              ),
                              backgroundColor: Colors.red,
                              duration: Duration(milliseconds: 800),
                            ));
                          }
                        },
                      ),
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
                        onPressed: () async {
                          try {
                            bool confirm =
                                await showDeleteAccountDialog(context);
                            if (!confirm) return;
                            final message = await profileApiService.deleteAccount(
                                token:
                                    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4YzA5MzBiZGFlNWFiMjM1YThhODU5YyIsImVtYWlsIjoib29tbWFhcnIxQGdtYWlsLmNvbSIsImlhdCI6MTc1NzQ1MTA1N30.5rb05cC1RdgxwLXJk--tRO27UQ0LOxfSHs-JVaRtzSA');
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                message,
                                style: TextStyle(
                                    color: AppColors.white, fontSize: 16),
                              ),
                              backgroundColor: Colors.green,
                              duration: Duration(milliseconds: 800),
                            ));
                            Navigator.of(context)
                                .pushReplacementNamed(AppRoutes.loginRoute);
                          } catch (error) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                'Failed To Delete The Account',
                                style: TextStyle(
                                    color: AppColors.white, fontSize: 16),
                              ),
                              backgroundColor: Colors.red,
                              duration: Duration(milliseconds: 800),
                            ));
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * .022,
                    ),
                    SizedBox(
                      height: screenSize.height * .06,
                      width: double.infinity,
                      child: CustomeElevatedButton(
                        label: 'Update Data',
                        onPressed: () async {
                          if (_updateFormKey.currentState!.validate()) {
                            try {
                              final message = await profileApiService.updateData(
                                  profile: UserProfile(
                                      name: nameController.text.trim(),
                                      phone: phoneController.text.trim()),
                                  token:
                                      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4YzA5MzBiZGFlNWFiMjM1YThhODU5YyIsImVtYWlsIjoib29tbWFhcnIxQGdtYWlsLmNvbSIsImlhdCI6MTc1NzQ1MTA1N30.5rb05cC1RdgxwLXJk--tRO27UQ0LOxfSHs-JVaRtzSA');
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  message,
                                  style: TextStyle(
                                      color: AppColors.white, fontSize: 16),
                                ),
                                backgroundColor: Colors.green,
                                duration: Duration(milliseconds: 800),
                              ));
                            } catch (error) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  'Failed To Update Data',
                                  style: TextStyle(
                                      color: AppColors.white, fontSize: 16),
                                ),
                                backgroundColor: AppColors.red,
                                duration: Duration(milliseconds: 800),
                              ));
                            }
                          }
                        },
                        labelColor: AppColors.blackPrimaryColor,
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * .036,
                    )
                  ],
                ),
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

  Future<bool> showDeleteAccountDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: const Color(0xFF1A1A1A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Center(
              child: Text(
                'Delete Account',
                style: TextStyle(
                  color: AppColors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.warning,
                    size: 50, color: AppColors.yellowPrimaryColor),
                SizedBox(height: 16),
                Text(
                  'Are you sure you want to delete your account ?\n\nThis action cannot be undone.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                ),
                onPressed: () => Navigator.of(ctx).pop(false),
                child: Text('Cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.red,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  textStyle: TextStyle(fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => Navigator.of(ctx).pop(true),
                child: Text('Delete'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
