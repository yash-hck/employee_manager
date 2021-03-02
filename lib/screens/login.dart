import 'package:employeemanager/models/manager.dart';
import 'package:employeemanager/screens/dashboard.dart';
import 'package:employeemanager/screens/signup.dart';
import 'package:employeemanager/utils/firestoreCrud.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  Manager manager = Manager.blank();
  var formKey = GlobalKey<FormState>();

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Color(0xFF6CA8F1),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: TextStyle(
                color: Colors.white70,
                fontSize: 10
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Color(0xFF6CA8F1),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          height: 60.0,
          child: TextField(
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        ),
      ],
    );
  }



  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 35.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: isLoading?null:handleLogin,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child:isLoading?CircularProgressIndicator():
        Text(
          'LOGIN',
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
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30,),
                        TextFormField(
                          onSaved: (value){
                            manager.email = value;
                          },
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black45,

                          ),
                          validator: (String value){
                            if(!value.contains('@')){
                              return 'invalid email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Email',

                            hintStyle: TextStyle(
                              fontSize: 22,
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
                          onSaved: (value){
                            manager.pass = value;
                          },
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black45,

                          ),
                          validator: (String value){
                            if(value == null || value.length == 0){
                              return 'invalid Password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(

                              hintText: 'Password',

                              hintStyle: TextStyle(
                                  fontSize: 22,
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
                        SizedBox(height: 5,),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text('Forgot password',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              fontFamily: 'OpenSans'
                            ),
                          ),
                        ),
                        _buildLoginBtn(),
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
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>SignUpScreen()));
                            },
                            child: Text(
                              'Sign-Up',
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
      )
    );
  }

  handleLogin(){

    if(formKey.currentState.validate() && isLoading == false){
      setState(() {
        isLoading = true;
      });
      formKey.currentState.save();

      FirestoreCRUD.handleLogin(context,manager.email,manager.pass).then((value){
        if(value){
          print('successfully Logged In');
          isLoading = false;

        }
        else{
          print('Incorrect Credentials');
          setState(() {
            isLoading = false;
          });
        }
      });

    }
    else if(isLoading)print('Waiting');



  }

}
