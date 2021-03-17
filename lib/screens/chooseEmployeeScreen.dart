import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employeemanager/models/employees.dart';
import 'package:employeemanager/models/manager.dart';
import 'package:employeemanager/utils/configs.dart';

import 'makeAnnouncement.dart';
import 'package:flutter/material.dart';

class ChooseEmployee extends StatefulWidget {

  final Manager manager;

  ChooseEmployee({this.manager});

  @override
  _ChooseEmployeeState createState() => _ChooseEmployeeState(manager: manager);
}

class _ChooseEmployeeState extends State<ChooseEmployee> {

  final Manager manager;
  String query;

  _ChooseEmployeeState({this.manager});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Card(
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search.....'
              ),
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
            ),
          ),
        ),
        body:  StreamBuilder<QuerySnapshot>(
          stream: (query != null && query != "") ?
          FirebaseFirestore.instance
              .collection(EMPLOYEES_COLLECTION)
              .where('managerDocumentId', isEqualTo: manager.documentId)
              .where("searchKeys", arrayContains: query)
              .snapshots() :
          FirebaseFirestore.instance.collection(EMPLOYEES_COLLECTION).where('managerDocumentId', isEqualTo: manager.documentId).snapshots(),
          builder: (context, snapshot) {
            return (snapshot.connectionState == ConnectionState.waiting)?
            Center(child: CircularProgressIndicator(),) :
            ListView.builder(

              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {

                DocumentSnapshot data = snapshot.data.docs[index];
                print('data = ' + data.toString());
                print(snapshot.data.toString());
                print('data type' + data.runtimeType.toString());
                return GestureDetector(
                  onTap: (){
                    Navigator.pop(context,Employee.fromQurrySnapshot(data));


                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 15, bottom: 15),
                      child: Column(

                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                              ),
                              SizedBox(width: 20,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['name'],
                                    style: TextStyle(
                                        fontSize: 20
                                    ),
                                  ),
                                  Text(data['email'])
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),

                  ),
                );
              },
            );
          },

        )
    );
  }

}
