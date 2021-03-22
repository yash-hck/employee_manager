import 'package:employeemanager/EmployeeScreens/employeeAttendence.dart';
import 'package:employeemanager/EmployeeScreens/employeeDues.dart';
import 'package:employeemanager/EmployeeScreens/employeePayments.dart';
import 'package:employeemanager/EmployeeScreens/profileEmployee.dart';
import 'package:employeemanager/EmployeeScreens/qrScanner.dart';
import 'package:employeemanager/models/employees.dart';
import 'package:employeemanager/models/manager.dart';
import 'package:employeemanager/screens/chooseLoginRegister.dart';
import 'package:employeemanager/utils/configs.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeDashboard extends StatefulWidget {

  final Employee employee;

  EmployeeDashboard({this.employee});

  @override
  _EmployeeDashboardState createState() => _EmployeeDashboardState(employee: employee);
}

class _EmployeeDashboardState extends State<EmployeeDashboard> {

  final Employee employee;


  _EmployeeDashboardState({this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(


          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            children: [
              SizedBox(height: 35,),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                    backgroundImage: employee.profilePicUrl==null? AssetImage('images/abd.jpg') : NetworkImage(employee.profilePicUrl),
                  ),

                    Text('DASHBOARD',
                      style: TextStyle(
                          fontSize: 19
                      ),

                    ),
                    IconButton(icon: Icon(Icons.logout), onPressed: (){removeData();
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ChooseMangerEmployee()),(Route<dynamic> route) => false);
                    }),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(

                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2
                    ),
                    shrinkWrap: true,

                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Tile(
                        imagePath: empDashImages[index],
                        title: EmpDashMenu[index],
                        index: index,
                        employee: employee ,
                      );
                    }
                  /*children: [
                GridTile(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: shadowList,
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey[400],
                        width: 2
                      ),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [


                          Container(

                            decoration: BoxDecoration(
                              color: Colors.white
                            ),
                              padding: EdgeInsets.all(10),
                              child: Image.asset('images/adds.png',height: 105,)
                          ),
                        Text(
                          'Add Employee',

                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black45
                          ),
                        )
                      ],
                    ),
                  ),
                ),

              ],
*/              ),
              )
            ],
          ),
        ));
  }

  void removeData() async{

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();

  }
}

class Tile extends StatelessWidget {

  final Employee employee;

  final String imagePath;
  final int index;
  final String title;
  Employee incoming;
  List<Widget> screens = [];

  Tile({this.imagePath, this.index, this.title,this.employee}){
    incoming = employee;
    screens = [QrScanner(employee: employee,), EmployeePayments(employee: employee,) ,EmployeeDues(employee: employee,),EmployeeAttendence(employee: employee,), ProfileEmpolyee(employee: employee,)];
  }








  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => screens[index]));
        },
        child: Container(
          decoration: BoxDecoration(
              boxShadow: shadowList,

              color: Colors.white,
              border: Border.all(
                  color: Colors.grey[200],
                  width: 2
              ),
              borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            children: [


              Container(

                  decoration: BoxDecoration(
                      color: Colors.white
                  ),
                  padding: EdgeInsets.all(10),
                  child: Image.asset(imagePath,height: 100,)
              ),





              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black45
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



