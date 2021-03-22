import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employeemanager/models/employees.dart';
import 'package:employeemanager/utils/configs.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ProfileEmpolyee extends StatefulWidget {

  final Employee employee;


  ProfileEmpolyee({this.employee});

  @override
  _ProfileEmployeeState createState() => _ProfileEmployeeState(employee: employee);
}

class _ProfileEmployeeState extends State<ProfileEmpolyee> {

  final Employee employee;



  _ProfileEmployeeState({this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(employee.name),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20,right: 15,top: 35, bottom: 20),

        child: FutureBuilder(
          future: FirebaseFirestore.instance.collection(EMPLOYEES_COLLECTION).doc(employee.document_id).get().then((value) => Employee.fromMapObject(value.data())),
           builder: (BuildContext context, AsyncSnapshot<Employee> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting)
            return CircularProgressIndicator();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 50,
                  ),
                  SizedBox(width: 20,),
                  Column(
                    children: [
                      Text(snapshot.data.name,
                        style: TextStyle(
                            fontSize: 25
                        ),
                      ),
                      Text(snapshot.data.email,
                        style: TextStyle(

                        ),
                      )

                    ],
                  ),

                ],
              ),
              SizedBox(height: 15,),

              Divider(
                thickness: 2,
              ),


              SizedBox(height: 10,),


              Divider(),
              Text('CONTACTS',
                textAlign: TextAlign.left,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                child: Row(
                  children: [
                    Icon(Icons.phone),
                    SizedBox(width: 30,),

                  ],
                ),

              ),
              SizedBox(height: 15,),

              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                child: Row(
                  children: [
                    Icon(Icons.email),
                    SizedBox(width: 30,),
                    Text(employee.email,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black45
                      ),
                    )
                  ],
                ),

              ),
              SizedBox(height: 15,),
              Align(
                  alignment: Alignment.centerRight,
                  child: Text('Joined on ' + DateFormat.yMMMd().format(DateTime.parse(snapshot.data.dateJoined))))
            ],
          );
          }


        ),
      )
    );

  }
}
