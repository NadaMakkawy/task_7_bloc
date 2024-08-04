import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../models/employee.dart';
import '../repository/employee_repository.dart';
part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeRepository _employeeRepository;
  EmployeeBloc(this._employeeRepository) : super(EmployeeLoadingState()) {
    on<LoadEmoloyeeEvent>(loadEmployee);
  }

  FutureOr<void> loadEmployee(
      LoadEmoloyeeEvent event, Emitter<EmployeeState> emit) async {
    emit(EmployeeLoadingState());
    await _employeeRepository.getEmployees().then((employees) {
      emit(EmployeeLoadedState(employees));
    }).catchError((error) {
      emit(EmployeeErrorState(error.toString()));
    });
  }
}
