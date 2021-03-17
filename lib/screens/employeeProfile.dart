import 'package:employeemanager/models/employees.dart';
import 'package:flutter/material.dart';

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
              child : Row(
                children: [
                  Text('Due today is ')
                ],
              )
            )

          ],
        ),
      ),
    );
  }
}
