part of 'bloc.dart';

enum CounterStateType {
  NONE,
  INCREMENT,
  DECREMENT,
}

class CounterState extends Equatable {
  final CounterViewModel vm;
  const CounterState(this.vm);

  @override
  List<Object?> get props => [vm];
}

class CounterViewModel extends Equatable {
  final int counter;

  const CounterViewModel({
    this.counter = 0,
  });

  CounterViewModel copyWith({
    int? counter,
  }) {
    return CounterViewModel(
      counter: counter ?? this.counter,
    );
  }

  @override
  List<Object?> get props => [
    counter,
  ];
}
// shared pref
class Initialize extends CounterState {
  const Initialize() : super(const CounterViewModel());
}

class DefaultState extends CounterState {
  const DefaultState(CounterViewModel vm) : super(vm);
}

class CounterIncrement extends DefaultState {
  const CounterIncrement(CounterViewModel vm) : super(vm);
}

class CounterDecrement extends DefaultState {
  const CounterDecrement(CounterViewModel vm) : super(vm);
}