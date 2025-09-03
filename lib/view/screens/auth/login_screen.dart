import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/styles/app_assets.dart';
import 'package:movies_app/core/constants/styles/app_colors.dart';
import 'package:movies_app/core/routes/app_routes.dart';
import 'package:movies_app/core/utils/validators.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/view/widgets/auth/toggle_switch_language.dart';
import 'package:movies_app/view/widgets/custom_text_form_field.dart';
import 'package:movies_app/view/widgets/custome_elevated_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isEnglish = true;
  int initialIndex = 0;

  void _showLoginSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Login Successful",
          style: TextStyle(color: AppColors.grey),
        ),
        backgroundColor: AppColors.yellowPrimaryColor,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _handleLogin() {
    if (formKey.currentState?.validate() ?? false) {
      _showLoginSnackbar();
      // Add a small delay before navigation to show the snackbar
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.of(context).pushNamed(AppRoutes.bottomNavBarRoute);
      });
    }
  }

  void _handleGoogleLogin() {
    // Direct navigation without snackbar for Google login
    Navigator.of(context).pushNamed(AppRoutes.bottomNavBarRoute);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 50),
                Center(
                  child: Image.asset(
                    AppAssets.appLogo,
                    height: MediaQuery.sizeOf(context).height * 0.12,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomTextFormField(
                    hint: AppLocalizations.of(context)!.email,
                    controller: emailController,
                    image: AppAssets.emailIcon,
                    validator: (value) {
                      return Validators.validateEmail(value);
                    },
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomTextFormField(
                    hint: AppLocalizations.of(context)!.password,
                    image: AppAssets.passwordIcon,
                    controller: passwordController,
                    validator: (value) {
                      return Validators.validatePassword(value);
                    },
                    isPassword: true,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.forgetPasswordRoute);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.forgot_password,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: AppColors.yellowPrimaryColor),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomeElevatedButton(
                      label: AppLocalizations.of(context)!.login,
                      onPressed:
                          _handleLogin, // Use the new method with snackbar
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.dont_have_account,
                      style: TextStyle(color: AppColors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.registerRoute);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.create_one,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: AppColors.yellowPrimaryColor),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: AppColors.yellowPrimaryColor,
                        thickness: 1,
                        indent: 50,
                        endIndent: 10,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.or,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: AppColors.yellowPrimaryColor),
                    ),
                    Expanded(
                      child: Divider(
                        color: AppColors.yellowPrimaryColor,
                        thickness: 1,
                        indent: 10,
                        endIndent: 50,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomeElevatedButton(
                    label: AppLocalizations.of(context)!.login_with_google,
                    onPressed:
                        _handleGoogleLogin, // Use the method without snackbar
                  ),
                ),
                SizedBox(height: 16),
                ToggleSwitchLanguage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
