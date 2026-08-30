import 'package:veyra/core/constants/app_enums.dart';
import 'package:veyra/core/errors/failures.dart';

class AuthState {
  final AppRequests? signInRequest;
  final AppRequests? signUpRequest;
  final Failure? signUpFailure;
  final Failure? signInFailure;

  AuthState({
    required this.signInRequest,
    required this.signUpRequest,
    required this.signUpFailure,
    required this.signInFailure,
  });

  const AuthState.initial()
    : signInRequest = null,
      signUpRequest = null,
      signUpFailure = null,
      signInFailure = null;

  AuthState copyWith({
    AppRequests? signInRequest,
    AppRequests? signUpRequest,
    Failure? signUpFailure,
    Failure? signInFailure,
  }) {
    return AuthState(
      signInRequest: signInRequest ?? this.signInRequest,
      signUpRequest: signUpRequest ?? this.signUpRequest,
      signUpFailure: signUpFailure ?? this.signUpFailure,
      signInFailure: signInFailure ?? this.signInFailure,
    );
  }
}
