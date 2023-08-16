import 'package:equatable/equatable.dart';

import '../../models/custom_error.dart';

enum SignupStatus {
  initial,
  submitting,
  success,
  error,
}

class SignupState extends Equatable {
  final SignupStatus signupStatus;
  final CustomError customError;
  const SignupState({
    required this.signupStatus,
    required this.customError,
  });

  factory SignupState.initial() {
    return const SignupState(
      signupStatus: SignupStatus.initial,
      customError: CustomError(),
    );
  }

  @override
  List<Object> get props => [SignupStatus, customError];

  @override
  String toString() =>
      'SignupState(SignupStatus: $signupStatus, customError: $customError)';

  SignupState copyWith({
    SignupStatus? signupStatus,
    CustomError? customError,
  }) {
    return SignupState(
      signupStatus: signupStatus ?? this.signupStatus,
      customError: customError ?? this.customError,
    );
  }
}
