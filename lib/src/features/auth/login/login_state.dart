import 'package:flutter/material.dart';

enum LoginStateStatus {
  initial,
  admLogin,
  employeeLogin,
  failure,
}

class LoginState {
  LoginState({
    required this.status,
    this.errorMessage,
  });

  LoginState.initial() : this(status: LoginStateStatus.initial);

  final LoginStateStatus status;
  final String? errorMessage;

  LoginState copyWith({
    LoginStateStatus? status,
    ValueGetter<String?>? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }
}
