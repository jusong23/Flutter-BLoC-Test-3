import 'package:flutter/foundation.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'state.dart';

part 'event.dart';
// state와 event는 본 bloc파일의 일부. (bloc을 한번 더 분리한 것)

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterInitial(0)) {
    // CounterBloc 내부 CounterState의 count 값을 생성자로 초기화한다.

    print('jusong CounterBloc in bloc');

    on<CounterIncrementPressed>(
      (event, emit) {
        print('jusong CounterIncrementPressed in bloc');
        emit(CounterChange(state.count + 1));
      },
    );
    // on 이벤트 핸들러 형태로 이벤트를 보내고 상태를 변경하도록 정의한다.

    on<CounterDecrementPressed>(
      (event, emit) {
        print('jusong CounterDecrementPressed in bloc');
        emit(CounterChange(state.count - 1));
      },
    );
  }
}

// circluar prograss
//
