import 'package:dartz/dartz.dart';

import 'package:veyra/core/errors/failures.dart';
import 'package:veyra/core/exceptions/auth_exceptions.dart';
import 'package:veyra/features/auth/data/datasources/remote/auth_remote_datasource.dart';

import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImpl({required this.authRemoteDatasource});

  @override
  Future<Either<Failure, void>> signIn({required String email, required String password}) async {
    try {
      await authRemoteDatasource.signIn(email: email, password: password);
      return Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(errorMessage: e.message));
    } catch (e) {
      return Left(AuthFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      await authRemoteDatasource.signUp(fullName: fullName, email: email, password: password);
      return Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(errorMessage: e.message));
    } catch (e) {
      return Left(AuthFailure(errorMessage: e.toString()));
    }
  }
}
