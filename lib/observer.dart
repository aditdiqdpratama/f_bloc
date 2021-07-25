import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';

class Observer extends BlocObserver {
  final _log = Logger('Bloc Observer');
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    _log.info('${bloc.runtimeType} $change');
  }
}
