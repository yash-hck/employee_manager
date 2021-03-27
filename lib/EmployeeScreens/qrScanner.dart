import 'dart:io';

import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:employeemanager/EmployeeScreens/employeeAttendence.dart';
import 'package:employeemanager/models/employees.dart';
import 'package:employeemanager/utils/employeeCRUD.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanner extends StatefulWidget {

  final Employee employee;

  QrScanner({this.employee});

  @override
  _QrScannerState createState() => _QrScannerState(employee: employee);
}

class _QrScannerState extends State<QrScanner> {

  final Employee employee;


  _QrScannerState({this.employee});

  String qrCodeResult = "Not Yet Scanned";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan QR Code"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Message displayed over here
            Text(
              "Result",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              qrCodeResult,
              style: TextStyle(
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),

            //Button to scan QR code
            FlatButton(
              padding: EdgeInsets.all(15),
              onPressed: () async {


                String codeSanner = await BarcodeScanner.scan();    //barcode scnner
                if(codeSanner!=null && codeSanner !=''){
                  EmployeeCRUD.MarkAndChangeStatus(employee, codeSanner);
                }
                setState(() {
                  qrCodeResult = codeSanner;
                });
              },
              child: Text("Open Scanner",style: TextStyle(color: Colors.indigo[900]),),
              //Button having rounded rectangle border
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.indigo[900]),
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),

          ],
        ),
      ),
    );
  }
}