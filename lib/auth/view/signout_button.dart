import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.logout_sharp),
      label: const Text('Sign Out'),
      onPressed: () => BlocProvider.of<AuthBloc>(context).add(Unauthenticate()),
    );
  }
}
