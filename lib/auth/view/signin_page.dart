import 'package:auth_api/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import '../bloc/auth_bloc.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            const Icon(Icons.map_outlined, size: 200),
            const SizedBox(height: 50),
            const Text('Maps Clone'),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SignInButton(
                      Buttons.Google,
                      onPressed: () => BlocProvider.of<AuthBloc>(context)
                          .add(const Authenticate(AuthProvider.google)),
                    ),
                    const SizedBox(height: 48.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
