import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';

class AppObserver extends BlocObserver {
  final _log = Logger('Bloc Observer');
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    _log.info('${bloc.runtimeType} $change');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    _log.info('event: $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    _log.info('transition: $transition}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    _log.info('$error: $stackTrace');
  }
}
