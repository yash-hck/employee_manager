
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employeemanager/models/manager.dart';
import 'package:employeemanager/screens/dashboard.dart';
import 'package:flutter/material.dart';
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

  static void storeData(Manager manager) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('jsonId', manager.documentId);
    prefs.setString('storedObject', json.encode(manager.toMap()));

  }

}