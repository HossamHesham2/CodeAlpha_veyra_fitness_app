import 'package:dartz/dartz.dart';
import 'package:veyra/core/errors/failures.dart';
import 'package:veyra/features/auth/domain/repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository authRepository;

  SignUpUseCase({required this.authRepository});

  Future<Either<Failure, void>> call({required String fullName,required String email, required String password}) async {
    return await authRepository.signUp(fullName: fullName, email: email, password: password);
  }
}
