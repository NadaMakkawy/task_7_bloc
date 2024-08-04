import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../models/employee.dart';
import '../repository/employee_repository.dart';
part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeRepository _employeeRepository;
  List<Employee> _employees = [];

  EmployeeBloc(this._employeeRepository) : super(EmployeeLoadingState()) {
    on<LoadEmployeeEvent>(loadEmployee);
    on<DeleteEmployeeEvent>(deleteEmployee);
    on<AddEmployeeEvent>(addEmployee);
  }

  // FutureOr<void> loadEmployee(
  //     LoadEmployeeEvent event, Emitter<EmployeeState> emit) async {
  //   emit(EmployeeLoadingState());
  //   await _employeeRepository.getEmployees().then((employees) {
  //     emit(EmployeeLoadedState(employees));
  //   }).catchError((error) {
  //     emit(EmployeeErrorState(error.toString()));
  //   });
  // }

  FutureOr<void> loadEmployee(
      LoadEmployeeEvent event, Emitter<EmployeeState> emit) async {
    emit(EmployeeLoadingState());
    try {
      _employees = await _employeeRepository.getEmployees();
      emit(EmployeeLoadedState(_employees));
    } catch (error) {
      emit(EmployeeErrorState(error.toString()));
    }
  }

  FutureOr<void> deleteEmployee(
      DeleteEmployeeEvent event, Emitter<EmployeeState> emit) {
    if (event.index >= 0 && event.index < _employees.length) {
      _employees.removeAt(event.index);
      emit(EmployeeLoadedState(_employees));
    }
  }

  FutureOr<void> addEmployee(
      AddEmployeeEvent event, Emitter<EmployeeState> emit) {
    _employees.add(event.employee);
    emit(EmployeeLoadedState(_employees));
  }
}
