import 'package:firebase_auth_provider/models/custom_error.dart';
import 'package:flutter/foundation.dart';

import 'package:firebase_auth_provider/providers/signin/signin_state.dart';
import 'package:firebase_auth_provider/repositories/auth_repository.dart';

class SigninProvider extends ChangeNotifier {
  SigninState _state = SigninState.initial();
  SigninState get state => _state;

  final AuthRepository authRepository;
  SigninProvider({
    required this.authRepository,
  });

  Future<void> signin({
    required String email,
    required String password,
  }) async {
    _state = _state.copyWith(signinStatus: SigninStatus.submitting);
    notifyListeners();

    try {
      await authRepository.signin(email: email, password: password);
      _state = _state.copyWith(signinStatus: SigninStatus.success);
      notifyListeners();
    } on CustomError catch (e) {
      _state =
          _state.copyWith(signinStatus: SigninStatus.error, customError: e);
      notifyListeners();
      rethrow;
    }
  }
}