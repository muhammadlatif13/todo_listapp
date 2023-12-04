import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_listapp/app/config/global/init.dart';
import 'package:todo_listapp/app/domain/models/task.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState(tasks: [])) {
    on<InitialEvent>(
      (event, emit) async {
        String t = await Global.prefs.getString('tasks');
        if (t.isNotEmpty) {
          List<Task> tasks = Task.decode(t);
          emit(HomeState(tasks: tasks));
        } else {
          emit(HomeState(tasks: []));
        }
      },
    );
    on<AddTaskEvent>(
      (event, emit) async {
        List<Task> tasks = state.tasks;
        Task newtask = Task(
          name: event.task,
          desc: event.desc,
          completeBy: event.completeBy,
        );
        tasks.add(newtask);
        await Global.prefs.setString('tasks', Task.encode(tasks));
        var t = await Global.prefs.getString('tasks');
        var temp = Task.decode(t);
        emit(state.copyWith(temp));
      },
    );
    on<MarkDoneEvent>(
      (event, emit) {
        List<Task> tasks = state.tasks;
        tasks[event.index].isCompleted = !tasks[event.index].isCompleted!;
        emit(state.copyWith(tasks));
      },
    );
    on<RemoveTaskEvent>(
      (event, emit) {
        List<Task> tasks = state.tasks;
        tasks.remove(event.task);
        emit(state.copyWith(tasks));
      },
    );

    on<NavigateToAddTasksPage>(
      (event, emit) => Navigator.of(event.context).pushNamed('/addTasks'),
    );
  }
}