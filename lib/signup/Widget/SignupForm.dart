import 'package:flutter/material.dart';
import 'package:pexel/Widget/Container.dart';
import 'package:pexel/stateprovider/stateProvider.dart';
import 'package:provider/provider.dart';

class SignupForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OurSignupForm();
}
class _OurSignupForm extends State<SignupForm>{
  TextEditingController _fullNameControll=TextEditingController();
  TextEditingController _emailControll=TextEditingController();
  TextEditingController _passwordControll=TextEditingController();
  TextEditingController _conformpasswordControll=TextEditingController();

  Future _signUpUser(String email, String password, BuildContext context,String fullName) async {
    CurrentState _currentUser=Provider.of<CurrentState>(context,listen: false);
    try{
      String returnString=await _currentUser.signUpUser(email, password,fullName);
      if(returnString=="success") {
        Navigator.pop(context);
      }else{
        Scaffold.of(context).showSnackBar(
            SnackBar(content:Text(returnString)
              ,duration:  Duration(seconds: 2),
            ));

      }
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OurContainer(
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 8.0,
          ),
            child: Text('SignUp',style: TextStyle(color: Theme.of(context).secondaryHeaderColor,fontSize: 25.0,fontWeight: FontWeight.bold
            ),
            ),

          ),
          TextFormField(controller: _fullNameControll,
            decoration: InputDecoration(prefix: Icon(Icons.person),hintText: 'Full Name' ),),
          SizedBox(height: 20.0,),
          TextFormField(controller: _emailControll,
            decoration: InputDecoration(prefix: Icon(Icons.alternate_email),hintText: 'Email' ),
            keyboardType: TextInputType.emailAddress,

          ),
          SizedBox(height: 20.0,),
          TextFormField(controller: _passwordControll,

            decoration: InputDecoration(prefix: Icon(Icons.lock_outline),hintText: 'Password' ),obscureText: true,),

          SizedBox(height: 20.0,),
          TextFormField(controller: _conformpasswordControll,
            decoration: InputDecoration(prefix: Icon(Icons.lock_open),hintText: 'Conform Password' ),obscureText: true,),
          SizedBox(height: 20.0,),

          RaisedButton(child: Padding(padding: EdgeInsets.symmetric(horizontal: 60,),
            child: Text('SignUp',style: TextStyle(color: Colors.white ,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
            ),
          ),
            onPressed: (){
              if(isPasswordCompliant(_passwordControll.text)){
                if(_passwordControll.text.length>=8) {
                  if (_passwordControll.text == _conformpasswordControll.text) {
                    _signUpUser(
                        _emailControll.text, _passwordControll.text, context,
                        _fullNameControll.text);
                  } else {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("password do not mach")
                          , duration: Duration(seconds: 2),
                        ));
                  }
                }else{
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text("Password should be 8 character")
                        , duration: Duration(seconds: 2),
                      ));
                }

              }else{
                Scaffold.of(context).showSnackBar(
                    SnackBar(content:Text("password must contain at least one lower case,one upper case,one digit and one Special character")
                      ,duration:  Duration(seconds: 2),
                    ));
              }
            },
          ),



        ],
      ),

    );
  }
  bool isPasswordCompliant(String password, [int minLength = 6]) {
    if (password == null || password.isEmpty) {
      return false;
    }

    bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
    bool hasSpecialCharacters = password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = password.length > minLength;

    return hasDigits & hasUppercase & hasLowercase & hasSpecialCharacters & hasMinLength;
  }

}