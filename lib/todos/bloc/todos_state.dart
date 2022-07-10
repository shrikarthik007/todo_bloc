part of 'todos_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();
}

class TodoInitial extends TodoState {
  @override
  List<Object> get props => [];
}

class TodoLoadedState extends TodoState {
  final List<Task> tasks;

  TodoLoadedState(this.tasks);

  @override
  // TODO: implement props
  List<Object?> get props => [tasks];
}
