import 'package:movies_app/data/models/auth/user_model.dart';

abstract class ProfileStates {}

class ProfileInitial extends ProfileStates {}

class UpdateProfileLoading extends ProfileStates {}

class UpdateProfileSuccess extends ProfileStates {
  final String message;

  UpdateProfileSuccess(this.message);
}

class UpdateProfileError extends ProfileStates {
  final String message;

  UpdateProfileError(this.message);
}

class DeleteProfileLoading extends ProfileStates {}

class DeleteProfileSuccess extends ProfileStates {
  final String message;

  DeleteProfileSuccess(this.message);
}

class DeleteProfileError extends ProfileStates {
  final String message;

  DeleteProfileError(this.message);
}

class GetProfileLoading extends ProfileStates {}

class GetProfileSuccess extends ProfileStates {
  final UserModel user;

  GetProfileSuccess(this.user);
}

class GetProfileError extends ProfileStates {
  final String message;

  GetProfileError(this.message);
}
