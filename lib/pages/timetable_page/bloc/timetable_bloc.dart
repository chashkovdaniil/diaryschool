import 'dart:async';
import 'package:bloc/bloc.dart';
import 'bloc.dart';

class TimetableBloc extends Bloc<TimetableEvent, TimetableState> {
  @override
  TimetableState get initialState => InitialTimetableState();

  @override
  Stream<TimetableState> mapEventToState(
    TimetableEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
