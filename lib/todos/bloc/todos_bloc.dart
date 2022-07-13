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
      emit(TodoLoadedState(todos, event.userName));
    });
    on<AddTodoEvent>(((event, emit) {
      final currentState = state as TodoLoadedState;
      _todoService.addTask(event.todoText, currentState.userName);
      add(LoadTodoEvent(currentState.userName));
    }));

    on<ToggletodoEvent>((event, emit) async {
      final currentState = state as TodoLoadedState;
      await _todoService.updateTask(
        event.todoTask,
        currentState.userName,
      );
      add(LoadTodoEvent(currentState.userName));
    });
  }
}
