import 'package:hive/hive.dart';
import 'package:todo/model/task_hive_model.dart';

class TodoRepository {
  late final Box _todoBox;
  Box get todoBox => _todoBox;

  Future<void> init() async {
    Hive.registerAdapter(TaskAdapter());
    _todoBox = await Hive.openBox('task');
  }

  List<Task> get() {
    final taskList =
        _todoBox.values.map((dynamic value) => value as Task).toList();
    return taskList;
  }

  Future<List<Task>> addTask(Task newTasks) async {
    await _todoBox.add(newTasks);
    return get();
  }

  Future<List<Task>> deleteTask(String id) async {
    final taskToDelete =
        await _todoBox.values.firstWhere((element) => element.id == id);
    await taskToDelete.delete();
    return get();
  }

  Future<List<Task>> updateTask(Task task) async {
    final taskToUpdate =
        await _todoBox.values.firstWhere((element) => element.id == task.id);
    final index = taskToUpdate.key;
    await _todoBox.put(index, task);
    return get();
  }
}
