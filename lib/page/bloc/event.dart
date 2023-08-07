part of 'bloc.dart';

// @immutable
abstract class CounterEvent {
  const CounterEvent();

  @override
  List<Object?> get props => [];
}

class CounterPressed extends CounterEvent {
  final CounterStateType? counterStateType;

  const CounterPressed(this.counterStateType);

  @override
  List<Object?> get props => super.props..addAll([counterStateType]);
}
