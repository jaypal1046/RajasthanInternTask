import 'package:flutter/material.dart';
import 'package:pexel/HomePage/HomePage.dart';
import 'package:pexel/Login/login.dart';
import 'package:pexel/slaceScreen/splacecreen.dart';
import 'package:pexel/stateprovider/stateProvider.dart';
import 'package:provider/provider.dart';

enum AuthState{
  unknown,
  notLoggedIn,
  isLoggedIn,
}
class OurRoot extends StatefulWidget {
  @override
  _OurRootState createState() => _OurRootState();
}

class _OurRootState extends State<OurRoot> {
  AuthState _authState=AuthState.unknown;


  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    //getState,checkState,set AuthSate base on state
    CurrentState _currentUse=Provider.of<CurrentState>(context,listen: false);
    String returnString=await _currentUse.OnStartup();


    if(returnString=="success"){
      if(_currentUse.getCurrentUser.uid ==null){
        setState(() {
          _authState = AuthState.notLoggedIn;
        });
      }else {
        setState(() {
          _authState = AuthState.isLoggedIn;
        });
      }

    }else{
      setState(() {
        _authState = AuthState.notLoggedIn;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    Widget retVal;

    switch(_authState){
      case AuthState.unknown:
        retVal=OurSplashScreen();
        break;
      case AuthState.notLoggedIn:
        retVal=OurLoginScreen();
        break;
      case AuthState.isLoggedIn:
        retVal= OurHomePage();
        break;

      default:
    }
    return retVal;
  }
}
