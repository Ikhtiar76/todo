part of 'task_bloc.dart';

sealed class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> taskList;

  const TaskLoaded({required this.taskList});
}

class TaskError extends TaskState {
  final String error;

  const TaskError({required this.error});
}
