import 'package:employeemanager/models/employees.dart';
import 'package:flutter/material.dart';

class EmployeeAttendence extends StatefulWidget {

  final Employee employee;


  EmployeeAttendence({this.employee});

  @override
  _EmployeeAttendenceState createState() => _EmployeeAttendenceState(employee: employee);
}

class _EmployeeAttendenceState extends State<EmployeeAttendence> {

  final Employee employee;


  _EmployeeAttendenceState({this.employee});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
