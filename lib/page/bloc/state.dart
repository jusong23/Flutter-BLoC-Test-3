part of 'bloc.dart';

@immutable
abstract class CounterState {
  final int count; // 상태 변수 추가

  const CounterState(this.count);
}

class CounterInitial extends CounterState {
  // 상태 초기화 생성자
  const CounterInitial(super.count);
}

class CounterChange extends CounterState {
  // 상태 변경 생성자
  const CounterChange(super.count);
}