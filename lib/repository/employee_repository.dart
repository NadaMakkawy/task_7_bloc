import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/employee.dart';

class EmployeeRepository {
  Future<List<Employee>> getEmployees() async {
    try {
      var result = await rootBundle.loadString('assets/employees.json');
      var employees = json.decode(result);
      return List<Employee>.from(
          employees.map((json) => Employee.fromJson(json)).toList());
    } catch (e) {
      rethrow;
    }
  }
}
