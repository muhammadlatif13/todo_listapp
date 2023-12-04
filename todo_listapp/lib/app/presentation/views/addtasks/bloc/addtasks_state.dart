// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'addtasks_bloc.dart';

class AddtasksState {
  String name;
  String? desc = '';
  DateTime completeBy;
  AddtasksState({
    required this.name,
    this.desc,
    required this.completeBy,
  });

  AddtasksState copyWith({
    String? name,
    String? desc,
    DateTime? completeBy,
  }) {
    return AddtasksState(
      name: name ?? this.name,
      desc: desc ?? this.desc,
      completeBy: completeBy ?? this.completeBy,
    );
  }
}
