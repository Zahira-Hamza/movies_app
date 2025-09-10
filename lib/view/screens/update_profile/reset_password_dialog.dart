import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/styles/app_colors.dart';

void showResetPasswordDialog(
    BuildContext context, Function(String, String) onReset) {
  final resetFormKey = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  bool oldObsecure = true;
  bool newObsecure = true;
  final strongPasswordRegExp =
      RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$');

  showDialog(
    context: context,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Color(0xFF1A1A1A),
            title: Center(
              child: Text(
                'Reset Password',
                style: TextStyle(
                  color: AppColors.yellowPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: Form(
                key: resetFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: oldPasswordController,
                      decoration: InputDecoration(
                        labelText: 'Old Password',
                        labelStyle: TextStyle(color: Colors.white70),
                        prefixIcon:
                            Icon(Icons.lock_outline, color: Colors.white70),
                        filled: true,
                        fillColor: Color(0xFF222222),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              oldObsecure = !oldObsecure;
                            });
                          },
                          child: Icon(
                            oldObsecure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                      obscureText: oldObsecure,
                      style: TextStyle(color: Colors.white),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (!strongPasswordRegExp.hasMatch(value)) {
                          return 'Password must be at least 8 characters, include uppercase, lowercase, number and special character.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 14),
                    TextFormField(
                      controller: newPasswordController,
                      decoration: InputDecoration(
                        labelText: 'New Password',
                        labelStyle: TextStyle(color: Colors.white70),
                        prefixIcon: Icon(Icons.vpn_key, color: Colors.white70),
                        filled: true,
                        fillColor: Color(0xFF222222),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              newObsecure = !newObsecure;
                            });
                          },
                          child: Icon(
                            newObsecure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                      obscureText: newObsecure,
                      style: TextStyle(color: Colors.white),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                           validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (!strongPasswordRegExp.hasMatch(value)) {
                          return 'Password must be at least 8 characters, include uppercase, lowercase, number and special character.';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white70,
                ),
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text('Cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.yellowPrimaryColor,
                  foregroundColor: AppColors.blackPrimaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  textStyle: TextStyle(fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  if (resetFormKey.currentState!.validate()) {
                    final oldPass = oldPasswordController.text.trim();
                    final newPass = newPasswordController.text.trim();
                    onReset(oldPass, newPass);
                    Navigator.of(ctx).pop();
                  }
                },
                child: Text('Reset'),
              ),
            ],
          );
        },
      );
    },
  );
}
