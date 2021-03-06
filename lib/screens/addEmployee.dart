import 'package:employeemanager/models/employees.dart';
import 'package:employeemanager/utils/firestoreCrud.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddEmployee extends StatefulWidget {
  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {

  final formKey = GlobalKey<FormState>();
  String jsonId;
  Employee employee = Employee.blank();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee',style:
          TextStyle(
            color: Colors.blueAccent,

          ),),
        shadowColor: Colors.black,

        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 20,left: 25,right: 25),
            child: SingleChildScrollView(
              child: Column(

                children: [
                  TextFormField(
                    style: TextStyle(
                      fontSize: 25

                    ),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2,
                          style: BorderStyle.solid
                        )
                      ),
                      prefixIcon: Icon(Icons.person),
                      hintStyle: TextStyle(

                        fontSize: 20
                      )
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty)
                        return 'Name Can not be Empty';
                      return null;
                    },
                    onSaved: (value){
                      employee.name = value;
                    },
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    style: TextStyle(
                        fontSize: 20

                    ),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 2,
                                style: BorderStyle.solid
                            )
                        ),
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        hintStyle: TextStyle(

                            fontSize: 20
                        )
                    ),

                    onSaved: (value){
                      employee.email = value;
                    },

                    validator: (value){
                      if(value == null || value.isEmpty)
                        return 'Email can not be empty';
                      if(!value.contains('@'))
                        return 'Invalid Email Address';
                      return null;
                    },
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.grey[300],
                                width: 2,
                                style: BorderStyle.solid
                            )
                        ),
                        hintText: 'Phone Number',
                        prefixIcon: Icon(Icons.phone),
                        hintStyle: TextStyle(

                            fontSize: 20
                        )
                    ),

                    onSaved: (value){
                      employee.mob = value;
                    },

                    validator: (value){
                      if(value.length != 10)
                        return 'Phone Number Length must be 10 digits';
                      return null;
                    },
                  ),
                  _buildAddBtn()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildAddBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 35.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: handleAdd,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child:
        Text(
          'ADD',
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

  handleAdd() async{
    print('pressed');

    await initialiseId();
    
    if(formKey.currentState.validate()){
      employee.managerDocumentId = jsonId;

      formKey.currentState.save();
      print(employee.managerDocumentId);
      FirestoreCRUD.addEmployee(context, employee).then((value){
        if(value){
          print('Successfully Registered Employee');
        }
        else{
          print('Some Error Occured');
        }
      });

    }
  }

  initialiseId() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();

    jsonId = preferences.getString('jsonId');
  }


}
