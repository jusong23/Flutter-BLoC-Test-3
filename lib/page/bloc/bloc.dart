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
    if (event is CounterPressed) {
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
      await Future.delayed(const Duration(seconds: 1));
      var count = state.vm.counter + 1;
      emit(CounterIncrement(state.vm.copyWith(counter: count)));
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
      await Future.delayed(const Duration(seconds: 1));
      emit(CounterDecrement(state.vm.copyWith(counter: state.vm.counter - 1)));
      await _pref.setCount(state.vm.counter-1);
    } on Exception catch (e, stacktrace) {
      emit(RequestCounterFailure(state.vm, ErrorInfo(exception: e)));
    } catch (e) {
      emit(RequestCounterFailure(state.vm, ErrorInfo(object: e)));
    }
  }
}

