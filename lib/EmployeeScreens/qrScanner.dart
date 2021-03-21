import 'package:employeemanager/models/employees.dart';
import 'package:flutter/material.dart';

class QrScanner extends StatefulWidget {

  final Employee employee;

  QrScanner({this.employee});

  @override
  _QrScannerState createState() => _QrScannerState(employee: employee);
}

class _QrScannerState extends State<QrScanner> {

  final Employee employee;


  _QrScannerState({this.employee});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
