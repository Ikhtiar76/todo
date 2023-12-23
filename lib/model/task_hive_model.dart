import 'package:hive/hive.dart';

part 'task_hive_model.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  final String taskName;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final String id;

  Task({required this.taskName, required this.description, required this.id});
}
