import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:profile_repository/profile_repository.dart';
import 'package:maps_clone/assets/assets.dart';
import 'package:maps_clone/auth/auth.dart';
import 'package:maps_clone/location/location.dart';
import 'package:maps_clone/profile/profile.dart';
import 'package:maps_clone/theme/theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: Get.find<AssetsRepository>(),
        ),
        RepositoryProvider.value(
          value: Get.find<AuthRepository>(),
        ),
        RepositoryProvider.value(
          value: Get.find<ProfileRepository>(),
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // These BLoCs will be global. See https://github.com/felangel/bloc/issues/74#issuecomment-457969382
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            RepositoryProvider.of<AuthRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(
            RepositoryProvider.of<ProfileRepository>(context),
          ),
        ),
        BlocProvider(
            create: (context) =>
                LocationBloc()..add(LocationPermissionRequested())),
      ],
      child: MaterialApp(
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        home: const AuthViewController(),
      ),
    );
  }
}
