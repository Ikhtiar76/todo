import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/bloc/task_bloc.dart';
import 'package:todo/home_screen.dart';
import 'package:todo/repository/repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TodoRepository(),
      child: BlocProvider(
        create: (context) => TaskBloc(
          todoRepository: RepositoryProvider.of<TodoRepository>(context),
        )..add(InitBox()),
        child: const MaterialApp(
          home: HomeScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
