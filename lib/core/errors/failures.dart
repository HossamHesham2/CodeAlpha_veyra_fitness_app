import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String errorMessage;

  const Failure({required this.errorMessage});
}

class RemoteFailure extends Failure {
  const RemoteFailure({required super.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class AuthFailure extends Failure {
  const AuthFailure({required super.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class CacheFailure extends Failure {
  const CacheFailure({required super.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
