import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'addtasks_event.dart';
part 'addtasks_state.dart';

class AddtasksBloc extends Bloc<AddtasksEvent, AddtasksState> {
  AddtasksBloc()
      : super(AddtasksState(name: '', desc: '', completeBy: DateTime.now())) {
    on<GetTaskNameEvent>((event, emit) {
      emit(state.copyWith(name: event.name));
    });
    on<GetDescriptionEvent>((event, emit) {
      emit(state.copyWith(desc: event.desc));
    });
    on<GetCompleteByEvent>((event, emit) {
      emit(state.copyWith(completeBy: event.completeBy));
    });
    on<NavigateToHomePageEvent>((event, emit) {
      Navigator.pop(event.context);
    });
  }
}
