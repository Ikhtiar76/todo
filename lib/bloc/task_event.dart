part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class InitBox extends TaskEvent {}

class FetchAllTask extends TaskEvent {}

class AddEvent extends TaskEvent {
  final Task newTask;

  const AddEvent({required this.newTask});
}

class DeleteEvent extends TaskEvent {
  final String id;

  const DeleteEvent({required this.id});
}

class UpdateEvent extends TaskEvent {
  final Task task;

  const UpdateEvent({required this.task});
}
