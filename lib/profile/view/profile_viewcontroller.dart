import 'package:auth_api/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_api/profile_api.dart';
import 'package:maps_clone/core/core.dart';
import 'package:maps_clone/location/location.dart';

import '../bloc/profile_bloc.dart';

class ProfileViewController extends StatelessWidget {
  final AuthUser authUser;

  const ProfileViewController(this.authUser, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileNotFound) {
          profileBloc.add(
            ProfileSave(
              Profile(
                (b) => b
                  ..id = authUser.id
                  ..email = authUser.email,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is ProfileLoaded) {
          return const LocationViewController();
        } else {
          return const LoadingView();
        }
      },
    );
  }
}
