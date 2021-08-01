import 'package:bloc_test/bloc_test.dart';
import 'package:f_bloc/timer/ticker.dart';
import 'package:f_bloc/timer/timer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TimerBloc', () {
    late Ticker ticker;

    setUp(() {
      ticker = MockTicker();
      when(() => ticker.tick(ticks: 5))
          .thenAnswer((_) => Stream<int>.fromIterable([5, 4, 3, 2, 1]));
    });

    test('initial state is TimerInitial(60)', () {
      expect(
        TimerBloc(ticker: ticker).state,
        const TimerInitial(60),
      );
    });

    blocTest<TimerBloc, TimerState>(
      'emits TickerRunInProgress 5 times after timer started',
      build: () => TimerBloc(ticker: ticker),
      act: (bloc) => bloc.add(const TimerStarted(duration: 5)),
      expect: () => const [
        TimerRunInProgress(5),
        TimerRunInProgress(4),
        TimerRunInProgress(3),
        TimerRunInProgress(2),
        TimerRunInProgress(1)
      ],
      verify: (_) => verify(() => ticker.tick(ticks: 5)).called(1),
    );

    blocTest<TimerBloc, TimerState>(
      'emits TickerRunPause(2) when ticker is paused at 2',
      build: () => TimerBloc(ticker: ticker),
      seed: () => const TimerRunInProgress(2),
      act: (bloc) => bloc.add(const TimerPaused()),
      expect: () => [const TimerRunPause(2)],
    );
  });
}

class MockTicker extends Mock implements Ticker {}
