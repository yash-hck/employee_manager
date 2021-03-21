import 'package:employeemanager/models/employees.dart';
import 'package:flutter/material.dart';

class EmployeeDashboard extends StatefulWidget {

  final Employee employee;

  EmployeeDashboard({this.employee});

  @override
  _EmployeeDashboardState createState() => _EmployeeDashboardState(employee: employee);
}

class _EmployeeDashboardState extends State<EmployeeDashboard> {

  final Employee employee;


  _EmployeeDashboardState({this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
