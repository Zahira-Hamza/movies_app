class ResetPasswordData {
  final String oldPassword;
  final String newPassword;

  ResetPasswordData({required this.oldPassword, required this.newPassword});

  Map<String, dynamic> toJson() {
    return {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };
  }
}
