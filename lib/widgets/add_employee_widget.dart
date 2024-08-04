import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/employee_bloc.dart';
import '../models/employee.dart';

class AddEmployeeWidget extends StatelessWidget {
  const AddEmployeeWidget({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
  });

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Employee'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: firstNameController,
            decoration: const InputDecoration(labelText: 'First Name'),
          ),
          TextField(
            controller: lastNameController,
            decoration: const InputDecoration(labelText: 'Last Name'),
          ),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Add'),
          onPressed: () {
            final newEmployee = Employee(
              name: Name(
                first: firstNameController.text,
                last: lastNameController.text,
              ),
              email: emailController.text,
            );
            context.read<EmployeeBloc>().add(AddEmployeeEvent(newEmployee));
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
