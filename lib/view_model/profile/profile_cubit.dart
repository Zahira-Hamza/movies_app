import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/models/auth/user_model.dart';
import 'package:movies_app/data/models/movies/movie_basic_info.dart';
import 'package:movies_app/data/models/user_profile/update_user_profile_request.dart';
import 'package:movies_app/data/repositories/fav_movies_repository.dart';
import 'package:movies_app/data/repositories/user_profile_repository.dart';
import 'package:movies_app/view_model/profile/profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitial());

  final UserProfileRepository _repository = UserProfileRepository();
  final FavMoviesRepository _favMoviesRepository = FavMoviesRepository();
  List<MovieBasicInfo> favMovies = [];
  UserModel? user;

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

  Future<void> getProfileWithFavMovies() async {
    emit(GetProfileLoading());
    final userResult = await _repository.getProfile();
    userResult.fold(
      (faliure) => emit(GetProfileError(faliure.errorMessage)),
      (data) {
        user = data;
      },
    );
    final favMoviesResult = await _favMoviesRepository.getAllFavMovies();
    favMoviesResult.fold(
        (faliure) => emit(GetProfileError(faliure.errorMessage)), (result) {
      emit(GetProfileSuccess());
      favMovies = result;
    });
  }

  Future<void> getProfile() async {
    emit(GetProfileLoading());
    final userResult = await _repository.getProfile();
    userResult.fold(
      (faliure) => emit(GetProfileError(faliure.errorMessage)),
      (data) {
        user = data;
        emit(GetProfileSuccess());
      },
    );
  }

  Future<void> getFavMovies() async {
    emit(GetFavMoviesLoading());
    final favMoviesResult = await _favMoviesRepository.getAllFavMovies();
    favMoviesResult.fold(
        (faliure) => emit(GetFavMoviesError(faliure.errorMessage)), (result) {
      emit(GetFavMoviesSuccess());
      favMovies = result;
    });
  }
}
