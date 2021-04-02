import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<BoxShadow> shadowList = [
  BoxShadow(color: Colors.grey[300], blurRadius: 5, offset: Offset(5,5))
];

List<String> dashmenu = ['Add Employees','Add Payment','Add Attendence','Make Annponcement'];
List<String> menuImage = ['images/adds.png','images/rup.png','images/atten.png','images/announ.png'];


List<String> EmpDashMenu = ['Scan & Mark', 'Payments', 'Dues','Attendence', 'Profile'];
List<String> empDashImages = ['images/qrscan.png','images/rup.png', 'images/dues.png', 'images/atten.png', 'images/adds.png'];

const String MANAGER_COLLECTION = 'managers';
const String EMPLOYEES_COLLECTION = 'employees';
const String ATTENDENCE_COLLECTION = 'attendence';
const String MY_DATE_FORMAT = 'dd/MM/yyyy';
const String PAYMENTS_COLLECTION = 'payments';


var gradient =  LinearGradient(
begin: Alignment.topCenter,
end: Alignment.bottomCenter,
colors: [
Color(0xFF73AEF5),
Color(0xFF61A4F1),
Color(0xFF478DE0),
Color(0xFF398AE5),
],
stops: [0.1, 0.4, 0.7, 0.9],
);

const String MANAGER_CODE = 'man';
const String EMPLOYEE_CODE = 'emp';