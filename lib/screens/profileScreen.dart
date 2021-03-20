import 'dart:io';
import 'dart:math';

import 'package:employeemanager/models/employees.dart';
import 'package:employeemanager/models/manager.dart';
import 'package:employeemanager/utils/configs.dart';
import 'package:employeemanager/utils/firestoreCrud.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:koukicons/camera2.dart';
import 'package:koukicons/framePic.dart';

class ProfileScreen extends StatefulWidget {

  final Manager manager;

  ProfileScreen({this.manager});

  @override
  _ProfileScreenState createState() => _ProfileScreenState(manager: manager);
}

class _ProfileScreenState extends State<ProfileScreen> {

  final Manager manager;
  File _image;

  _ProfileScreenState({this.manager});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.edit,
            color: Colors.white ,
          ),)
        ],

        title: Text(manager.name),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: FutureBuilder(
                  future: FirebaseStorage.instance.ref('Managers/${manager.email}').getDownloadURL(),
                  builder: (context, AsyncSnapshot<String> snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting)
                      return CircularProgressIndicator();
                    return CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: snapshot.data == null? AssetImage('images/abd.jpg'):NetworkImage(snapshot.data),
                      radius: 65,
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(

                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: gradient
                            ),
                            child: IconButton(icon: Icon(Icons.camera_alt,
                              color: Colors.white,



                            ),
                                onPressed:() {
                                  showSelelectionSheet(context);
                                  //getImage(true);
                                }

                            ),
                          )),
                    );
                 },
                )

                /**/
              ),
              SizedBox(height: 20,),
              Text(manager.name,
                style: TextStyle(
                  fontSize: 30
                ),
              ),
              SizedBox(height: 10,),
              Divider(),
              FutureBuilder(
                future: FirestoreCRUD.getNoOfEmployees(manager),
                builder: (context, AsyncSnapshot<int> snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting)
                    return CircularProgressIndicator();
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                      child: Row(
                        children: [
                          Text('Total Employees ',
                            style: TextStyle(
                              fontSize: 20,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                          Spacer(),
                          Text(snapshot.data.toString(),
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold
                            ),


                          ),
                          SizedBox(width: 15,)
                        ],
                      ),
                    ),
                  );
                },

              ),
              FutureBuilder(
                future: FirestoreCRUD.getTotalHrsLastWeek(manager),
                builder: (context, AsyncSnapshot<double> snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting)
                    return CircularProgressIndicator();
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                      child: Row(
                        children: [
                          Text('Total hrs done in Last Week ',
                            style: TextStyle(
                                fontSize: 20,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                          Spacer(),
                          Text(snapshot.data.toString(),
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold
                            ),


                          ),
                          SizedBox(width: 15,)
                        ],
                      ),
                    ),
                  );
                },

              ),
              FutureBuilder(
                future: FirestoreCRUD.getPaymentsOfLastdays(7, manager),
                builder: (context, AsyncSnapshot<double> snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting)
                    return CircularProgressIndicator();
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                      child: Row(
                        children: [
                          Text('Payments Given in Last Week ',
                            style: TextStyle(
                                fontSize: 20,
                                letterSpacing: 1,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                          Spacer(),
                          Text(snapshot.data.round().toString(),
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold
                            ),


                          ),
                          SizedBox(width: 15,)
                        ],
                      ),
                    ),
                  );
                },

              )
            ],
          ),
        ),
      ),
    );
  }

  Future getImage(bool gallery)async{
    ImagePicker imagePicker = ImagePicker();
    PickedFile pickedFile;

    if(gallery){
      pickedFile = await imagePicker.getImage(source: ImageSource.gallery);

    }
    else{
      pickedFile = await imagePicker.getImage(source: ImageSource.camera);
    }

    setState(() {
      if(pickedFile != null){
        _image = File(pickedFile.path);
        FirestoreCRUD.uploadManagerProfiePic(_image,manager);
      }
      else {
        print('Error in file');
      }
    });
  }

  void showSelelectionSheet(BuildContext context) {

    showModalBottomSheet(context: context,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
        ),

      builder: (context){
      return AnimatedContainer(duration: Duration(milliseconds: 2000),
          height: 150,
          decoration: BoxDecoration(
            gradient: gradient,

      ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15,top: 30),
          child: Row(


            children: [
              Column(

                children: [
                  Container(

                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white
                    ),
                    child: IconButton(icon: KoukiconsCamera2(),




                        onPressed:() {
                          //showSelelectionSheet(context);
                          Navigator.pop(context);
                          getImage(false);
                        }

                    ),
                  ),
                  SizedBox(height: 10,),
                  Text('CAMERA',
                    style: TextStyle(color: Colors.white,
                        letterSpacing: 1.5),
                  )
                ],
              ),
              SizedBox(width: 35,),
              Column(
                children: [
                  Container(

                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white
                    ),
                    child: IconButton(icon: KoukiconsFramePic(),




                        onPressed:() {
                          //showSelelectionSheet(context);
                          Navigator.pop(context);
                          getImage(true);

                        }

                    ),
                  ),
                  SizedBox(height: 10,),
                  Text('GALLERY',
                    style: TextStyle(color: Colors.white,

                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        );
      }
    );

  }
}
