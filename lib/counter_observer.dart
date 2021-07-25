import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';

class CounterObserver extends BlocObserver {
  final _log = Logger('Counter Observer');
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    _log.info('Counter Observer ${bloc.runtimeType} $change');
  }
}
