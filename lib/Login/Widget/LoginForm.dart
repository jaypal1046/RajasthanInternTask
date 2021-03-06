import 'package:flutter/material.dart';
import 'package:pexel/Widget/Container.dart';
import 'package:pexel/root/root.dart';
import 'package:pexel/signup/signup.dart';
import 'package:pexel/stateprovider/stateProvider.dart';
import 'package:provider/provider.dart';

enum LoginType{
  email,
  google,
}
class OurloginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OurlofinForm();
}
class _OurlofinForm extends State<OurloginForm>{
  TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  void _loginUser({
    @required LoginType type,
    String email,String password,
    BuildContext context
  }) async{
    CurrentState currentUser=Provider.of<CurrentState>(context,listen:false );
    try{
      String _returnString;
      switch(type){
        case LoginType.email:
          _returnString =await currentUser.logInUserwithEmail(email, password);
          break;
        case LoginType.google:
          _returnString=await currentUser.logInUserWithGoogle();
          break;
        default:
      }


      if(_returnString=="success"){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context)=>OurRoot()), (route) => false);
      } else{
        Scaffold.of(context).showSnackBar(
          SnackBar(content: Text(_returnString),
            duration: Duration(seconds: 10),
          ),

        );
      }
    }catch(e){
      print(e);
    }
  }
  Widget _googleButton(){
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: (){
        _loginUser(
            type: LoginType.google,
            context:context);

      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              // Image.asset('Image/images.jpg',height: 40,width: 40,),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text('Log In with google',style: TextStyle(fontSize: 20,color: Colors.grey
                ),
                ),
              ),

            ]
        ),
      ),
    );
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
            child: Text('Log In',style: TextStyle(color: Theme.of(context).secondaryHeaderColor,fontSize: 25.0,fontWeight: FontWeight.bold
            ),
            ),

          ),
          TextFormField(controller: _emailController,
            decoration: InputDecoration(prefix: Icon(Icons.alternate_email),hintText: 'Email' ),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 20.0,),
          TextFormField(controller: _passwordController,
            decoration: InputDecoration(prefix: Icon(Icons.lock_outline),hintText: 'Password' ),obscureText: true,),
          SizedBox(height: 20.0,),
          RaisedButton(child: Padding(padding: EdgeInsets.symmetric(horizontal: 70,),
            child: Text('Log In',style: TextStyle(color: Colors.white ,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
            ),
          ),
            onPressed: (){
              _loginUser(
                  type: LoginType.email,
                  email: _emailController.text,
                  password: _passwordController.text,
                  context:context);
            },
          ),
          FlatButton(child: Text("Don't have an Account? Sign up here"),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder:
                  (context)=>OurSignupPage(),
              ),
              );
            },
          ),
          _googleButton(),
        ],
      ),

    );
  }

}
