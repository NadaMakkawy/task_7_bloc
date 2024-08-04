part of 'employee_bloc.dart';

@immutable
sealed class EmployeeEvent {}

class LoadEmployeeEvent extends EmployeeEvent {}

class DeleteEmployeeEvent extends EmployeeEvent {
  final int index;

  DeleteEmployeeEvent(this.index);
}
