import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/model/task_hive_model.dart';
import 'package:todo/repository/repository.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TodoRepository todoRepository;
  TaskBloc({required this.todoRepository}) : super(TaskInitial()) {
    on<InitBox>((event, emit) async {
      await todoRepository.init();
      add(FetchAllTask());
    });
    on<FetchAllTask>(
      (event, emit) async {
        try {
          emit(TaskLoading());
          // ignore: await_only_futures
          final taskList = await todoRepository.get();
          emit(TaskLoaded(taskList: taskList));
        } catch (e) {
          emit(TaskError(error: e.toString()));
        }
      },
    );
    on<AddEvent>(
      (event, emit) async {
        try {
          emit(TaskLoading());
          final addTask = await todoRepository.addTask(event.newTask);
          emit(TaskLoaded(taskList: addTask));
        } catch (e) {
          emit(TaskError(error: e.toString()));
        }
      },
    );

    on<DeleteEvent>((event, emit) async {
      try {
        emit(TaskLoading());
        final updateTaskList = await todoRepository.deleteTask(event.id);
        emit(TaskLoaded(taskList: updateTaskList));
      } catch (e) {
        emit(TaskError(error: e.toString()));
      }
    });
    on<UpdateEvent>((event, emit) async {
      try {
        emit(TaskLoading());
        final updateTaskList = await todoRepository.updateTask(event.task);
        emit(TaskLoaded(taskList: updateTaskList));
      } catch (e) {
        emit(TaskError(error: e.toString()));
      }
    });
  }
}
