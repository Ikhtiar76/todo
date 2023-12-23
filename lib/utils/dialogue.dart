import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/task_bloc.dart';
import 'package:todo/model/task_hive_model.dart';
import 'package:uuid/uuid.dart';

Future<dynamic> showUserAddDialog(
  BuildContext context,
) {
  final titleCtlr = TextEditingController();
  final desCtlr = TextEditingController();

  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      content: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextField(
                    controller: titleCtlr,
                    decoration: InputDecoration(
                        hintText: 'Add Title...',
                        labelStyle: TextStyle(
                            color: Colors.lightBlue[900],
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                        labelText: "Title",
                        border: InputBorder.none),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: desCtlr,
                    maxLines: 5,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'write your tasks.....',
                      labelStyle: TextStyle(
                          color: Colors.lightBlue[900],
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                      labelText: "Description",
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                final task = Task(
                  taskName: titleCtlr.text,
                  description: desCtlr.text,
                  id: const Uuid().v4(),
                );
                BlocProvider.of<TaskBloc>(context).add(
                  AddEvent(newTask: task),
                );
                titleCtlr.clear();
                desCtlr.clear();

                Navigator.pop(context);
              },
              child: Container(
                  height: MediaQuery.sizeOf(context).height * 0.05,
                  width: MediaQuery.sizeOf(context).width / 2,
                  decoration: BoxDecoration(
                      color: Colors.lightBlue[900],
                      borderRadius: BorderRadius.circular(20)),
                  child: const Center(
                      child: Text(
                    "Add",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ))),
            ),
          ],
        ),
      ),
    ),
  );
}

Future<dynamic> showUserUpdateDialog(
  BuildContext context,
  Task task,
) {
  final titleCtrl = TextEditingController();
  final desCtlr = TextEditingController();

  titleCtrl.text = task.taskName;
  desCtlr.text = task.description;

  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      content: SizedBox(
        height: 250,
        child: Column(
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(
                labelText: "Title",
              ),
            ),
            TextField(
              controller: desCtlr,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Description",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                final updatedUser = Task(
                  taskName: titleCtrl.text,
                  description: desCtlr.text,
                  id: task.id,
                );
                BlocProvider.of<TaskBloc>(context).add(
                  UpdateEvent(task: updatedUser),
                );
                titleCtrl.clear();
                desCtlr.clear();
                Navigator.pop(context);
              },
              child: const Text("Update"),
            ),
          ],
        ),
      ),
    ),
  );
}
