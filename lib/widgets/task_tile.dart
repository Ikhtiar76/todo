import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/task_bloc.dart';
import 'package:todo/model/task_hive_model.dart';
import 'package:todo/task%20details/task_details.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.task,
    required this.index,
    required this.showUserUpdateDialog,
  }) : super(key: key);
  final Task task;
  final int index;
  final VoidCallback showUserUpdateDialog;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(task.key.toString()),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (_) {
        BlocProvider.of<TaskBloc>(context).add(
          DeleteEvent(
            id: task.id,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TaskDetails(
                    task: task,
                  ),
                ),
              );
            },
            key: Key(task.key.toString()),
            leading: CircleAvatar(
              backgroundColor: Colors.blue[800],
              child: Text(
                (index + 1).toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(task.taskName),
            subtitle: Text(task.description),
            trailing: IconButton(
              onPressed: () {
                showUserUpdateDialog();
              },
              icon: Icon(
                Icons.edit_document,
                color: Colors.blue[800],
              ),
            )),
      ),
    );
  }
}
