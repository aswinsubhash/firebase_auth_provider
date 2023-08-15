import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:firebase_auth_provider/firebase_options.dart';
import 'package:firebase_auth_provider/pages/home_page.dart';
import 'package:firebase_auth_provider/pages/siginin_page.dart';
import 'package:firebase_auth_provider/pages/signup_page.dart';
import 'package:firebase_auth_provider/pages/splash_page.dart';
import 'package:firebase_auth_provider/providers/auth/auth_provider.dart';
import 'package:firebase_auth_provider/providers/profile/profile_provider.dart';
import 'package:firebase_auth_provider/providers/signin/sigin_provider.dart';
import 'package:firebase_auth_provider/providers/signup/signup_provider.dart';
import 'package:firebase_auth_provider/repositories/auth_repository.dart';
import 'package:firebase_auth_provider/repositories/profile_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepository>(
          create: (context) => AuthRepository(
            firebaseFirestore: FirebaseFirestore.instance,
            firebaseAuth: fb_auth.FirebaseAuth.instance,
          ),
        ),
        Provider<ProfileRepository>(
          create: (context) => ProfileRepository(
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),
        StreamProvider<fb_auth.User?>(
          create: (context) => context.read<AuthRepository>().user,
          initialData: null,
        ),
        ChangeNotifierProxyProvider<fb_auth.User?, AuthProvider>(
          create: (context) =>
              AuthProvider(authRepository: context.read<AuthRepository>()),
          update: (
            BuildContext context,
            fb_auth.User? userStream,
            AuthProvider? authProvider,
          ) =>
              authProvider!..update(userStream),
        ),
        ChangeNotifierProvider<SigninProvider>(
          create: (context) => SigninProvider(
            authRepository: context.read<AuthRepository>(),
          ),
        ),
        ChangeNotifierProvider<SignupProvider>(
          create: (context) => SignupProvider(
            authRepository: context.read<AuthRepository>(),
          ),
        ),
        ChangeNotifierProvider<ProfileProvider>(
          create: (context) => ProfileProvider(
            profileRepository: context.read<ProfileRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Auth Provider',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashPage(),
        routes: {
          SignupPage.routeName: (context) => const SignupPage(),
          SigninPage.routeName: (context) => const SigninPage(),
          HomePage.routeName: (context) => const HomePage(),
        },
      ),
    );
  }
}
