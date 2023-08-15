import 'package:firebase_auth_provider/providers/profile/profile_provider.dart';
import 'package:firebase_auth_provider/providers/profile/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget buildProfile(BuildContext context) {
  final profileState = context.watch<ProfileProvider>().state;

  if (profileState.profileStatus == ProfileStatus.initial) {
    return Container();
  } else if (profileState.profileStatus == ProfileStatus.loading) {
    return const Center(child: CircularProgressIndicator());
  } else if (profileState.profileStatus == ProfileStatus.error) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/error.png',
            width: 75,
            height: 75,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 20.0),
          const Text(
            'Ooops!\nTry again',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
  return Card(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInImage.assetNetwork(
          placeholder: 'assets/images/loading.gif',
          image: profileState.user.profileImage,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '- id: ${profileState.user.id}',
                style: const TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 10.0),
              Text(
                '- name: ${profileState.user.name}',
                style: const TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 10.0),
              Text(
                '- email: ${profileState.user.email}',
                style: const TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 10.0),
              Text(
                '- point: ${profileState.user.point}',
                style: const TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 10.0),
              Text(
                '- rank: ${profileState.user.rank}',
                style: const TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
