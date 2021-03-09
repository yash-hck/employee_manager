import 'package:employeemanager/models/manager.dart';
import 'package:employeemanager/screens/chooseEmployeeScreen.dart';
import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

class AddAttendence extends StatefulWidget {

  final Manager manager;

  AddAttendence({this.manager});

  @override
  _AddAttendenceState createState() => _AddAttendenceState(manager:  manager);
}

class _AddAttendenceState extends State<AddAttendence> {

  var result;
  final Manager manager;
  TextEditingController recipentsController = TextEditingController();

  _AddAttendenceState({this.manager});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADD ATTENDENCE'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15,right: 15,top: 15,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('For',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 20,

              ),
            ),
            SizedBox(height: 10,),
            TextField(

              readOnly: true,
              onTap: ()async{
                result = await Navigator.push(context,MaterialPageRoute(builder: (context) => ChooseEmployee(manager: manager,)));
                setState(() {
                  recipentsController.text = result.name;
                });
              },
              style: TextStyle(
                fontSize: 20,

              ),
              controller: recipentsController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Recipent...',

                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2,
                        style: BorderStyle.solid
                    ),
                  )
              ),
            ),

            SizedBox(height: 10,),
            FilterChip(label: Text('Full Time'), onSelected: null)


          ],
        ),
      ),

    );
  }
}
