import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/employee_bloc.dart';
import '../cubit/counter_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<EmployeeBloc>().add(LoadEmployeeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),
      body: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is EmployeeLoadedState) {
            return ListView.builder(
              itemCount: state.employees.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(
                  state.employees[index].name?.first ?? 'No Name',
                ),
                subtitle: Text(
                  state.employees[index].email ?? 'No Email',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    context
                        .read<EmployeeBloc>()
                        .add(DeleteEmployeeEvent(index));
                  },
                ),
              ),
            );
          }
          if (state is EmployeeErrorState) {
            return Center(
              child: Text('Employees: ${state.error}'),
            );
          }
          return const CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<CounterCubit>().increment(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
