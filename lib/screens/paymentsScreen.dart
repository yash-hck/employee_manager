import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employeemanager/models/manager.dart';
import 'package:employeemanager/utils/configs.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class PaymentsScreen extends StatefulWidget {

  final Manager manager;

  PaymentsScreen({this.manager});

  @override
  _PaymentsScreenState createState() => _PaymentsScreenState(manager: manager);
}

class _PaymentsScreenState extends State<PaymentsScreen> {

  final Manager manager;
  String query;
  String sorted = 'amount';

  _PaymentsScreenState({this.manager});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('PAYMENTS'),
          ),

        body:  StreamBuilder<QuerySnapshot>(
          stream: (query != null && query != "") ?
          FirebaseFirestore.instance.collection(MANAGER_COLLECTION).doc(
              manager.documentId)
              .collection('payments').orderBy(sorted,descending: true)
              .snapshots() :
          FirebaseFirestore.instance.collection(MANAGER_COLLECTION)
              .doc(manager.documentId).collection('payments').orderBy(sorted,descending: true).snapshots(),
          builder: (context, snapshot) {
            return (snapshot.connectionState == ConnectionState.waiting)?
            Center(child: CircularProgressIndicator(),) :

            Column(
              children: [
                Row(

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
                ),
                Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot data = snapshot.data.docs[index];
                      print('data = ' + data.toString());
                      print(snapshot.data.toString());
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 15, bottom: 5),
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
                                      Row(
                                        children: [
                                          Text('Paid to: '),
                                          Text(
                                            data['recipentName'],
                                            style: TextStyle(

                                                fontSize: 20,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ],
                                      ),

                                      Text(data['recipent'],
                                      style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  Text(data['amount'],
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500

                                    ),
                                  ),
                                  Icon(FontAwesomeIcons.rupeeSign,
                                    color: Colors.greenAccent,
                                  )
                                ],
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  DateFormat("dd/MM/yyyy").format(DateTime.parse(data['date'])).toString(),
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w300

                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                      );
                    },
                  ),
                ),
              ],
            );
          },

        )
    );
  }
}

