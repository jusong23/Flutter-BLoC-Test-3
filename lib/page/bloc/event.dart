part of 'bloc.dart';

@immutable
abstract class CounterEvent {
  const CounterEvent();
}

class CounterIncrementPressed extends CounterEvent {
  CounterIncrementPressed() {
    print('jusong CounterIncrementPressed in event');
  }
}

class CounterDecrementPressed extends CounterEvent {
  CounterDecrementPressed() {
    print('jusong CounterDecrementPressed in event');
  }
}
