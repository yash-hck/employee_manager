import 'package:employeemanager/models/manager.dart';
import 'package:employeemanager/models/payments.dart';
import 'package:employeemanager/screens/chooseEmployeeScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:employeemanager/utils/firestoreCrud.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AddPayments extends StatefulWidget {

  final Manager manager;
  
  AddPayments({this.manager});


  @override
  _AddPaymentsState createState() => _AddPaymentsState(manager: manager);
}

class _AddPaymentsState extends State<AddPayments> {

  bool isLoading = false;
  final Manager manager;
  var result;
  TextEditingController dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TextEditingController recipentsController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  _AddPaymentsState({this.manager});

  Payments payments = Payments.blank();

  int selectedButton = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Add a Payment',
          style: TextStyle(
            color: Colors.blue
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(


          padding: EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ToggleSwitch(

                minWidth: MediaQuery.of(context).size.width*0.8,
                initialLabelIndex: 0,
                cornerRadius: 20.0,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey[200],
                inactiveFgColor: Colors.grey[400],

                labels: ['To Bank Account', 'By Cash'],
                icons: [FontAwesomeIcons.piggyBank, FontAwesomeIcons.rupeeSign],
                activeBgColors: [Colors.lightBlue, Colors.lightBlue],
                onToggle: (index) {
                  selectedButton = index;
                },
              ),
              SizedBox(height: 20,),
              Text('Paid to',
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
              SizedBox(height: 20,),
              Text(
                'Amount',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: amountController,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Amount',
                    prefixIcon: Icon(FontAwesomeIcons.rupeeSign),
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
              SizedBox(height: 35,),
              TextField(
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500
                ),
                onTap: (){
                  _selectDate(context);
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
              onPressed: () {
                addPay(result);
              },
              child: isLoading?CircularProgressIndicator():
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

    );
  }

  @override
  void initState() {
    super.initState();
    dateController.text = 'Today';
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

  void addPay(result) async{


    payments.method = selectedButton == 1?'Bank':'Cash';
    payments.date = DateTime.now().toString();
    payments.amount = amountController.text;

    setState(() {
      isLoading = true;
    });

    FirestoreCRUD.addPayment(manager, result, payments).then((value){
      if(value){
        print('Successfully added Payment');
        isLoading = false;
        Navigator.pop(context);

      }
      else{
        print('Some error occured');
        setState(() {
          isLoading = false;
        });
      }
    });

  }
}
