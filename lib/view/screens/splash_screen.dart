import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/constants/styles/app_colors.dart';
import 'package:movies_app/core/routes/app_routes.dart';
import 'package:movies_app/core/utils/ui_utils.dart';
import 'package:movies_app/view_model/user_existance/user_existance_cubit.dart';
import 'package:movies_app/view_model/user_existance/user_existance_states.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserExistanceCubit, UserExistanceStates>(
        listener: (context, state) {
          if (state is UserSeenOnboardingError) {
            UIUtils.showMessage('Error', context, AppColors.red);
          } else {
            final seen = context.read<UserExistanceCubit>().seen;
            Navigator.pushReplacementNamed(
                context,
                seen
                    ? AppRoutes.loginScreenRoute
                    : AppRoutes.onBoardingScreenRoute);
          }
        },
        child: Center(
          child: CircularProgressIndicator(
            color: AppColors.yellowPrimaryColor,
            strokeWidth: 4,
          ),
        ),
      ),
    );
  }
}
