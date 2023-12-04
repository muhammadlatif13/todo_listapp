// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

class HomeState {
  List<Task> tasks;
  HomeState({
    required this.tasks,
  });

  HomeState copyWith(List<Task> newTasks) {
    return HomeState(tasks: newTasks);
  }
}

class LoadingState extends HomeState {
  LoadingState({required super.tasks});
}