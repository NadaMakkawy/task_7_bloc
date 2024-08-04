import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/employee_bloc.dart';

class EmployeesList extends StatelessWidget {
  final EmployeeLoadedState state;
  const EmployeesList({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: state.employees.length + 1,
      itemBuilder: (context, index) => index < state.employees.length
          ? Dismissible(
              key: Key(state.employees[index].name?.first ?? 'No Name'),
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (direction) {
                context.read<EmployeeBloc>().add(DeleteEmployeeEvent(index));
              },
              direction: DismissDirection.endToStart,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ListTile(
                  title: Text(
                    state.employees[index].name?.first ?? 'No Name',
                  ),
                  subtitle: Text(
                    state.employees[index].email ?? 'No Email',
                  ),
                  // trailing: IconButton(
                  //   icon: const Icon(Icons.delete),
                  //   onPressed: () {
                  //     context
                  //         .read<EmployeeBloc>()
                  //         .add(DeleteEmployeeEvent(index));
                  //   },
                  // ),
                ),
              ),
            )
          : Container(height: 60),
    );
  }
}
