import 'package:employeemanager/models/manager.dart';
import 'package:employeemanager/screens/dashboard.dart';
import 'package:employeemanager/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:employeemanager/utils/firestoreCrud.dart';


class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  var formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Manager manager = Manager.blank();


  Widget _buildSignupBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 35.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: _isLoading?null:handleSignUp,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: _isLoading?CircularProgressIndicator():
        Text(
          'REGISTER',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF73AEF5),
                  Color(0xFF61A4F1),
                  Color(0xFF478DE0),
                  Color(0xFF398AE5),
                ],
                stops: [0.1, 0.4, 0.7, 0.9],
              )
            ),
          ),
          Container(

            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Form(
                key: formKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'MANAGER\nSign Up',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w200,
                              color: Colors.white
                          ),
                        ),
                        SizedBox(height: 30,),
                        TextFormField(
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,

                          ),
                          validator: (String value){
                            if(value==null || value.length == 0){
                              return 'invalid email';
                            }
                            return null;
                          },
                          onSaved: (value){
                            manager.name = value;
                          },
                          decoration: InputDecoration(
                              hintText: 'Name',

                              hintStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey
                              ),
                              filled: true,

                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 2,
                                      style: BorderStyle.solid
                                  ),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              prefixIcon: Icon(Icons.person_outline)
                          ),
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold

                          ),
                          validator: (String value){
                            if(!value.contains('@')){
                              return 'invalid email';
                            }
                            return null;
                          },
                          onSaved: (value){
                            manager.email = value;
                          },
                          decoration: InputDecoration(
                              hintText: 'Email',

                              hintStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey
                              ),
                              filled: true,

                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 2,
                                      style: BorderStyle.solid
                                  ),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              prefixIcon: Icon(Icons.email)
                          ),
                        ),
                        SizedBox(height: 20,),
                        //_buildEmailTF(),

                        TextFormField(
                          obscureText: true,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,

                          ),
                          validator: (String value){
                            if(value.length < 6){
                              return 'length should be greater than 6';
                            }
                            return null;
                          },
                          onSaved: (value){
                            manager.pass = value;
                          },

                          decoration: InputDecoration(

                              hintText: 'Password',

                              hintStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey
                              ),
                              filled: true,

                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 2,
                                      style: BorderStyle.solid
                                  ),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              prefixIcon: Icon(Icons.lock)
                          ),
                        ),
                        SizedBox(height: 10,),

                        _buildSignupBtn(),
                        Text(
                          '- OR -',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 30),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>LoginScreen()));
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(

                                  fontWeight: FontWeight.bold,
                                  fontSize: 23,
                                  color: Colors.white70
                              ),
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  handleSignUp(){

    if(formKey.currentState.validate() && _isLoading == false){
      setState(() {
        _isLoading = true;
      });
      formKey.currentState.save();

      FirestoreCRUD.SignUp(context,manager).then((value){
        if(value){
          print('successfully created');
          _isLoading = false;

        }
        else{
          print('User already Exist');
          setState(() {
            _isLoading = false;
          });
        }
      });

    }
    else if(_isLoading)print('Waiting');


  }

}
