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
                children: [
                  ...state.tasks.map((e) => ListTile(
                        title: Text(e.task),
                        trailing: Checkbox(
                            value: e.completed,
                            onChanged: (val) {
                              BlocProvider.of<TodoBloc>(context)
                                  .add(ToggletodoEvent(e.task));
                            }),
                      )),
                  ListTile(
                    title: Text('Create new task'),
                    onTap: () async {
                      final result = await showDialog<String>(
                          context: context,
                          builder: (context) => Dialog(
                                child: CreateNewTaskState(),
                              ));

                      if (result != null) {
                        BlocProvider.of<TodoBloc>(context)
                            .add(AddTodoEvent(result));
                      }
                    },
                    trailing: Icon(Icons.create),
                  )
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class CreateNewTaskState extends StatefulWidget {
  const CreateNewTaskState({Key? key}) : super(key: key);

  @override
  State<CreateNewTaskState> createState() => _CreateNewTaskStateState();
}

class _CreateNewTaskStateState extends State<CreateNewTaskState> {
  final _inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('What task do you want to create?'),
          TextField(
            controller: _inputController,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(_inputController.text);
              },
              child: Text('Save'))
        ],
      ),
    );
  }
}
