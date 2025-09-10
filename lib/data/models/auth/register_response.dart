import 'user_model.dart';

class RegisterResponse {
  final String message;
  final UserModel userModel;

  const RegisterResponse({required this.message,required this.userModel});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      message: json['message'] as String,
      userModel:  UserModel.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}
