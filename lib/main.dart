import 'package:bloc/bloc.dart';
import 'package:f_bloc/counter/counter.dart';
import 'package:f_bloc/posts/view/post_page.dart';
import 'package:f_bloc/timer/timer.dart';
import 'package:f_bloc/utils/app_observer.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((event) {
    // ignore: avoid_print
    print(
        '${event.loggerName} ${event.level.name}: ${event.time} ${event.message}');
  });
  Bloc.observer = AppObserver();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc App',
      home: Center(
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              flexibleSpace: const TabBar(tabs: [
                Tab(
                  child: Text('Counter'),
                ),
                Tab(
                  child: Text('Timer'),
                ),
                Tab(
                  child: Text('Infinity List'),
                )
              ]),
            ),
            body: const TabBarView(
              children: [
                CounterPage(),
                TimerPage(),
                PostPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
