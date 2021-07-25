import 'package:f_bloc/counter/counter.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((event) {
    print(
        '${event.loggerName} ${event.level.name}: ${event.time} ${event.message}');
  });

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
          length: 2,
          child: Scaffold(
              appBar: AppBar(
                flexibleSpace: const TabBar(tabs: [
                  Tab(
                    child: Text('Counter'),
                  ),
                  Tab(
                    child: Text('2'),
                  )
                ]),
              ),
              body: const TabBarView(
                children: [
                  CounterPage(),
                  Center(
                    child: Text('2'),
                  )
                ],
              )),
        )));
  }
}
