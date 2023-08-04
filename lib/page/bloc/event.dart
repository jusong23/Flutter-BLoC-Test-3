part of 'bloc.dart';

@immutable
abstract class CounterEvent {
  const CounterEvent();
}

class CounterIncrementPressed extends CounterEvent {
  const CounterIncrementPressed();
}

class CounterDecrementPressed extends CounterEvent {
  const CounterDecrementPressed();
}