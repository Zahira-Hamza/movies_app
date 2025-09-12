import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/constants/styles/app_colors.dart';
import 'package:movies_app/core/constants/styles/app_styles.dart';
import 'package:movies_app/core/routes/app_routes.dart';
import 'package:movies_app/core/utils/ui_utils.dart';
import 'package:movies_app/core/utils/validators.dart';
import 'package:movies_app/data/models/user_profile/update_user_profile_request.dart';
import 'package:movies_app/view/screens/update_profile/reset_password_dialog.dart';
import 'package:movies_app/view/widgets/custom_text_form_field.dart';
import 'package:movies_app/view/widgets/custome_elevated_button.dart';
import 'package:movies_app/view_model/profile/profile_cubit.dart';
import 'package:movies_app/view_model/profile/profile_states.dart';

import '../../../core/constants/styles/app_assets.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
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

  int currentAvatar = 0;

  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  final _updateFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<ProfileCubit>(context).getProfile();
    });
  }

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
          BlocBuilder<ProfileCubit, ProfileStates>(builder: (context, state) {
            if (state is GetProfileSuccess) {
              currentAvatar = state.user.avaterId;
            }
            return GestureDetector(
              onTap: () => bottomSheet(context),
              child: Center(
                child: Image.asset(
                  avatars[currentAvatar],
                  height: screenSize.height * .16,
                  width: screenSize.height * .16,
                  fit: BoxFit.fill,
                ),
              ),
            );
          }),
          SizedBox(
            height: screenSize.height * .03,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: BlocConsumer<ProfileCubit, ProfileStates>(
                listener: (context, state) {
                  if (state is GetProfileLoading) {
                    UIUtils.showLoading(context);
                  } else if (state is GetProfileError) {
                    UIUtils.hideLoading(context);

                    UIUtils.showMessage(state.message, context, AppColors.red);
                  } else if (state is GetProfileSuccess) {
                    UIUtils.hideLoading(context);
                    nameController.text = state.user.name;
                    phoneController.text =
                        state.user.phone.replaceFirst("+2", "");
                  }
                },
                builder: (context, state) => Form(
                  key: _updateFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                        controller: nameController,
                        image: AppAssets.nameIcon,
                        hint: 'name',
                        validator: (value) {
                          return Validators.validateName(value);
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
                          return Validators.validatePhone(value);
                        },
                      ),
                      SizedBox(
                        height: screenSize.height * .015,
                      ),
                      TextButton(
                        onPressed: () => showResetPasswordDialog(
                          context,
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
                        child: BlocListener<ProfileCubit, ProfileStates>(
                          listener: (context, state) {
                            if (state is DeleteProfileLoading) {
                              UIUtils.showLoading(context);
                            } else if (state is DeleteProfileError) {
                              UIUtils.hideLoading(context);
                              UIUtils.showMessage(
                                  state.message, context, AppColors.red);
                            } else if (state is DeleteProfileSuccess) {
                              UIUtils.hideLoading(context);
                              Navigator.of(context).pushReplacementNamed(
                                  AppRoutes.loginScreenRoute);
                            }
                          },
                          child: CustomeElevatedButton(
                            label: 'Delete Account',
                            backGrounColor: AppColors.red,
                            labelColor: AppColors.white,
                            onPressed: () {
                              showDeleteAccountDialog(context);
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * .022,
                      ),
                      SizedBox(
                        height: screenSize.height * .06,
                        width: double.infinity,
                        child: BlocListener<ProfileCubit, ProfileStates>(
                          listener: (context, state) {
                            if (state is UpdateProfileLoading) {
                              UIUtils.showLoading(context);
                            } else if (state is UpdateProfileError) {
                              UIUtils.hideLoading(context);
                              UIUtils.showMessage(
                                  state.message, context, AppColors.red);
                            } else if (state is UpdateProfileSuccess) {
                              UIUtils.hideLoading(context);
                              UIUtils.showMessage(state.message, context,
                                  AppColors.yellowPrimaryColor);
                            }
                          },
                          child: CustomeElevatedButton(
                            label: 'Update Data',
                            onPressed: () async {
                              if (_updateFormKey.currentState!.validate()) {
                                BlocProvider.of<ProfileCubit>(context)
                                    .updateProfile(UpdateUserProfileRequest(
                                        avatarId: currentAvatar,
                                        name: nameController.text,
                                        phone: phoneController.text));
                              }
                            },
                            labelColor: AppColors.blackPrimaryColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * .036,
                      )
                    ],
                  ),
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
                      bool isSeleected = index == currentAvatar;

                      return InkWell(
                        onTap: () {
                          setState(() {
                            currentAvatar = index;
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
          builder: (ctx) => BlocProvider<ProfileCubit>(
            create: (context) => ProfileCubit(),
            child: AlertDialog(
              backgroundColor: AppColors.boldgrey,
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
                    style: TextStyle(color: AppColors.white, fontSize: 16),
                  ),
                ],
              ),
              actionsAlignment: MainAxisAlignment.spaceEvenly,
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.white,
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  ),
                  onPressed: () => Navigator.of(ctx).pop(false),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.red,
                    foregroundColor: AppColors.white,
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    textStyle: TextStyle(fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    BlocProvider.of<ProfileCubit>(context).deleteProfile();
                  },
                  child: Text('Delete'),
                ),
              ],
            ),
          ),
        ) ??
        false;
  }
}
