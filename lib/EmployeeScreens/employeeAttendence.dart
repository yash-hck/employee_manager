import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employeemanager/models/attendence.dart';
import 'package:employeemanager/models/employees.dart';
import 'package:employeemanager/models/payments.dart';
import 'package:employeemanager/utils/configs.dart';
import 'package:employeemanager/utils/employeeCRUD.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';


class EmployeeAttendence extends StatefulWidget {

  final Employee employee;


  EmployeeAttendence({this.employee});

  @override
  _EmployeeAttendenceState createState() => _EmployeeAttendenceState(employee: employee);
}

class _EmployeeAttendenceState extends State<EmployeeAttendence> {

  final Employee employee;


  _EmployeeAttendenceState({this.employee});

  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  DateTime selectedDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  void initState() {
    super.initState();
    _events = {};
    _controller = CalendarController();
    _selectedEvents = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendences'),
        backgroundColor: Colors.lightBlue[300],
      ),
      body: SingleChildScrollView(

        child:  Column(

          children: [
            TableCalendar(calendarController: _controller,
              //events: _events,
              initialCalendarFormat: CalendarFormat.week,
              calendarStyle: CalendarStyle(
                canEventMarkersOverflow: true,
                todayColor: Colors.orange[100],
                selectedColor: Colors.lightBlue,
                  todayStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.white),

              ),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,

                formatButtonDecoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                formatButtonTextStyle: TextStyle(color: Colors.white),
                formatButtonShowsNext: false,
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
          builders: CalendarBuilders(
              selectedDayBuilder: (context, date, events) => Container(
                margin: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Text(
                  date.day.toString(),
                  style: TextStyle(color: Colors.white),
                )),
              todayDayBuilder: (context, date, events) => Container(
                margin: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Text(
                  date.day.toString(),
                  style: TextStyle(color: Colors.white),
                )),
            ),
              onDaySelected: (DateTime date, List<dynamic> events, List<dynamic> holiday){

                setState(() {
                  selectedDate = date;
                  print(DateFormat(MY_DATE_FORMAT).format(selectedDate).toString());
                });
              },
            ),
           Container(),

            Container(
              child: FutureBuilder(

                future: EmployeeCRUD.getDaysAttendence(DateFormat(MY_DATE_FORMAT).format(selectedDate).toString(), employee),
                builder: (context, AsyncSnapshot<Attendence> snap){
                  if(snap.connectionState == ConnectionState.waiting)return CircularProgressIndicator();

                    if(snap.hasData) {
                      return Card(
                        child: SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.13,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.9,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('Worked on Day - ',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w200,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(snap.data.fullDay?'Done Duty':'No Duty',style:
                                    TextStyle(
                                      color: snap.data.fullDay?Colors.greenAccent:Colors.redAccent,
                                        fontSize: 20
                                    )
                                    )
                                  ],
                                ),


                                Text('Overtime ${snap.data.overtime.round()
                                    .toString()}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                    child: Text('ABSENT',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.redAccent,

                      ),
                    ),
                  );
                },
              ),
            ),
            Divider(
              thickness: 1.5,
            ),

            FutureBuilder(
              future: EmployeeCRUD.getPaymentOnDay(DateFormat(MY_DATE_FORMAT).format(selectedDate), employee),
              builder: (context,AsyncSnapshot<List<Payments>> snapshot){
                if(snapshot.data.length == 0){
                  return Text('No Payments on Day',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.grey
                  ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index){
                    return Card(

                      child: Padding(
                        padding: const EdgeInsets.only(left: 35,top: 20, bottom: 10, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.rupeeSign,
                                  color: Colors.greenAccent,
                                ),
                                Text(snapshot.data[index].amount.round().toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(snapshot.data[index].method),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            )

            /*FutureBuilder(
              future: EmployeeCRUD.getPaymentOnDay(DateFormat(MY_DATE_FORMAT).format(selectedDate), employee),
              builder: (context, AsyncSnapshot<List<Payments>> list){

                if(list.data.length>0) {
                  return ListView.builder(
                    itemCount: list.data.length,
                    itemBuilder: (context, index) {
                      return Card(

                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(list.data[index].amount.toString()),
                              Spacer(),
                              Text(list.data[index].date)
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                else
                return SizedBox(height: 10,);
            },
            )*/

          ]
        ),

      ),
    );
  }
}
