part of 'bloc.dart';

enum CounterStateType {
  NONE,
  INCREMENT,
  DECREMENT,
}

// TODO: State
class CounterState extends Equatable {
  final CounterViewModel vm;
  const CounterState(this.vm); // 상태만 관리

  @override
  List<Object?> get props => [vm];
}

// TODO: ViewModel
// 상태 데이터에 대한 로직을 처리 (ex. copyWith를 통한 state에 기반 데이터 계산 작업 등)
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

class Initialize extends CounterState {
  const Initialize() : super(const CounterViewModel());
}

class DefaultState extends CounterState {
  const DefaultState(CounterViewModel vm) : super(vm);
}

// 증가 State
class CounterIncrement extends DefaultState {
  const CounterIncrement(CounterViewModel vm) : super(vm);
}

// 감소 State
class CounterDecrement extends DefaultState {
  const CounterDecrement(CounterViewModel vm) : super(vm);
}

class DataLoadInProgress extends DefaultState {
  const DataLoadInProgress(CounterViewModel vm) : super(vm);
}

// 초기 Load
class LoadInitialCounter extends DefaultState {
  const LoadInitialCounter(CounterViewModel vm) : super(vm);
}

class RequestCounterFailure extends CounterState {
  final ErrorInfo errorInfo;

  const RequestCounterFailure(CounterViewModel vm, this.errorInfo) : super(vm);

  @override
  CounterState copyWith(CounterViewModel vm) => RequestCounterFailure(vm, errorInfo);

  @override
  List<Object?> get props => super.props..addAll([errorInfo]);
}