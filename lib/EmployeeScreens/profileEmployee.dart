import 'package:employeemanager/models/employees.dart';
import 'package:flutter/material.dart';

class ProfileEmplyee extends StatefulWidget {

  final Employee employee;


  ProfileEmplyee({this.employee});

  @override
  _ProfileEmplyeeState createState() => _ProfileEmplyeeState();
}

class _ProfileEmplyeeState extends State<ProfileEmplyee> {

  final Employee employee;


  _ProfileEmplyeeState({this.employee});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
