import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employeemanager/EmployeeScreens/employeeDashboard.dart';
import 'package:employeemanager/models/attendence.dart';
import 'package:employeemanager/models/employees.dart';
import 'package:employeemanager/utils/configs.dart';
import 'package:employeemanager/utils/firestoreCrud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeCRUD{


  static handleLogin(BuildContext context, String email, String pass) async{
    await FirebaseFirestore.instance
        .collection(EMPLOYEES_COLLECTION)
        .where('email', isEqualTo: email).where('pass', isEqualTo: pass)
        .get().then((QuerySnapshot snapshot){

          if(snapshot.docs.length != 1){
            print('more then one user');
            return false;
          }
          Employee employee = Employee.fromMapObject(snapshot.docs[0].data());
          employee.document_id = snapshot.docs[0].id;
          storeData(employee);

          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => EmployeeDashboard(employee: employee,)),(Route<dynamic> route) => false);
    });
    return true;
  }

  static Future<void> storeData(Employee employee) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('jsonId', employee.document_id);
    prefs.setString('storedObject', json.encode(employee.toMap()));
    prefs.setString('email', employee.email);
    prefs.setString('name', employee.name);
    prefs.setString('type', EMPLOYEE_CODE);


  }

  static Future<double> getPayments(Employee employee) async{



  }

  static Future<void> MarkAndChangeStatus(Employee employee, String codeSanner) async {

    String date ;
    
    if(await FirebaseFirestore.instance
    .collection(EMPLOYEES_COLLECTION)
    .doc(employee.document_id)
    .collection('checkIn')
    .where('date', isGreaterThan: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).toString())
    .get().then((value) {
      if(value.docs.length > 0)
      date = value.docs[0]['date'];
      return value.docs.length > 0;})){

      await FirebaseFirestore.instance
          .collection(EMPLOYEES_COLLECTION)
          .doc(employee.document_id)
          .collection('chekout')
          .add({'date':DateTime.now().toString()});
          await setActiveStatus(employee, false);
          double sub = DateTime.now().difference(DateTime.parse(date)).inMinutes.toDouble();
          sub = sub/60.0;
          print('sub'+ sub.toString());
          double over = sub > 8.5?sub-8.5:sub;

          Attendence attendence = Attendence(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).toString(),over , sub >=8.5);

          await FirestoreCRUD.addAttendenceList(employee,  attendence);

    }
    else{
      await FirebaseFirestore.instance
          .collection(EMPLOYEES_COLLECTION)
          .doc(employee.document_id)
          .collection('checkIn')
          .add({'date':DateTime.now().toString()});
      await setActiveStatus(employee, true);

    }


    
  }

  static setActiveStatus(Employee employee, bool val) async{

    await FirebaseFirestore.instance
        .collection(EMPLOYEES_COLLECTION)
        .doc(employee.document_id)
        .update({'active': val});

  }

}