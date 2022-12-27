import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

final logger = Logger('AppBlocObserver');

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.warning('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    logger.fine('onClose(${bloc.runtimeType}');
    super.onClose(bloc);
  }
}
