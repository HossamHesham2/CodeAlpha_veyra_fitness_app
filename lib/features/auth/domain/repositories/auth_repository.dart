import 'package:dartz/dartz.dart';
import 'package:veyra/core/errors/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure,void>> signIn({required String email , required String password});
  Future<Either<Failure,void>> signUp({required String fullName ,required String email , required String password});

}
