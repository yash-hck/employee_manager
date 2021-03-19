import 'package:employeemanager/models/employees.dart';
import 'package:employeemanager/models/manager.dart';
import 'package:employeemanager/utils/firestoreCrud.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {

  final Manager manager;

  ProfileScreen({this.manager});

  @override
  _ProfileScreenState createState() => _ProfileScreenState(manager: manager);
}

class _ProfileScreenState extends State<ProfileScreen> {

  final Manager manager;


  _ProfileScreenState({this.manager});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(manager.name),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 65,
                ),
              ),
              SizedBox(height: 20,),
              Text(manager.name,
                style: TextStyle(
                  fontSize: 30
                ),
              ),
              SizedBox(height: 10,),
              Divider(),
              FutureBuilder(
                future: FirestoreCRUD.getNoOfEmployees(manager),
                builder: (context, AsyncSnapshot<int> snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting)
                    return CircularProgressIndicator();
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                      child: Row(
                        children: [
                          Text('Total Employees ',
                            style: TextStyle(
                              fontSize: 20,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                          Spacer(),
                          Text(snapshot.data.toString(),
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold
                            ),


                          ),
                          SizedBox(width: 15,)
                        ],
                      ),
                    ),
                  );
                },

              ),
              FutureBuilder(
                future: FirestoreCRUD.getTotalHrsLastWeek(manager),
                builder: (context, AsyncSnapshot<double> snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting)
                    return CircularProgressIndicator();
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                      child: Row(
                        children: [
                          Text('Total hrs done in Last Week ',
                            style: TextStyle(
                                fontSize: 20,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                          Spacer(),
                          Text(snapshot.data.toString(),
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold
                            ),


                          ),
                          SizedBox(width: 15,)
                        ],
                      ),
                    ),
                  );
                },

              ),
              FutureBuilder(
                future: FirestoreCRUD.getPaymentsOfLastdays(7, manager),
                builder: (context, AsyncSnapshot<double> snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting)
                    return CircularProgressIndicator();
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                      child: Row(
                        children: [
                          Text('Payments Given in Last Week ',
                            style: TextStyle(
                                fontSize: 20,
                                letterSpacing: 1,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                          Spacer(),
                          Text(snapshot.data.round().toString(),
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold
                            ),


                          ),
                          SizedBox(width: 15,)
                        ],
                      ),
                    ),
                  );
                },

              )
            ],
          ),
        ),
      ),
    );
  }
}
