import 'package:f_bloc/timer/ticker.dart';
import 'package:f_bloc/timer/timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerBloc(ticker: const Ticker()),
      child: const TimerView(),
    );
  }
}

class TimerView extends StatelessWidget {
  const TimerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const <Widget>[
          TimerText(),
          SizedBox(
            height: 70,
            width: 300,
            child: Actions(),
          )
        ],
      ),
    );
  }
}

class TimerText extends StatelessWidget {
  const TimerText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*
    this widget will rebuild every tick on the timer. (every event occurs)
     */
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final String minute =
        ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final String second = (duration % 60).floor().toString().padLeft(2, '0');
    return Text(
      '$minute:$second',
      style: Theme.of(context).textTheme.headline1,
    );
  }
}

class Actions extends StatelessWidget {
  const Actions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      /*
      buildWhen make action widget only rebuild if the state was change
       */
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (state is TimerInitial) ...[
            FloatingActionButton(
              child: const Icon(Icons.play_arrow),
              onPressed: () => context
                  .read<TimerBloc>()
                  .add(TimerStarted(duration: state.duration)),
            ),
          ],
          if (state is TimerRunInProgress) ...[
            FloatingActionButton(
              onPressed: () =>
                  context.read<TimerBloc>().add(const TimerPaused()),
              child: const Icon(Icons.pause),
            ),
            FloatingActionButton(
              onPressed: () =>
                  context.read<TimerBloc>().add(const TimerReset()),
              child: const Icon(Icons.replay),
            ),
          ],
          if (state is TimerRunPause) ...[
            FloatingActionButton(
              onPressed: () =>
                  context.read<TimerBloc>().add(const TimerResumed()),
              child: const Icon(Icons.play_arrow),
            ),
            FloatingActionButton(
              onPressed: () =>
                  context.read<TimerBloc>().add(const TimerReset()),
              child: const Icon(Icons.replay),
            )
          ],
          if (state is TimerRunComplete) ...[
            FloatingActionButton(
              onPressed: () =>
                  context.read<TimerBloc>().add(const TimerReset()),
              child: const Icon(Icons.replay),
            )
          ],
        ],
      ),
    );
  }
}
