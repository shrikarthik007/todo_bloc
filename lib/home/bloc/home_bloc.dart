import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/services/authentication.dart';
import 'package:todo_app/services/todo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthenticationService _auth;
  final TodoService _todo;
  HomeBloc(this._auth, this._todo) : super(RegisteringServicesState()) {
    on<LoginEvent>((event, emit) async {
      final user = await _auth.authenticateUser(event.userName, event.password);
      if (user != 'hi') {
        emit(SuccessfullLoginState(user));
        emit(HomeInitial());
      }
    });
    on<RegisterAccountEvent>((event, emit) async {
      final result = await _auth.createUser(event.userName, event.password);
      switch (result) {
        case UserCreationResult.success:
          // TODO: Handle this case.
          emit(SuccessfullLoginState(event.userName));
          break;
        case UserCreationResult.failure:
          // TODO: Handle this case.
          emit(HomeInitial(error: 'There has been an error'));
          break;
        case UserCreationResult.already_exists:
          // TODO: Handle this case.
          emit(HomeInitial(error: 'User already exists'));
          break;
      }
    });

    on<RegisterServicesEvent>((event, emit) async {
      await _auth.init();
      await _todo.init();
      emit(HomeInitial());
    });
  }
}
