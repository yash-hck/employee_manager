import 'package:employeemanager/models/attendence.dart';
import 'package:employeemanager/models/employees.dart';
import 'package:employeemanager/models/manager.dart';
import 'package:employeemanager/screens/chooseEmployeeScreen.dart';
import 'package:employeemanager/utils/firestoreCrud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
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
  Attendence attendence = Attendence.blank();
  var formKey = GlobalKey<FormState>();
  bool isLoading = false;
  DateTime selectedDate;
  TextEditingController recipentsController = TextEditingController();
  TextEditingController overtimeController = TextEditingController();
  TextEditingController dateController = TextEditingController();


  @override
  void initState() {
    super.initState();
    setDefaultDate();

  }

  _AddAttendenceState({this.manager});
  bool fullTime = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADD ATTENDENCE'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 15,right: 15,top: 15,),
          child: Form(
            key: formKey,
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
                TextFormField(

                  readOnly: true,
                  onTap: ()async{
                    result = await Navigator.push(context,MaterialPageRoute(builder: (context) => ChooseEmployee(manager: manager,)));
                    setState(() {
                      recipentsController.text = result.name;
                    });
                  },
                  validator: (val){
                    if(val ==  null || val == "")return 'value can not be Null';
                    return null;
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

                SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: FilterChip(

                          selectedColor: Colors.greenAccent,
                          checkmarkColor: Colors.black,
                        label: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Full Time',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300
                            ),
                          ),
                        ),
                        labelStyle: TextStyle(
                          letterSpacing: 2,
                            fontSize: 20,
                            fontWeight: FontWeight.w300,

                            color: fullTime ? Colors.black : Colors.lightBlue),
                        selected: fullTime,
                        onSelected: (bool selected) {
                          setState(() {
                            fullTime = !fullTime;
                          },);

                        }

                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        onSaved: (val){
                          attendence.overtime = double.parse(val);
                        },
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold
                        ),
                        keyboardType: TextInputType.number,
                        controller: overtimeController,
                        decoration: InputDecoration(
                            hintText: 'Overtime Hours...',
                            prefixIcon: Icon(FontAwesomeIcons.clock),
                            hintStyle: TextStyle(
                                fontSize: 20
                            ),

                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 2,
                                  style: BorderStyle.solid
                              ),
                            )
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                TextFormField(

                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500
                  ),
                  onTap: (){
                    _selectDate(context);
                  },
                  onSaved: (val){
                    attendence.date = val.toString();
                  },
                  controller: dateController,
                  readOnly: true,
                  decoration: InputDecoration(
                      hintText: 'Date',
                      prefixIcon: Icon(Icons.date_range),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey,
                            width: 3,
                            style: BorderStyle.solid
                        ),
                      )
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 30),
                  width: double.infinity,
                  child: MaterialButton(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),

                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25)),
                    onPressed: isLoading?null:() {

                      addAttendence(result);
                    },
                    child:isLoading?CircularProgressIndicator():
                    Text(
                      "SAVE",

                      style: TextStyle(
                        fontSize: 24,
                        letterSpacing: 2,
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.lightBlue,
                  ),
                ),



              ],
            ),
          ),
        ),
      ),

    );
  }

  void _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      selectableDayPredicate: _decideWhichDayToEnable,
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat.yMMMd().format(selectedDate);
      });
  }

  bool _decideWhichDayToEnable(DateTime day) {
    if(day.isAfter(DateTime.now()))return false;
    return true;
  }

  void addAttendence(Employee result) {

    setState(() {
      isLoading = true;
    });


    if(formKey.currentState.validate()){

        formKey.currentState.save();
        attendence.fullDay = fullTime;
        attendence.date = selectedDate.toString();

        FirestoreCRUD.addAttendenceList(result,attendence).then((bool val){
          if(val == true){
            print('Success');
            sendEmail(result);
            setState(() {
              dateController.text = 'Today';
              recipentsController.clear();
              isLoading = false;


            });
          }
          else{
            print('failed');
            setState(() {
              setDefaultDate();
              formKey.currentState.dispose();
              isLoading = false;
            });
          }
        });


    }


  }

  void setDefaultDate() {
    selectedDate = DateTime.now();
    overtimeController.text = '0';
    dateController.text = 'Today';
  }

  Future<void> sendEmail(Employee result) async {

    final MailOptions mailOptions = MailOptions(
      body: '<h1>New Annpuncement<h1><br> Today Work Recorded full time ${attendence.fullDay} and overtime ${attendence.overtime} <br>',
      subject: 'the Email Subject',

      recipients: [result.email],
      isHTML: true,
    );
    String platformResponse;
    final MailerResponse response = await FlutterMailer.send(mailOptions);
    switch (response) {
      case MailerResponse.saved: /// ios only
        platformResponse = 'mail was saved to draft';
        break;
      case MailerResponse.sent: /// ios only
        platformResponse = 'mail was sent';
        break;
      case MailerResponse.cancelled: /// ios only
        platformResponse = 'mail was cancelled';
        break;
      case MailerResponse.android:
        platformResponse = 'intent was successful';
        break;
      default:
        platformResponse = 'unknown';
        break;
    }
    setState(() {
      isLoading = false;
    });
    print(platformResponse);

  }

}
