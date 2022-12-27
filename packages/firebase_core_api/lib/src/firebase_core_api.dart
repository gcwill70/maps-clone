import 'package:firebase_core/firebase_core.dart';

import '../firebase_core_api.dart';

class FirebaseCoreApi {
  FirebaseApp? app;

  FirebaseCoreApi({this.app});

  bool get initialized => app != null;

  Future<void> init({InitOptions? options}) async {
    app = await Firebase.initializeApp(
        name: options?.name, options: options?.options);
  }
}
