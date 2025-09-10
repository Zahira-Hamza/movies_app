import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/models/user/update_user_profile_request.dart';
import 'package:movies_app/data/repositories/user_profile_repository.dart';
import 'package:movies_app/view_model/profile/profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitial());

  final UserProfileRepository _repository = UserProfileRepository();

  Future<void> updateProfile(UpdateUserProfileRequest request) async {
    emit(UpdateProfileLoading());
    final result = await _repository.updateProfile(request);
    result.fold((faliure) => emit(UpdateProfileError(faliure.errorMessage)),
        (data) {
      emit(UpdateProfileSuccess(data));
    });
  }

  Future<void> deleteProfile() async {
    emit(DeleteProfileLoading());
    final result = await _repository.deleteAccount();
    result.fold((faliure) => emit(DeleteProfileError(faliure.errorMessage)),
        (data) {
      emit(DeleteProfileSuccess(data));
    });
  }

    Future<void> getProfile() async {
    emit(GetProfileLoading());
    final result = await _repository.getProfile();
    result.fold((faliure) => emit(GetProfileError(faliure.errorMessage)),
        (data) {
      emit(GetProfileSuccess(data));
    },);
  }
}
