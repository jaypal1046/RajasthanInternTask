import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pexel/favorite/Widget/fevariteImageView.dart';
class fevariteImageList extends StatefulWidget {
  @override
  _fevariteImageListState createState() => _fevariteImageListState();
}

class _fevariteImageListState extends State<fevariteImageList> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("FImage").doc(_auth.currentUser.uid).collection("data").snapshots(),

        builder: (context,snapshot){
          if(snapshot.data==null){
            return Container(
              child: Align(
                alignment: Alignment.center,
                child: Text("jaypal"),

              ),
            );
          }else{
            getImageName(String email){
              if(email.contains("/photo/")) {
                String retval=  "${email.split("/photo/")[1]}";
                if( retval.contains("/")){
                  return "${retval.split("/")[0]}";
                }else{
                  return retval;
                }

              }
            }
            var docList = snapshot.data.docs;


            return ListView.builder(

              padding: EdgeInsets.all(10),
              itemCount: docList.length,
              itemBuilder: (context, index) {

                if(docList[index].id!=null){

                  return  docList[index].data()!=null?
                  SizedBox(

                      height: 220,
                      child: Column(


                        children: <Widget>[

                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>OurfevImageView(data:docList[index].data())));
                                    //   print("${movieList.videos[index].videoFiles[index].link} 123456");
                                  //  Navigator.push(context, MaterialPageRoute(builder: (context)=>fevaritePlayVideoByLink(data:docList[index].data())));
                                  },
                                  child: Image.network(
                                    '${docList[index].data()["src"]["landscape"]}',
                                    fit: BoxFit.fill,
                                  ),

                                ),
                                Text(getImageName("${docList[index].data()["url"]}"),style: TextStyle(fontSize: 15,),),
                                Text("${docList[index].data()["photographer"]}",style: TextStyle(fontSize: 13,),),

                              ],
                            ),
                          ),


                          /*  StreamBuilder<QuerySnapshot>(
                              stream: _firestore.collection("FVideo").snapshots(),
                              builder: (context,snapshot){
                                if(snapshot.data==null){

                                  return Container(
                                    child: Text("jaypal"),
                                    height: 0.1,
                                  );
                                }
                                else{
                                  var docLists = snapshot.data.docs;
                                  var view=docList[index].data()["view"];
                                  if(docList[index].data()["view"]==null){
                                    view=0;
                                  }
                                  return ListView.builder(
                                      padding: EdgeInsets.all(10),
                                      itemCount: docLists.length,
                                      itemBuilder: (context,inde){

                                        if(docLists[inde].id==docList[index].data()["uploaderUid"]){
                                          return Row(
                                            children: [
                                              SizedBox(width: 20,),
                                              Column(
                                                children: [

                                                  Text("${docList[index].data()["videoTital"]}",style: TextStyle(fontWeight: FontWeight.bold),),
                                                  Text("${docLists[inde].data()["fullName"]}"),
                                                ],
                                              ),
                                              SizedBox(width: 10,),
                                              Column(
                                                children: [

                                                  //Text("${docList[index].data()["uploadedDate"]}",style: TextStyle(fontWeight: FontWeight.bold),),
                                                  Text("${view} view"),
                                                ],
                                              ),
                                              SizedBox(width: 10,),
                                              Column(
                                                children: [

                                                  Text("0 days"),
                                                  Text("${docList[index].data()["catergary"]} catergory"),
                                                ],
                                              ),
                                            ],
                                          );
                                        }else{

                                          return Container(
                                            height: 0.1,
                                          );
                                        }
                                      }

                                  );
                                }
                              }
                          ),*/



                        ],
                      )):
                  Container(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(),
                  );
                }else{
                  return Container(


                    child: CircularProgressIndicator(),
                  );
                }


              },
            );
          }
        }
    );
  }
}
