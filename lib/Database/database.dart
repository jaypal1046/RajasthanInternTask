import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pexel/Videoresp.dart';
import 'package:pexel/model/User.dart';

class OurDatabase {
  CollectionReference users = FirebaseFirestore.instance.collection("User");
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> createUser(OurUser user) async {
    String retVal = "error";
    try {
      users = FirebaseFirestore.instance.collection("User");
      users
          .doc(user.uid)
          .set({
        "uid": user.uid,
        "fullName": user.fullName,
        "email": user.email,
        "photo": user.profilePhoto,
      })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add new user:$error"));
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<OurUser> getUserInfo(String uid) async {
    OurUser retVal = OurUser();

    try {
      CollectionReference snapshot =
      await FirebaseFirestore.instance.collection("User");
      DocumentSnapshot collection = await snapshot.doc(uid).get();
      if (collection.exists) {
        retVal.uid = collection.data()["uid"];
        retVal.email = collection.data()["email"];
        retVal.profilePhoto = collection.data()["profilePhoto"];
        retVal.fullName = collection.data()["fullName"];
      }
    } catch (e) {
      print(e);
    }
    return retVal;
  }
  Future<String> createVider(Videos user) async {
    String retVal = "error";
    try {
      User currentUser = _auth.currentUser;
      users = FirebaseFirestore.instance.collection("FVideo");
      users
          .doc()
          .set({
       "id":user.id,
     "width":user.width,
       "height":user.height,
    "url":user.url,
     "image":user.image,
       "duration":user.duration,
       "user":user.user,

      })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add new user:$error"));
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }
}
