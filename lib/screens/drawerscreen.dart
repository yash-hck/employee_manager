import 'package:employeemanager/models/manager.dart';
import 'package:employeemanager/screens/attendenceScreen.dart';
import 'package:employeemanager/screens/dashboardScreen.dart';
import 'package:employeemanager/screens/duesScreen.dart';
import 'package:employeemanager/screens/employeesScreen.dart';
import 'package:employeemanager/screens/login.dart';
import 'package:employeemanager/screens/paymentsScreen.dart';
import 'package:employeemanager/screens/profileScreen.dart';
import 'package:employeemanager/screens/settingsScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerScreen extends StatelessWidget {

  final Manager manager;


  DrawerScreen({this.manager});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF73AEF5),
            Color(0xFF61A4F1),
            Color(0xFF478DE0),
            Color(0xFF398AE5),
          ],
          stops: [0.1, 0.4, 0.7, 0.9],
        )
      ),
      padding: EdgeInsets.only(top: 50,left: 35,bottom: 50),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 45,
                backgroundImage: AssetImage('images/abd.jpg'),
              ),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(manager.name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                  Text(manager.email,style: TextStyle(color: Colors.white,))
                ],
              )

            ],
          ),
          Expanded(
            child: ListView(

              children: [


                ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EmployeesScreen(manager: manager,)));
                  },
                  leading: Icon(FontAwesomeIcons.building,color: Colors.white,),
                  title: Text('My Employees',
                    style: TextStyle(
                        color: Colors.white
                    ),),
                ),
                ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentsScreen(manager: manager,)));
                  },
                  leading: Icon(Icons.money,color: Colors.white,),
                  title: Text('Payments',
                    style: TextStyle(
                        color: Colors.white
                    ),),
                ),
                ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DuesScreen(manager: manager,)));
                  },
                  leading: Icon(FontAwesomeIcons.rupeeSign,color: Colors.white,),
                  title: Text('Dues',
                    style: TextStyle(
                        color: Colors.white
                    ),),
                ),
                ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(manager: manager,)));
                  },
                  leading: Icon(Icons.person_outline,color: Colors.white,),
                  title: Text('Profile',
                    style: TextStyle(
                        color: Colors.white
                    ),),
                ),
                ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
                  },
                  leading: Icon(Icons.settings,color: Colors.white,),
                  title: Text('Settings',
                    style: TextStyle(
                        color: Colors.white
                    ),),
                ),
                ListTile(
                  onTap: (){
                    removeData();
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()),(Route<dynamic> route) => false);
                  },
                  leading: Icon(Icons.logout,color: Colors.white,),
                  title: Text('LogOut',
                    style: TextStyle(
                        color: Colors.white
                    ),),
                )
              ],
            ),
          )

        ],
      ),
    );
  }

  void removeData() async{

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();

  }

}
