import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employeemanager/models/employees.dart';
import 'package:employeemanager/models/payments.dart';
import 'package:employeemanager/utils/configs.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class EmployeePayments extends StatefulWidget {

  final Employee employee;

  EmployeePayments({this.employee});

  @override
  _EmployeePaymentsState createState() => _EmployeePaymentsState(employee: employee);
}

class _EmployeePaymentsState extends State<EmployeePayments> {

  final Employee employee;
  String sorted = 'date';
  String query;
  _EmployeePaymentsState({this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('PAYMENTS'),
        ),

        body:  StreamBuilder<QuerySnapshot>(
          stream: (query != null && query != "") ?
          FirebaseFirestore.instance
              .collection(EMPLOYEES_COLLECTION)
              .doc(employee.document_id)
              .collection('payments')
              .snapshots() :
          FirebaseFirestore.instance.collection(EMPLOYEES_COLLECTION).doc(employee.document_id)
              .collection('payments')
              .snapshots(),
          builder: (context, snapshot) {
            //print('check = ' + snapshot.data.docs.length.toString());
            return (snapshot.connectionState == ConnectionState.waiting)?
            Center(child: CircularProgressIndicator(),) :



            ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.docs.length + 1,
              itemBuilder: (context, index) {

                if(index == 0){
                  return Row(

                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(child: Text('Sort by ' + (sorted == 'date'?'amount':'date')),
                        onTap: (){
                          setState(() {
                            if(sorted == 'date')sorted = 'amount';
                            else sorted = 'date';
                          });
                        },
                      ),
                      Icon(Icons.arrow_downward)
                    ],
                  );
                }
                DocumentSnapshot data = snapshot.data.docs[index-1];
                //Employee emp = Employee.fromQurrySnapshot(snapshot.data.docs[index-1]);
                print('data = ' + data.toString());
                //print(snapshot.data.toString());
                return Card(
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
                                  data['amount'],
                                  style: TextStyle(

                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),

                                Text(data['date'],
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                          ],
                        ),

                      ],
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
