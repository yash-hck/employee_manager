import 'package:employeemanager/EmployeeScreens/employeeLogin.dart';
import 'package:employeemanager/screens/login.dart';
import 'package:employeemanager/utils/configs.dart';
import 'package:flutter/material.dart';

class ChooseMangerEmployee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        decoration: BoxDecoration(
          gradient: gradient
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,top:300 ),
          child: Column(

            children: [
              Text('Choose One',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w200,
                  color: Colors.white
                ),
              ),
              SizedBox(height: 10,),
              _buildManagerBtn(context),
              _buildEmployeeBtn(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildManagerBtn(context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 35.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
        },

        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child:
        Text(
          'MANAGER',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildEmployeeBtn(context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 35.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => EmployeeLogin()));
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child:
        Text(
          'EMPLOYEE',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
}
