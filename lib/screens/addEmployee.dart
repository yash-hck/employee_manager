import 'package:flutter/material.dart';

class AddEmployee extends StatefulWidget {
  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
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
          child: Padding(
            padding: const EdgeInsets.only(top: 20,left: 25,right: 25),
            child: SingleChildScrollView(
              child: Column(

                children: [
                  TextFormField(

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
                  ),
                  SizedBox(height: 15,),
                  TextFormField(

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
                  ),
                  SizedBox(height: 15,),
                  TextFormField(

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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
