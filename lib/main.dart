import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_7_bloc/bloc/employee_bloc.dart';
import 'package:task_7_bloc/cubit/counter/counter_cubit.dart';
import 'package:task_7_bloc/repository/employee_repository.dart';

import 'pages/home_page.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => CounterCubit(),
      ),
      BlocProvider<EmployeeBloc>(
        create: (context) => EmployeeBloc(EmployeeRepository()),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter BLoC Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'BLoC'),
    );
  }
}
