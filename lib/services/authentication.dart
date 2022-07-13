import 'package:hive/hive.dart';
import 'package:todo_app/models/user.dart';

class AuthenticationService {
  late Box<User> _users;

  Future<void> init() async {
    Hive.registerAdapter(UserAdapter());
    _users = await Hive.openBox<User>('userBox');
    await _users.clear();

    await _users.add(User('Shrikarthik', 'Password123'));
    await _users.add(User('Shrikarthik1', 'Password1234'));
  }

  Future<String> authenticateUser(
      final String userName, final String password) async {
    final success = await _users.values.any((element) =>
        element.userName == userName && element.password == password);
    if (success) {
      return userName;
    } else {
      return 'hi';
    }
  }

  Future<UserCreationResult> createUser(
      final String userName, final String password) async {
    final alreadyExists = _users.values.any(
        (element) => element.userName.toLowerCase() == userName.toLowerCase());
    if (alreadyExists) {
      return UserCreationResult.already_exists;
    }
    try {
      _users.add(User(userName, password));
      return UserCreationResult.success;
    } catch (ex) {
      return UserCreationResult.failure;
    }
  }
}

enum UserCreationResult { success, failure, already_exists }
