// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

abstract class HomeEvent {}

class InitialEvent extends HomeEvent {
  InitialEvent() : super();
}

class AddTaskEvent extends HomeEvent {
  String task;
  String? desc;
  DateTime completeBy;
  AddTaskEvent({
    required this.task,
    required this.completeBy,
    this.desc,
  }) : super();
}

class MarkDoneEvent extends HomeEvent {
  int index;
  MarkDoneEvent({
    required this.index,
  }) : super();
}

class RemoveTaskEvent extends HomeEvent {
  Task task;
  RemoveTaskEvent({
    required this.task,
  });
}

class NavigateToAddTasksPage extends HomeEvent {
  BuildContext context;
  NavigateToAddTasksPage({
    required this.context,
  });
}
