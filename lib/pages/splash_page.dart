import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth/auth_provider.dart';
import '../providers/auth/auth_state.dart';
import 'home_page.dart';
import 'siginin_page.dart';

class SplashPage extends StatelessWidget {
  static const String routeName = '/';
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthProvider>().state;

    if (authState.authStatus == AuthStatus.authenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, HomePage.routeName);
      });
    } else if (authState.authStatus == AuthStatus.unauthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, SigninPage.routeName);
      });
    }
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
