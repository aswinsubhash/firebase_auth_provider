import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:firebase_auth_provider/providers/auth/auth_state.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth_provider/repositories/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  AuthState _state = AuthState.unknown();
  AuthState get state => _state;

  final AuthRepository authRepository;
  AuthProvider({
    required this.authRepository,
  });

  void update(fb_auth.User? user) {
    if (user != null) {
      _state = _state.copyWith(
        authStatus: AuthStatus.authenticated,
        user: user,
      );
    } else {
      _state = _state.copyWith(authStatus: AuthStatus.unauthenticated);
    }

    log('authstate: $_state');
    notifyListeners();
  }

  void signout() async {
    await authRepository.signout();
  }
}
