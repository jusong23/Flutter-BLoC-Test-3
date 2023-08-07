part of 'bloc.dart';

// TODO: Event
abstract class CounterEvent {
  const CounterEvent();

  @override
  List<Object?> get props => [];
}
class InitializeView extends CounterEvent{
  const InitializeView();
  // 빌드 되자마자 InitializeView라는 이벤트를 발생
}
class CounterPressed extends CounterEvent {
  final CounterStateType? counterStateType;

  const CounterPressed(this.counterStateType);

  @override
  List<Object?> get props => super.props..addAll([counterStateType]);
}
