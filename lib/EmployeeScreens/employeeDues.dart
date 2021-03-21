import 'package:employeemanager/models/employees.dart';
import 'package:flutter/material.dart';

class EmployeeDues extends StatefulWidget {

  final Employee employee;


  EmployeeDues({this.employee});

  @override
  _EmployeeDuesState createState() => _EmployeeDuesState(employee: employee);
}

class _EmployeeDuesState extends State<EmployeeDues> {

  final Employee employee;


  _EmployeeDuesState({this.employee});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
