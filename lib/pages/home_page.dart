import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/employee_bloc.dart';

import '../widgets/add_employee_widget.dart';
import '../widgets/employees_list.dart';

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
            return EmployeesList(
              state: state,
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
        onPressed: () => _showAddEmployeeDialog(context),
        tooltip: 'Add Employee',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddEmployeeDialog(BuildContext context) {
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddEmployeeWidget(
          firstNameController: firstNameController,
          lastNameController: lastNameController,
          emailController: emailController,
        );
      },
    );
  }
}
