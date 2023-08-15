import 'package:firebase_auth_provider/providers/profile/profile_provider.dart';
import 'package:firebase_auth_provider/providers/profile/profile_state.dart';
import 'package:firebase_auth_provider/utils/error_dialog.dart';
import 'package:firebase_auth_provider/widgets/build_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfileProvider profileProv;

  @override
  void initState() {
    profileProv = context.read<ProfileProvider>();
    profileProv.addListener(errorDialogListener);
    _getProfile();
    super.initState();
  }

  void _getProfile(){
    final String uid = context.read<fb_auth.User?>()!.uid;
    WidgetsBinding.instance.addPostFrameCallback((_) { 
      context.read<ProfileProvider>().getProfile(uid: uid);
    });
  }

  void errorDialogListener() {
    if (profileProv.state.profileStatus == ProfileStatus.error) {
      errorDialog(context, profileProv.state.error);
    }
  }

  @override
  void dispose() {
    profileProv.removeListener(errorDialogListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profile'),
      ),
      body: buildProfile(context)
    );
  }
}
