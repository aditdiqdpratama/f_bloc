import 'package:bloc/bloc.dart';
import 'package:f_bloc/counter/app.dart';
import 'package:f_bloc/counter/counter_observer.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((event) {
    print(
        '${event.loggerName} ${event.level.name}: ${event.time} ${event.message}');
  });

  Bloc.observer = CounterObserver();
  runApp(const CounterApp());
}
