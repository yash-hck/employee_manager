import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      padding: EdgeInsets.only(top: 50,left: 35),

      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 45,
                backgroundImage: AssetImage('images/abd.jpg'),
              ),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Yash Verma',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                  Text('Active Status',style: TextStyle(color: Colors.white,))
                ],
              )

            ],
          ),
          Column(
            
          )
        ],
      ),
    );
  }
}
