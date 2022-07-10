import 'package:hive/hive.dart';
import 'package:todo_app/models/task.dart';

class TodoService {
  late Box<Task> _tasks;

  Future<void> init() async {
    Hive.registerAdapter(TaskAdapter());
    _tasks = await Hive.openBox<Task>('tasks');
    await _tasks.clear();
    await _tasks.add(Task('Shrikarthik', 'Complete first video', true));
    await _tasks
        .add(Task('Shrikarthik1', 'Complete first and second video', false));
  }

  List<Task> getTasks(final String userName) {
    final tasks = _tasks.values.where((element) => element.user == userName);
    return tasks.toList();
  }

  void addTask(final String task, final String userName) {
    _tasks.add(Task(userName, task, false));
  }

  void removeTask(final String task, final String userName) async {
    final taskToRemove = _tasks.values.firstWhere(
        (element) => element.task == task && element.user == userName);
    await taskToRemove.delete();
  }

  Future<void> updateTask(final String task, final String userName,
      {final bool? completed}) async {
    final taskToEdit = _tasks.values.firstWhere(
        (element) => element.task == task && element.user == userName);
    final index = taskToEdit.key as int;
    await _tasks.put(
        index, Task(userName, task, completed ?? taskToEdit.completed));
  }
}
