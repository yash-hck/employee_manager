import 'package:employeemanager/models/employees.dart';
import 'package:flutter/material.dart';

class EmployeePayments extends StatefulWidget {

  final Employee employee;

  EmployeePayments({this.employee});

  @override
  _EmployeePaymentsState createState() => _EmployeePaymentsState(employee: employee);
}

class _EmployeePaymentsState extends State<EmployeePayments> {

  final Employee employee;


  _EmployeePaymentsState({this.employee});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
