import 'package:employeemanager/models/manager.dart';
import 'package:employeemanager/screens/addAttendenceScreen.dart';
import 'package:employeemanager/screens/addEmployee.dart';
import 'package:employeemanager/screens/addPaymentScreen.dart';
import 'package:employeemanager/screens/makeAnnouncement.dart';
import 'package:employeemanager/utils/configs.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashBoardScreen extends StatefulWidget {

  final Manager incoming;


  DashBoardScreen({this.incoming});

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState(incoming: incoming);
}

class _DashBoardScreenState extends State<DashBoardScreen> {

  final Manager incoming;
  double xOffset = 0;
  double yOffset  = 0;
  double zOffset = 0;
  double scaleFactor = 1;

  bool drawerFlag = false;

  _DashBoardScreenState({this.incoming});


  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, zOffset)..scale(scaleFactor),
      duration: Duration(milliseconds: 250),

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
                IconButton(
                    icon:drawerFlag?Icon(Icons.chevron_left):  Icon(Icons.menu),
                    onPressed: (){

                      setState(() {
                        xOffset = drawerFlag?0:230;
                        zOffset = drawerFlag?0:50;
                        yOffset = drawerFlag?0:150;
                        scaleFactor = drawerFlag?1:0.7;
                        drawerFlag = !drawerFlag;
                      });
                    }
                ),
                Text('DASHBOARD',
                  style: TextStyle(
                    fontSize: 19
                  ),

                ),
                CircleAvatar(
                  backgroundImage: AssetImage('images/abd.jpg'),
                ),



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

              itemCount: 4,
              itemBuilder: (BuildContext context,int index){

                  return Tile(
                    imagePath: menuImage[index],
                    title: dashmenu[index],
                    index: index,
                    manager: incoming,
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
*/            ),
          )
        ],
      ),
    );
  }
}

class Tile extends StatelessWidget {

  final Manager manager;

  final String imagePath;
  final int index;
  final String title;
  Manager incoming;
  List<Widget> screens = [];

  Tile({this.imagePath, this.index, this.title,this.manager}){
    incoming = manager;
    screens = [AddEmployee(),AddPayments(manager: incoming),AddAttendence(manager: manager,),AnnouncementScreen()];
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

