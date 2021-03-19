import 'package:employeemanager/models/employees.dart';
import 'package:employeemanager/utils/firestoreCrud.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class EmployeeProile extends StatelessWidget {


  final Employee employee;
  EmployeeProile({this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(employee.name),


      ),
      body: Container(
        padding: EdgeInsets.only(left: 20,right: 15,top: 35, bottom: 20),
        child: Column(
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
                    Text(employee.name.toUpperCase(),
                      style: TextStyle(
                          fontSize: 25
                      ),
                    ),
                    Text(employee.email,
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

            Card(

              child : Padding(
                padding: const EdgeInsets.all(22.0),
                child: Row(
                  children: [
                    Text('Due Upto today -',
                      style: TextStyle(
                        fontSize: 20
                      ),
                    ),
                    Spacer(),
                    FutureBuilder(
                        future: FirestoreCRUD.calculateDues(employee),
                        builder: (context, AsyncSnapshot<double> snapshot){
                          if(snapshot.connectionState == ConnectionState.waiting)
                            return CircularProgressIndicator(strokeWidth: 1,);
                          return Text(snapshot.data.round().toString(),
                            style: TextStyle(
                              fontSize: 23
                            ),
                          );
                    },
                      
                    ),
                    SizedBox(width: 10,),
                    Icon(FontAwesomeIcons.rupeeSign,color: Colors.greenAccent,)
                  ],
                ),
              )
            ),
            SizedBox(height: 10,),
            Container(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Recent Attendence',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black45
                        ),
                      ),
                      SizedBox(height: 7,),
                      FutureBuilder(

                        future: FirestoreCRUD.getAttentenceforLastDays(employee),
                        builder: (context, AsyncSnapshot<int> snapshor){
                          if(snapshor.connectionState == ConnectionState.waiting)
                            return CircularProgressIndicator();
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(

                              '  Attended ' + snapshor.data.toString() + ' of last 15 days',
                              style: TextStyle(
                                fontSize: 18
                              ),
                            ),
                          );
                        },
                      ),


                    ],
                  ),
                ),
              ),
            ),

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
                  Text(employee.mob,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black45
                    ),
                  )
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
                child: Text('Joined on ' + DateFormat.yMMMd().format(DateTime.parse(employee.dateJoined))))
          ],
        ),
      ),
    );
  }
}
