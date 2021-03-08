
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employeemanager/models/employees.dart';
import 'package:employeemanager/models/manager.dart';
import 'package:employeemanager/models/payments.dart';
import 'package:employeemanager/screens/dashboard.dart';
import 'package:employeemanager/utils/configs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirestoreCRUD{

  static Future<bool> SignUp(BuildContext context,Manager manager) async{
    int length = 0;

    await FirebaseFirestore.instance.collection('managers')
        .where('email',isEqualTo: manager.email)
        .get().
    then((QuerySnapshot querySnapshot){
      length = querySnapshot.docs.length;
    });

    if(length > 0){
      return false;
    }
    manager.mob = "123450";
    manager.dateJoined = DateTime.now().toString();

    await FirebaseFirestore.instance.collection('managers').add(manager.toMap()).
    then((value) {
      manager.documentId = value.id;
      //print('manager id -------- ' + manager.documentId);
    });
    storeData(manager);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => DashBoard(incoming: manager,)),(Route<dynamic> route) => false);
    return true;
  }

  static Future<QuerySnapshot> getDocsforLogin(String email, String pass) async{

    return await FirebaseFirestore.instance.collection('managers').where('email',isEqualTo: email).where('pass',isEqualTo: pass).get();

  }

  static Future<bool> handleLogin(BuildContext context, String email, String pass) async{

    Manager incoming = Manager.blank();
    bool logged = false;
    await getDocsforLogin(email, pass)
        .then((QuerySnapshot docs) {
          print('inside then');
          try{
            print('inside try');
            incoming = Manager.fromMapObject(docs.docs[0].data());
            print('incoming msde');
            incoming.documentId = docs.docs[0].id;
            print('incoming initiallised');
            storeData(incoming);
            print('data stored');
            logged = true;
            print('logged');
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashBoard(incoming: incoming)));
          }
          catch(e){
            print('Wrong Credentials');

            print(e);
          }
        });

    return logged;
  }

  static Future<bool> addEmployee(BuildContext context,Employee employee) async{

    int length = 0;
   print(employee.managerDocumentId);
    await FirebaseFirestore.instance.collection('managers')
        .doc(employee.managerDocumentId)
        .collection('employees').where('email',isEqualTo: employee.email)
        .get().then((QuerySnapshot querySnampshot){
          length = querySnampshot.docs.length;
    });

    if(length > 0){
      print('length issue');
      return false;
    }
    employee.dateJoined = DateTime.now().toString();
    await FirebaseFirestore.instance.collection('managers')
      .doc(employee.managerDocumentId)
    .collection('employees')
    .add(employee.toMap());

    Navigator.of(context).pop();

    return true;

  }
  
  static Future<List<String>> fetchRecipents()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    
    String jsonId = preferences.getString('jsonId');
    List<String > recipents = [];
    await FirebaseFirestore.instance.collection('managers').doc(jsonId).collection('employees')
    .get().then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) {
        print(doc['email'].toString());
        recipents.add(doc["email"]);
      })
    });

    return recipents;
  }


  static void storeData(Manager manager) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('jsonId', manager.documentId);
    prefs.setString('storedObject', json.encode(manager.toMap()));
    prefs.setString('email', manager.email);
    prefs.setString('name', manager.name);

  }

  static Future<List<Employee>> getEmployeeList() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<Employee> list = [];
    await FirebaseFirestore.instance.collection('managers').doc(await preferences.getString('jsonId')).collection('employees').get()
    .then((QuerySnapshot querySnapshot){
      querySnapshot.size;
      querySnapshot.docs.forEach((element) {
        //print(element.toString());
        Employee employee = Employee.fromMapObject(element.data());
        list.add(employee);

      });
    });

    return list;
  }

  static Future<bool> addPayment(Manager manager,Employee employee,Payments payments)async{

    print('email' + employee.email);
    payments.recipent = employee.email;

    var data = await FirebaseFirestore.instance.collection(MANAGER_COLLECTION).doc(manager.documentId)
        .collection(EMPLOYEES_COLLECTION)
        .where('email',isEqualTo: employee.email).get();

    print('length => '+ data.docs.length.toString());

    if(data.docs.length >1)return false;

    var result = await data.docs[0].id;
    print(result.toString());
    try{
      await FirebaseFirestore.instance.collection(MANAGER_COLLECTION)
          .doc(manager.documentId)
          .collection(EMPLOYEES_COLLECTION)
          .doc(result)
          .collection('payments')
          .add(payments.toMap());

      }
      catch(e){
      print(e.toString());
      }
     return true;
    }




}