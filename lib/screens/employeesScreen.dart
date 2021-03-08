


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employeemanager/models/employees.dart';
import 'package:employeemanager/models/manager.dart';
import 'package:employeemanager/utils/configs.dart';
import 'package:employeemanager/utils/firestoreCrud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeesScreen extends StatefulWidget {

  final Manager manager;

  EmployeesScreen({this.manager});

  @override
  _EmployeesScreenState createState() => _EmployeesScreenState(manager: manager);
}

class _EmployeesScreenState extends State<EmployeesScreen> {

  final Manager manager;


  String query;
  List<Employee> list = [];
  SearchBar searchBar;
  bool isLoading = true;

  _EmployeesScreenState({this.manager});

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
          FirebaseFirestore.instance.collection(MANAGER_COLLECTION).doc(
              manager.documentId)
              .collection(EMPLOYEES_COLLECTION).where("searchKeys", arrayContains: query)
              .snapshots() :
          FirebaseFirestore.instance.collection(MANAGER_COLLECTION)
              .doc(manager.documentId).collection(EMPLOYEES_COLLECTION).snapshots(),
          builder: (context, snapshot) {
            return (snapshot.connectionState == ConnectionState.waiting)?
            Center(child: CircularProgressIndicator(),) :
            ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot data = snapshot.data.docs[index];
                print('data = ' + data.toString());
                print(snapshot.data.toString());
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

                );
              },
            );
          },

        )
    );
  }

  @override
  void initState() {
    searchBar = new SearchBar(
      onSubmitted: onSubmitted,
      inBar: true,
      buildDefaultAppBar: _buildAppBar,
      setState: setState,
    );
  }

  void onSubmitted(String value) {
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('query data'),
      centerTitle: true,

      actions: [
        searchBar.getSearchAction(context)
      ],
    );
  }

/*buildItem(BuildContext context, int index,QuerySnapshot snapshot) {

    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 15),
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

                      style: TextStyle(
                        fontSize: 20
                      ),
                    ),
                    Text(list[index].email)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );

  }*/

}