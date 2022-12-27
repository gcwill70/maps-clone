import 'dart:async';
import 'dart:developer';

import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth_api/firebase_auth_api.dart';
import 'package:firebase_core_api/firebase_core_api.dart';
import 'package:firebase_profile_api/firebase_profile_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logging/logging.dart';
import 'package:profile_repository/profile_repository.dart';
import 'package:maps_clone/assets/assets_repository.dart';
import 'package:maps_clone/firebase_options.dart';

import 'app/app_bloc_observer.dart';
import 'app/app.dart';

final logger = Logger('main_dev');

Future<void> bootstrap() async {
  // assets
  await Get.putAsync(() async {
    AssetsRepository repo = AssetsRepository();
    // env
    repo.mapEnv.forEach((key, value) async {
      repo.mapEnv[key] = await rootBundle.loadString(key);
    });
    // bitmap descriptors
    repo.bitmapDescriptors.forEach((key, value) async {
      repo.bitmapDescriptors[key] = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(), key);
    });
    // map styles
    repo.mapStyles.forEach((key, value) async {
      repo.mapStyles[key] = await rootBundle.loadString(key);
    });
    // svg images
    repo.svgWidgets.forEach((key, value) {
      repo.svgWidgets[key] = SvgPicture.asset(key);
    });
    return repo;
  });
  // firebase core
  await Get.putAsync(() async {
    final firebaseCoreApi = FirebaseCoreApi();
    await firebaseCoreApi.init(
        options: InitOptions(options: DefaultFirebaseOptions.currentPlatform));
    return firebaseCoreApi;
  });
  // auth
  Get.put(FirebaseAuthApi());
  Get.put(AuthRepository(api: Get.find<FirebaseAuthApi>()));
  // profile
  Get.put(FirebaseProfileApi());
  Get.put(ProfileRepository(api: Get.find<FirebaseProfileApi>()));
}

Future<void> main() async {
  logger.finest('entering main...');

  Logger.root.onRecord.listen((record) {
    log('${record.time} - ${record.message} ${record.message}');
  });

  WidgetsFlutterBinding.ensureInitialized();

  await bootstrap();

  runZonedGuarded(
    () async {
      await BlocOverrides.runZoned(
        () async {
          logger.finest('running app...');
          runApp(const App());
        },
        blocObserver: AppBlocObserver(),
      );
    },
    (error, stackTrace) => logger.severe(error.toString(), stackTrace),
  );
}
