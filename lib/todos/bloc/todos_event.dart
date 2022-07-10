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
