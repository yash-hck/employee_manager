import 'package:employeemanager/models/manager.dart';
import 'package:flutter/material.dart';

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
      color: Colors.white,
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
                        scaleFactor = drawerFlag?1:0.6;
                        drawerFlag = !drawerFlag;
                      });
                    }
                ),
                Text('DASHBOARD',
                  style: TextStyle(
                    fontSize: 19
                  ),

                ),
                CircleAvatar()

              ],
            ),
          )
        ],
      ),
    );
  }
}
