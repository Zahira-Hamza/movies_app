import 'package:flutter/material.dart';
import 'package:movies_app/core/routes/app_routes.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacementNamed(
            context, AppRoutes.updateProfileScreenRoute);
      },
      child: Center(
        child: Text(
          'Go To Update Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
