import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/error_info.dart';
import '../base/base_bloc.dart';
import '../../domain/preference/preference_data_source.dart';

part 'state.dart';

part 'event.dart';

// TODO: BLoC
class CounterBloc extends BaseBloc<CounterEvent, CounterState> {
  CounterBloc({
    required PreferenceDataSource pref,
  })  : _pref = pref,
        super(const Initialize()) {
    // CounterBloc 내부 CounterState의 count 값을 생성자로 초기화한다.
    print('jusong CounterBloc in bloc');
  }

  final PreferenceDataSource _pref;

  @override
  Future<void> handleEvent(
      CounterEvent event, Emitter<CounterState> emit) async {
    print('jusong handle');
    if (event is InitializeView) {
      await handleViewStart(event, emit, state);
    }
    else if (event is CounterPressed) {
      if (event.counterStateType == CounterStateType.INCREMENT) {
        await IncrementCounterState(event, emit, state);
      } else if (event.counterStateType == CounterStateType.DECREMENT) {
        await DecrementCounterState(event, emit, state);
      }
    }
  }

  Future<void> handleViewStart(CounterEvent event, Emitter<CounterState> emit,
      CounterState state) async {
    emit(DataLoadInProgress(state.vm));
    try {
      var temp = await _pref.getCount();
      emit(LoadInitialCounter(state.vm.copyWith(counter: temp)));
    } on Exception catch (e, stacktrace) {
      emit(RequestCounterFailure(state.vm, ErrorInfo(exception: e)));
    } catch (e) {
      emit(RequestCounterFailure(state.vm, ErrorInfo(object: e)));
    }
  }

  Future<void> IncrementCounterState(CounterEvent event,
      Emitter<CounterState> emit, CounterState state) async {
    emit(DataLoadInProgress(state.vm));
    try {
      print("0808 before copy state.vm.counter.hashCode: ${state.vm.counter.hashCode}");
      await Future.delayed(const Duration(milliseconds: 300));
      var count = state.vm.counter + 1;
      emit(CounterIncrement(state.vm.copyWith(counter: count)));
      print("0808 after copy state.vm.counter.hashCode ${state.vm.counter.hashCode}");
      // 변경한 부분만 인스턴스에 반영되는 얕은 복사 (동일한 메모리 주소를 공유하기에 메모리 효율성 증가)
      // 원본 객체와 복사본 사이에서 객체 내용이 변경되면 두 객체 모두에 영향
      await _pref.setCount(count);

    } on Exception catch (e, stacktrace) {
      emit(RequestCounterFailure(state.vm, ErrorInfo(exception: e)));
    } catch (e) {
      emit(RequestCounterFailure(state.vm, ErrorInfo(object: e)));
    }
  }

  Future<void> DecrementCounterState(CounterEvent event,
      Emitter<CounterState> emit, CounterState state) async {
    emit(DataLoadInProgress(state.vm));
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      var count = state.vm.counter - 1;
      emit(CounterDecrement(state.vm.copyWith(counter: state.vm.counter - 1)));
      await _pref.setCount(state.vm.counter-1);
    } on Exception catch (e, stacktrace) {
      emit(RequestCounterFailure(state.vm, ErrorInfo(exception: e)));
    } catch (e) {
      emit(RequestCounterFailure(state.vm, ErrorInfo(object: e)));
    }
  }
}

