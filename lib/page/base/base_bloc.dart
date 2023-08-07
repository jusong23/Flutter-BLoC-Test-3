import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseBloc<Event, State> extends Bloc<Event, State> {
  BaseBloc(State initialState, {bool useSequentialHandleEvent = true}) : super(initialState) {
    _throttleEventController.stream.throttleTime(const Duration(seconds: 1)).listen(add);
    if (useSequentialHandleEvent) {
      on<Event>(handleEvent, transformer: sequential());
    }
  }

  final _throttleEventController = StreamController<Event>();

  void addThrottle(Event event) {
    if (_throttleEventController.isClosed) {
      return;
    }
    _throttleEventController.add(event);
  }

  @override
  Future<void> close() async {
    await _throttleEventController.close();
    return super.close();
  }

  Future<void> handleEvent(Event event, Emitter<State> emit) async {}
}
