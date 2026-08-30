import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veyra/core/constants/app_enums.dart';
import 'package:veyra/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:veyra/features/auth/domain/usecases/sign_up_use_case.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;

  AuthBloc({required this.signInUseCase, required this.signUpUseCase})
    : super(AuthState.initial()) {
    on<AuthEvent>(_onEvent);
  }

  void _onEvent(AuthEvent event, Emitter<AuthState> emit) async {
    switch (event) {
      case SignInEvent():
        await _signIn(event, emit);
      case SignUpEvent():
        await _signUp(event, emit);
    }
  }

  Future<void> _signIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(signInRequest: AppRequests.loading));
    final result = await signInUseCase.call(email: event.email, password: event.password);
    result.fold(
      (l) => emit(state.copyWith(signInRequest: AppRequests.error, signInFailure: l)),
      (_) => emit(state.copyWith(signInRequest: AppRequests.success)),
    );
  }

  Future<void> _signUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(signUpRequest: AppRequests.loading));
    final result = await signUpUseCase.call(
      fullName: event.fullName,
      email: event.email,
      password: event.password,
    );
    result.fold(
      (l) => emit(state.copyWith(signUpRequest: AppRequests.error, signUpFailure: l)),
      (_) => emit(state.copyWith(signUpRequest: AppRequests.success)),
    );
  }
}
