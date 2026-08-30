import 'package:dartz/dartz.dart';
import 'package:veyra/core/errors/failures.dart';
import 'package:veyra/features/auth/domain/repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository authRepository;

  SignInUseCase({required this.authRepository});

  Future<Either<Failure, void>> call({required String email, required String password}) async {
    return await authRepository.signIn(email: email, password: password);
  }
}
