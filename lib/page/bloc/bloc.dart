import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../base/base_bloc.dart';

part 'state.dart';

part 'event.dart';

// state와 event는 본 bloc파일의 일부. (bloc을 한번 더 분리한 것)
class CounterBloc extends BaseBloc<CounterEvent, CounterState> {
  CounterBloc() : super(Initialize()) {
    // CounterBloc 내부 CounterState의 count 값을 생성자로 초기화한다.
    print('jusong CounterBloc in bloc');
  }

  @override
  Future<void> handleEvent(
      CounterEvent event, Emitter<CounterState> emit) async {
    print('jusong handle');

    if (event is CounterPressed) {
      if (event.counterStateType == CounterStateType.INCREMENT) {
        emit(CounterIncrement(state.vm.copyWith(counter: state.vm.counter + 1)));
      } else if (event.counterStateType == CounterStateType.DECREMENT) {
        emit(CounterDecrement(state.vm.copyWith(counter: state.vm.counter - 1)));
      }
    }
  }
}

// circluar prograss
