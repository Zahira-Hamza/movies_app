import 'package:dartz/dartz.dart';
import 'package:movies_app/core/constants/errors/auth_exception.dart';
import 'package:movies_app/core/constants/errors/faliure.dart';
import 'package:movies_app/data/data_sources/local_data_sources/auth_shared_pref_local_data_sources.dart';
import 'package:movies_app/data/data_sources/remote_data_sources/auth_remote_data_source.dart';
import 'package:movies_app/data/models/auth/login_request.dart';
import 'package:movies_app/data/models/auth/register_request.dart';
import 'package:movies_app/data/models/auth/user_model.dart';

class AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource = AuthRemoteDataSource();
  final AuthSharedPrefLocalDataSources _authSharedPrefLocalDataSources =
      AuthSharedPrefLocalDataSources();

  Future<Either<Failure, UserModel>> register(RegisterRequest request) async {
    try {
      final response = await _authRemoteDataSource.register(request);
      return Right(response.userModel);
    } on AuthException catch (exception) {
      return Left(Failure(exception.message));
    }
  }

  Future<Either<Failure, void>> login(LoginRequest request) async {
    try {
      final response = await _authRemoteDataSource.login(request);
      _authSharedPrefLocalDataSources.saveToken(response.token);
      return Right(null);
    } on AuthException catch (exception) {
      return Left(Failure(exception.message));
    }
  }
}
