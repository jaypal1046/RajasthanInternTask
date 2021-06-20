import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pexel/Database/database.dart';
import 'package:pexel/model/User.dart';

class CurrentState extends ChangeNotifier{
  OurUser get getCurrentUser  => _currentUser;

  notifyListeners();
  OurUser _currentUser=OurUser();
  FirebaseAuth _auth=FirebaseAuth.instance;

  Future<String> OnStartup() async
  {
    String retval="error";
    try{
      User _firebaseUser= await _auth.currentUser;

      _currentUser= await OurDatabase().getUserInfo(_firebaseUser.uid);


      if(_currentUser!=null){
        retval="success";
      }
    }catch(e){

      print(e);
    }
    return retval;
  }
  Future<String> signUpUser(String email,String password,String fullName) async{
    String retval="error";
    OurUser _ourUser=OurUser();
    try{
      UserCredential _authResult= await _auth.createUserWithEmailAndPassword(email: email, password: password);

      _ourUser.uid=_authResult.user.uid;
      _ourUser.email=_authResult.user.email;
      _ourUser.fullName=fullName;

      if(_authResult.user.photoURL==null){
        _ourUser.profilePhoto="https://drive.google.com/u/0/uc?id=1Hya7qyPsb7PF8WI_lRm5fB761d9z1_tm&export=download";
      }

      String _returnString=await OurDatabase().createUser(_ourUser);
      if(_returnString=="success"){
        retval="success";
      }
    }catch(e){
      retval=e.message;
    }
    return retval;
  }
  Future<String> logInUserwithEmail( String email,String password ) async{
    String retval="error";
    try{
      final _authResult=await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseFirestore.instance
          .collection("User").doc(_authResult.user.uid)
          .get().then((value) {


      });
      FirebaseFirestore.instance.collection("User").doc().get().then((DocumentSnapshot snapshot){
        if(!snapshot.exists){

          retval="success";
        }
      });
      _currentUser= await OurDatabase().getUserInfo(_authResult.user.uid);

      if(_currentUser!=null){
        retval="success";


      }

    }catch(e){
      print( "${e.message} ");
    }
    return retval;
  }

  Future<String> logInUserWithGoogle( ) async{
    String retval="error";

    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    OurUser _user=OurUser();

    try{
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult = await _auth.signInWithCredential(credential);



      _user.uid=await authResult.user.uid;
      _user.uid=await authResult.user.uid;

      if(authResult.additionalUserInfo.isNewUser)
      {

        _user.uid=await authResult.user.uid;
        _user.email=await authResult.user.email;
        _user.fullName=await authResult.user.displayName;
        if(authResult.user.photoURL==null){
        }else {
          _user.profilePhoto = authResult.user.photoURL;
        }


        await OurDatabase().createUser(_user);
      }




      _currentUser= await OurDatabase().getUserInfo(authResult.user.uid);
      if(_currentUser!=null){
        retval="success";
      }
    }on PlatformException catch(e){
      retval=e.message;
    }catch(e){
      print(e);
    }
    return retval;
  }

}