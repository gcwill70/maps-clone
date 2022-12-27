import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_clone/auth/view/signin_page.dart';
import 'package:maps_clone/core/core.dart';
import 'package:maps_clone/profile/profile.dart';

import '../bloc/auth_bloc.dart';

class AuthViewController extends StatelessWidget {
  const AuthViewController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          BlocProvider.of<ProfileBloc>(context)
              .add(ProfileLoad(state.authUser!.id));
        }
      },
      builder: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          return ProfileViewController(state.authUser!);
        } else if (state.status == AuthStatus.unauthenticated) {
          return const SignInPage();
        } else {
          return const LoadingView();
        }
      },
    );
  }
}
