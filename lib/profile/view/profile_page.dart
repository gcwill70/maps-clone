import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_clone/auth/auth.dart';
import 'package:maps_clone/core/core.dart';

import '../bloc/profile_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => const ProfilePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          Navigator.pop(context);
        }
      },
      builder: (context, authState) {
        if (authState.status == AuthStatus.authenticated) {
          return BlocConsumer<ProfileBloc, ProfileState>(
            listener: (context, profileState) {
              if (profileState is ProfileInitial) {
                BlocProvider.of<ProfileBloc>(context)
                    .add(ProfileLoad(authState.authUser!.id));
              } else if (profileState is ProfileNotFound) {
                Navigator.pop(context);
              }
            },
            builder: (context, profileState) {
              if (profileState is ProfileLoaded) {
                return Scaffold(
                  extendBodyBehindAppBar: true,
                  appBar: AppBar(title: const Text('Profile')),
                  body: Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 100),
                        Text('Email: ${profileState.profile.email ?? 'None'}'),
                        const SizedBox(height: 24),
                        Text('ID: ${profileState.profile.id}'),
                        const SignOutButton(),
                      ],
                    ),
                  ),
                );
              } else {
                return const LoadingView();
              }
            },
          );
        } else {
          return const LoadingView();
        }
      },
    );
  }
}
