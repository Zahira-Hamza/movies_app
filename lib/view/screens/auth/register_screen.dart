import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/styles/app_assets.dart';
import 'package:movies_app/core/constants/styles/app_colors.dart';
import 'package:movies_app/core/constants/styles/app_styles.dart';
import 'package:movies_app/core/utils/validators.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/view/widgets/auth/carousel_avatares.dart';
import 'package:movies_app/view/widgets/auth/toggle_switch_language.dart';
import 'package:movies_app/view/widgets/custom_text_form_field.dart';
import 'package:movies_app/view/widgets/custome_elevated_button.dart';

import '../../../core/routes/app_routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.register),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: screenSize.height * .17,
                width: double.infinity,
                child: CarouselAvatares(),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: screenSize.height * .557,
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextFormField(
                        image: AppAssets.nameIcon,
                        hint: AppLocalizations.of(context)!.name,
                        controller: nameController,
                        validator: (value) {
                          return Validators.validateName(value);
                        },
                      ),
                      CustomTextFormField(
                        image: AppAssets.emailIcon,
                        hint: AppLocalizations.of(context)!.email,
                        controller: emailController,
                        validator: (value) {
                          return Validators.validateEmail(value);
                        },
                      ),
                      CustomTextFormField(
                        image: AppAssets.passwordIcon,
                        hint: AppLocalizations.of(context)!.password,
                        isPassword: true,
                        controller: passwordController,
                        validator: (value) {
                          return Validators.validatePassword(value);
                        },
                      ),
                      CustomTextFormField(
                        image: AppAssets.passwordIcon,
                        hint: AppLocalizations.of(context)!.confirm_password,
                        isPassword: true,
                        controller: confirmPasswordController,
                        validator: (value) {
                          return Validators.validateConfirmPassword(
                              value, passwordController.text);
                        },
                      ),
                      CustomTextFormField(
                        image: AppAssets.phoneIcon,
                        hint: AppLocalizations.of(context)!.phone_number,
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          return Validators.validatePhone(value);
                        },
                      ),
                      CustomeElevatedButton(
                          onPressed: () {
                            // Validate the form first
                            if (formKey.currentState!.validate()) {
                              // If form is valid, show success snackbar
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Registration Successful",
                                    style: AppStyles.regularRoboto
                                        .copyWith(color: AppColors.grey),
                                  ),
                                  backgroundColor: AppColors
                                      .yellowPrimaryColor, // You might want to define this color
                                  duration: const Duration(seconds: 3),
                                  behavior: SnackBarBehavior.floating,
                                  // Optional: Add action to navigate to login
                                  action: SnackBarAction(
                                    label: AppLocalizations.of(context)!.login,
                                    textColor: AppColors.grey,
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          AppRoutes.bottomNavBarRoute);
                                    },
                                  ),
                                ),
                              );

                              // Here you would typically send the data to your backend
                              // and navigate to the next screen after successful registration
                            }
                          },
                          label: AppLocalizations.of(context)!.create_account),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.have_account,
                    style: AppStyles.regularRoboto
                        .copyWith(fontSize: 14, color: AppColors.white),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(AppLocalizations.of(context)!.login,
                          style:
                              AppStyles.regularRoboto.copyWith(fontSize: 14)))
                ],
              ),
              ToggleSwitchLanguage(),
            ],
          ),
        ),
      ),
    );
  }
}
