import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/task_bloc.dart';
import 'package:todo/utils/dialogue.dart';
import 'package:todo/widgets/task_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[900],
        title: const Text(
          "To Do",
          style: TextStyle(
              fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue[900],
        shape: const CircleBorder(),
        onPressed: () {
          showUserAddDialog(
            context,
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 50,
        ),
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TaskLoaded) {
            if (state.taskList.isNotEmpty) {
              return ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.grey,
                  thickness: 1,
                  endIndent: 20,
                  indent: 20,
                ),
                itemCount: state.taskList.length,
                itemBuilder: (BuildContext context, int index) {
                  return TaskTile(
                    task: state.taskList[index],
                    index: index,
                    showUserUpdateDialog: () {
                      showUserUpdateDialog(
                        context,
                        state.taskList[index],
                      );
                    },
                  );
                },
              );
            } else {
              return const Center(
                child: Text(
                  "You have no task",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              );
            }
          }
          if (state is TaskError) {
            return Center(
              child: Text(state.error),
            );
          }
          return Container();
        },
      ),
    );
  }
}
