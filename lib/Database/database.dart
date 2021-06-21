import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pexel/Imagerespond.dart';
import 'package:pexel/Videoresp.dart';
import 'package:pexel/model/User.dart';

class OurDatabase {
  CollectionReference video=FirebaseFirestore.instance.collection("FVideo");
  CollectionReference image=FirebaseFirestore.instance.collection("FImage");
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
    /*"videoPictures":{ for (var i=0;i<=user.videoPictures.length-1;i++){
    {
    i:{

    }

    }
    }},*/

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
      video.doc(currentUser.uid).collection("data").doc()
          .set({
       "id":user.id,
     "width":user.width,
       "height":user.height,
    "url":user.url,
     "image":user.image,
       "duration":user.duration,
        "user": {
          "id":user.user.id,
          "link":user.user.url,
          "name":user.user.name,
        },
        "videoFiles": [
         {
           "id":user.videoFiles[0].id,
           "link":user.videoFiles[0].link,
           "height":user.videoFiles[0].height,
           "width":user.videoFiles[0].width,
           "quality":user.videoFiles[0].quality,
           "fileType":user.videoFiles[0].fileType,
         },{
            "id":user.videoFiles[1].id,
            "link":user.videoFiles[1].link,
            "height":user.videoFiles[1].height,
            "width":user.videoFiles[1].width,
            "quality":user.videoFiles[1].quality,
            "fileType":user.videoFiles[1].fileType,
          }
        ],

        "videoPictures":[
          {
            "id":user.videoPictures[0].id,
            "picture":user.videoPictures[0].picture,
            "nr":user.videoPictures[0].nr,
          },
          {
            "id":user.videoPictures[1].id,
            "picture":user.videoPictures[1].picture,
            "nr":user.videoPictures[1].nr,
          },
          {
            "id":user.videoPictures[2].id,
            "picture":user.videoPictures[2].picture,
            "nr":user.videoPictures[2].nr,
          }, {
            "id":user.videoPictures[3].id,
            "picture":user.videoPictures[3].picture,
            "nr":user.videoPictures[3].nr,
          }, {
            "id":user.videoPictures[4].id,
            "picture":user.videoPictures[4].picture,
            "nr":user.videoPictures[4].nr,
          },



        ]


      })
          .then((value) {
            print("data Inserted success full");



      })
          .catchError((error) => print("Failed to add new user:$error"));
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }
  Future<String> createImage(Photos user) async {
    String retVal = "error";
    try {
      User currentUser = _auth.currentUser;
      image.doc(currentUser.uid).collection("data").doc()
          .set({
        "id":user.id,
        "width":user.width,
        "height":user.height,
        "url":user.url,
        "photographerUrl":user.photographerUrl,
        "photographer":user.photographer,
        "photographerId":user.photographerId,
        "avgColor":user.avgColor,
        "src":{
          "landscape":user.src.landscape,
          "large":user.src.large,
          "large2x":user.src.large2x,
          "medium":user.src.medium,
          "original":user.src.original,
          "portrait":user.src.portrait,
          "small":user.src.small,
          "tiny":user.src.tiny,
        }

      })
          .then((value) {
        print("data Inserted success full");


      })
          .catchError((error) => print("Failed to add new user:$error"));
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }
}
