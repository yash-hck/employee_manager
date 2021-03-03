import 'package:employeemanager/models/manager.dart';
import 'package:employeemanager/screens/addEmployee.dart';
import 'package:employeemanager/screens/dashboardScreen.dart';
import 'package:employeemanager/screens/drawerscreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashBoard extends StatefulWidget {

  final Manager incoming;

  const DashBoard({ this.incoming});

  @override
  _DashBoardState createState() => _DashBoardState(incoming);
}

class _DashBoardState extends State<DashBoard> {

  final Manager incoming;

  _DashBoardState(this.incoming);


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          DrawerScreen(manager: incoming,),
          DashBoardScreen(incoming: incoming,)

        ],
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddEmployee()));
        },
        child: Icon(Icons.add),
      ),*/
    );
  }
}
