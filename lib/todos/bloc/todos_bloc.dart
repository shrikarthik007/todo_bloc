import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/services/todo.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoService _todoService;
  TodoBloc(this._todoService) : super(TodoInitial()) {
    on<LoadTodoEvent>((event, emit) {
      // TODO: implement event handler
      final todos = _todoService.getTasks(event.userName);
      emit(TodoLoadedState(todos));
    });
  }
}
