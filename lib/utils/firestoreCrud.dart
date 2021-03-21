
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employeemanager/models/attendence.dart';
import 'package:employeemanager/models/employees.dart';
import 'package:employeemanager/models/manager.dart';
import 'package:employeemanager/models/payments.dart';
import 'package:employeemanager/screens/dashboard.dart';
import 'package:employeemanager/utils/configs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as Firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
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
    manager.profilePicUrl = null;
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

  static Future<bool> addEmployee(BuildContext context,Employee employee, Manager manager) async{

    int length = 0;
   print(employee.managerDocumentId);
   employee.managerDocumentId = manager.documentId;
    await FirebaseFirestore.instance
        .collection('employees').where('email',isEqualTo: employee.email)
        .get().then((QuerySnapshot querySnampshot){
          length = querySnampshot.docs.length;
    });

    if(length > 0){
      print('length issue');
      return false;
    }
    List<String> keys = [];
    String tmp = "";
    for(int i = 0;i<employee.name.length;i++){
      tmp += employee.name[i];
      keys.add(tmp);
    }
    employee.searchKeys = keys;
    employee.dateJoined = DateTime.now().toString();
    await FirebaseFirestore.instance
    .collection('employees')
    .add(employee.toMap());

    Navigator.of(context).pop();

    return true;

  }
  
  static Future<List<String>> fetchRecipents(Manager manager)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    
    String jsonId = preferences.getString('jsonId');
    List<String > recipents = [];
    await FirebaseFirestore.instance.collection('employees').where('managerDocumentId', isEqualTo: manager.documentId)
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
    prefs.setString('type', MANAGER_CODE);

  }

  static Future<List<Employee>> getEmployeeList(Manager manager) async{

    List<Employee> list = [];
    await FirebaseFirestore.instance.collection('employees')
        .where('managerDocumentId', isEqualTo: manager.documentId)
        .get()
    .then((QuerySnapshot querySnapshot){
      querySnapshot.size;
      querySnapshot.docs.forEach((element) {
        //print(element.toString());
        Employee employee = Employee.fromMapObject(element.data());
        employee.document_id = element.id;
        list.add(employee);

      });
    });

    return list;
  }

  static Future<bool> addPayment(Manager manager,Employee employee,Payments payments)async{

    print('email' + employee.email);
    payments.recipent = employee.email;
    payments.recipentName = employee.name;
    //payments.issuer = manager.email;

    String id;

    await FirebaseFirestore.instance.collection(EMPLOYEES_COLLECTION)
    .where('email',isEqualTo: employee.email)
    .get()
    .then((QuerySnapshot docs){
      id = docs.docs[0].id;
    });


    try{
      await FirebaseFirestore.instance
          .collection(EMPLOYEES_COLLECTION)
          .doc(id)
          .collection('payments')
          .add(payments.toMap());
      }
      catch(e){
      print(e.toString());
      }
     return true;
    }


  static getDetailForEmployee(Employee employee) async{
    
  }

  static Future<bool> addAttendenceList(Employee employee,Manager manager,Attendence attendence) async {

    print(employee.email);
    int len = 0;
    String id;
    await FirebaseFirestore.instance
    .collection(EMPLOYEES_COLLECTION)
    .where('email', isEqualTo: employee.email)
    .get()
    .then((QuerySnapshot docs){
      id = docs.docs[0].id;
      len = docs.docs.length;

    });
    print('id  => '+ id);

    if(len > 1){
      print('length issue');
      return false;
    }

    await FirebaseFirestore.instance
    .collection(EMPLOYEES_COLLECTION)
    .doc(id)
    .collection(ATTENDENCE_COLLECTION)
    .add(attendence.toMap());

    return true;


  }

  static Future<double> calculateDues(Employee employee) async{

    double workAmount = await getWorkAmt(employee,);
    double paidAmount = await getPaidAmt(employee);
    return (workAmount - paidAmount).toDouble();

  }

  static Future<double> getAllPays(Employee employee , Manager manager)async{
    FirebaseFirestore.instance.collection(MANAGER_COLLECTION)
        .doc(manager.documentId)
        .collection('payments');
  }

  static Future<double> getWorkAmt(Employee employee,) async {

    String id = await FirebaseFirestore.instance
        .collection(EMPLOYEES_COLLECTION)
        .where('email',isEqualTo: employee.email)
        .get()
        .then((value) => value.docs[0].id);


    double amount = 0;
    double fulltime = 0;
    double over = 0;

    await FirebaseFirestore.instance
    .collection(EMPLOYEES_COLLECTION)
    .doc(id)
    .collection(ATTENDENCE_COLLECTION)
    .get()
    .then((QuerySnapshot querySnapshot){
      querySnapshot.docs.forEach((element) {
        Attendence attendence = Attendence.fromMapObject(element.data());
        if(attendence.fullDay)fulltime++;

        over+=attendence.overtime;

      });
    });
    print('employee ' + employee.name);
    print('full days'  + fulltime.toString() + 'overtimr' + over.toString());

    amount = fulltime*(employee.wages) + (over/8.0)*employee.wages;
    print('amount = ' + amount.toString());
    return amount.toDouble();

  }

  static getPaidAmt(Employee employee,) async{

    double amount = 0;

    String id = await FirebaseFirestore.instance
        .collection(EMPLOYEES_COLLECTION)
        .where('email',isEqualTo: employee.email)
        .get()
        .then((value) => value.docs[0].id);


    await FirebaseFirestore.instance.collection(EMPLOYEES_COLLECTION)
        .doc(id).collection('payments')
        .get()
        .then((QuerySnapshot querySnapshot){
          querySnapshot.docs.forEach((element) {
            print('Actual error ' + element.data()['amount'].runtimeType.toString());
            Payments payments = Payments.fromMapObject(element.data());

            amount += payments.amount;

            print('payment amount ' + payments.amount.toString());

          });
    });
    return amount.toDouble();

  }

  static Future<List<Payments>> getPayments( Manager manager)async{

    List<Payments> list = [];
    String id;
    List<String> tmp = [];
    var ref = await FirebaseFirestore.instance.collection(EMPLOYEES_COLLECTION);
    await ref
    .where('managerDocumentId', isEqualTo: manager.documentId)
    .get()
    .then((QuerySnapshot snapshot) async{
      print('snapshot length - ' + snapshot.docs.length.toString());
      snapshot.docs.forEach((element) async {
        print('id  - ' + element.id);
        tmp.add(element.id);
      });
    });

    list = await getListofPayments(tmp);
    print('tmp = ' + tmp.length.toString());
    print('length = ' + list.length.toString());
    return list;
  }

  static getListofPayments(List<String> tmp) async{

    List<Payments> list = [];

    for(String id in tmp){
      await FirebaseFirestore.instance
          .collection(EMPLOYEES_COLLECTION)
          .doc(id)
          .collection('payments')
          .get()
          .then((value){
            value.docs.forEach((element) {
              Payments payments = Payments.fromMapObject(element.data());
              list.add(payments);
            });

      });

    }
    return list;
  }

  static Future<int> getAttentenceforLastDays(Employee employee)async{
    String id = await FirebaseFirestore.instance
        .collection(EMPLOYEES_COLLECTION)
        .where('email',isEqualTo: employee.email)
        .get()
        .then((value) => value.docs[0].id);
    
    String date = DateTime.now().subtract(Duration(days: 15)).toString();
    int len = 0;
    await FirebaseFirestore.instance
    .collection(EMPLOYEES_COLLECTION)
    .doc(id)
    .collection(ATTENDENCE_COLLECTION)
    .where('date',isGreaterThan: date)
    .get()
    .then((QuerySnapshot snapshot){
      len = snapshot.docs.length;
    });
    return len;
  }

  static Future<int> getNoOfEmployees(Manager manager) async {
    int len = await FirebaseFirestore.instance
        .collection(EMPLOYEES_COLLECTION)
        .where('managerDocumentId', isEqualTo: manager.documentId)
        .get()
        .then((value) => value.docs.length);

    return len;
  }

  static Future<double> getTotalHrsLastWeek(Manager manager) async {
    
    List<String> tmp = [];
    
    await FirebaseFirestore.instance
    .collection(EMPLOYEES_COLLECTION)
    .where('managerDocumentId', isEqualTo:  manager.documentId)
    .get()
    .then((QuerySnapshot snapshot){
      snapshot.docs.forEach((element) {
        tmp.add(element.id);
      });
    });

    double hrs = await calculteHrsInLastWeek(tmp);

    return hrs;
  }

  static Future<double> calculteHrsInLastWeek(List<String> tmp) async{

    double hrs = 0.0;

    for(String id in tmp){
      await FirebaseFirestore.instance
          .collection(EMPLOYEES_COLLECTION)
          .doc(id)
          .collection(ATTENDENCE_COLLECTION)
          .get()
          .then((QuerySnapshot snapshot){
            snapshot.docs.forEach((element) {
              Attendence attendence = Attendence.fromMapObject(element.data());
              if(attendence.fullDay){
                hrs += 8.5;
              }
              hrs += attendence.overtime;
            });
      });
    }
    return hrs;

  }

  static Future<double> getPaymentsOfLastdays(int days,Manager manager) async {

    double paid = 0.0;

    DateTime date = DateTime.now().subtract(Duration(days: days));

    List<Payments> list = await getPayments(manager);

    for(Payments pay in list){
      if(DateTime.parse(pay.date).isAfter(date)){
        paid += pay.amount;
      }
    }
    return paid;
  }


  static uploadManagerProfiePic(File _image,Manager manager) async{
    try {
      await Firebase_storage.FirebaseStorage.instance
          .ref('Managers/${manager.email}')
          .putFile(_image);
    } on FirebaseException catch (e) {
      print('Execption = ' + e.message);
      // TODO
    }

    //Firebase_storage.UploadTask uploadTask = storage.putFile(_image);


  }

  static uploadFile(_image) async{







  }



}