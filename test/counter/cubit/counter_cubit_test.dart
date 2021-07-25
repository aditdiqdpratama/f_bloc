import 'package:bloc_test/bloc_test.dart';
import 'package:f_bloc/counter/counter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CounterCubit', () {
    test('init state is 0', () {
      expect(CounterCubit().state, 0);
    });

    group('increment', () {
      blocTest<CounterCubit, int>(
        'emits [1] when state is 0',
        build: () => CounterCubit(),
        act: (cubit) => cubit.increment(),
        expect: () => const <int>[1],
      );
    });

    group('decrement', () {
      blocTest<CounterCubit, int>(
        'emits [0] when state is 1',
        build: () => CounterCubit(),
        seed: () => 1,
        act: (cubit) => cubit.decrement(),
        expect: () => const <int>[0],
      );

      blocTest<CounterCubit, int>(
        'emits [0] when state is 0',
        build: () => CounterCubit(),
        act: (cubit) => cubit.decrement(),
        expect: () => const <int>[0],
      );
    });
  });
}
