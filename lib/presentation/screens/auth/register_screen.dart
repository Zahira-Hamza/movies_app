import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/app_assets.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/core/constants/app_styles.dart';
import 'package:movies_app/core/constants/validators.dart';
import 'package:movies_app/presentation/widgets/auth/carousel_avatares.dart';
import 'package:movies_app/presentation/widgets/auth/toggle_switch_language.dart';
import 'package:movies_app/presentation/widgets/custom_text_form_field.dart';
import 'package:movies_app/presentation/widgets/custome_elevated_button.dart';

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
        title: Text('Register'),
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
              SizedBox(
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
                        hint: 'Name',
                        controller: nameController,
                        validator: (value) {
                          return Validators.validateName(value);
                        },
                      ),
                      CustomTextFormField(
                        image: AppAssets.emailIcon,
                        hint: 'Email',
                        controller: emailController,
                        validator: (value) {
                          return Validators.validateEmail(value);
                        },
                      ),
                      CustomTextFormField(
                        image: AppAssets.passwordIcon,
                        hint: 'Password',
                        isPassword: true,
                        controller: passwordController,
                        validator: (value) {
                          return Validators.validatePassword(value);
                        },
                      ),
                      CustomTextFormField(
                        image: AppAssets.passwordIcon,
                        hint: 'Confirm Password',
                        isPassword: true,
                        controller: confirmPasswordController,
                        validator: (value) {
                          return Validators.validateConfirmPassword(
                              value, passwordController.text);
                        },
                      ),
                      CustomTextFormField(
                        image: AppAssets.phoneIcon,
                        hint: 'Phone Number',
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          return Validators.validatePhone(value);
                        },
                      ),
                      CustomeElevatedButton(
                          onPressed: () {}, label: 'Create Account'),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already Have Account ?',
                    style: AppStyles.regularRoboto
                        .copyWith(fontSize: 14, color: AppColors.white),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text('Login',
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
