import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/repositories/user_existance_repository.dart';
import 'package:movies_app/view_model/user_existance/user_existance_states.dart';

class UserExistanceCubit extends Cubit<UserExistanceStates> {
  UserExistanceCubit() : super(UserExistanceInitial());

  final UserExistanceRepository _existanceRepository =
      UserExistanceRepository();

  late bool seen;

  Future<void> checkAlreadySeenOnboarding() async {
    emit(UserSeenOnboardingLoading());
    final result = await _existanceRepository.checkAlreadySeenOnboarding();
    result.fold((failure) => emit(UserSeenOnboardingError()), (result) {
      seen = result;
      emit(UserSeenOnboardingSuccess());
    });
  }

  Future<void> finishOnboarding() async {
    final result = await _existanceRepository.finishOnboarding();
    result.fold((failure) => emit(UserSeenOnboardingError()), (result) {
      seen = true;
      emit(UserSeenOnboardingSuccess());
    });
  }
}
