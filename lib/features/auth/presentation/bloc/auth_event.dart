import 'package:equatable/equatable.dart';

sealed class AuthEvent extends Equatable {}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignUpEvent extends AuthEvent {
  final String fullName;
  final String email;
  final String password;

  SignUpEvent({required this.fullName, required this.email, required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [fullName, email, password];
}
