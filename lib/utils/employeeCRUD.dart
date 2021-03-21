import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employeemanager/EmployeeScreens/employeeDashboard.dart';
import 'package:employeemanager/models/employees.dart';
import 'package:employeemanager/utils/configs.dart';
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

          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => EmployeeDashboard()),(Route<dynamic> route) => false);
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


}