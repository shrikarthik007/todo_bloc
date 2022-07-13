import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/services/authentication.dart';
import 'package:todo_app/services/todo.dart';
import 'package:todo_app/todos/todos.dart';

import 'bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  final usernameField = TextEditingController();
  final passwordField = TextEditingController();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login to Todo App'),
      ),
      body: BlocProvider(
        create: (context) => HomeBloc(
          RepositoryProvider.of<AuthenticationService>(context),
          RepositoryProvider.of<TodoService>(context),
        )..add(RegisterServicesEvent()),
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is SuccessfullLoginState) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TodosPage(userName: state.userName)));
            }
            if (state is HomeInitial) {
              if (state.error != null)
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('error'),
                    content: Text(
                      state.error!,
                    ),
                  ),
                );
            }
          },
          builder: (context, state) {
            if (state is HomeInitial) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'UserName'),
                      controller: usernameField,
                    ),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'Password'),
                      controller: passwordField,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<HomeBloc>(context).add(LoginEvent(
                                usernameField.text, passwordField.text));
                          },
                          child: Text('Login'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<HomeBloc>(context).add(
                                  RegisterAccountEvent(
                                      usernameField.text, passwordField.text));
                            },
                            child: Text('Register'))
                      ],
                    )
                  ],
                ),
              );
            }
            return Container(
              child: Text(
                'Hi there',
                style: TextStyle(color: Colors.black),
              ),
            );
          },
        ),
      ),
    );
  }
}
