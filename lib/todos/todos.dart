import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/services/todo.dart';
import 'package:todo_app/todos/bloc/todos_bloc.dart';

class TodosPage extends StatelessWidget {
  final String userName;
  const TodosPage({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: BlocProvider(
        create: (context) => TodoBloc(
          RepositoryProvider.of<TodoService>(context),
        )..add(LoadTodoEvent(userName)),
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is TodoLoadedState) {
              return ListView(
                children: state.tasks
                    .map((e) => ListTile(
                          title: Text(e.task),
                          trailing:
                              Checkbox(value: e.completed, onChanged: (val) {}),
                        ))
                    .toList(),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
