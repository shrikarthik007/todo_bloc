part of 'todos_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

class LoadTodoEvent extends TodoEvent {
  final String userName;

  LoadTodoEvent(this.userName);
  @override
  List<Object> get props => [userName];
}

class AddTodoEvent extends TodoEvent {
  final String todoText;

  AddTodoEvent(this.todoText);
  @override
  // TODO: implement props
  List<Object?> get props => [todoText];
}

class ToggletodoEvent extends TodoEvent {
  final String todoTask;

  ToggletodoEvent(this.todoTask);
  @override
  // TODO: implement props
  List<Object?> get props => [todoTask];
}
