import 'package:flutter/material.dart';
import 'package:pexel/signup/Widget/SignupForm.dart';

class OurSignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.0),
              children: <Widget>[

                Row(

                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20,),
                    BackButton(),

                  ],
                ),

                SizedBox(height: 20,),
                SignupForm(),
              ],

            ),
          ),
        ],
      ),
    );
  }
}
