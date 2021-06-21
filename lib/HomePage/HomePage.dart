import 'package:flutter/material.dart';
import 'package:pexel/HomePage/Widget/ImageList.dart';
import 'package:pexel/HomePage/Widget/VideoList.dart';
import 'package:pexel/favorite/favarite.dart';
class OurHomePage extends StatefulWidget {
  @override
  _OurHomePageState createState() => _OurHomePageState();
}

class _OurHomePageState extends State<OurHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(

        appBar: AppBar(
          title: Text("Home"),
          actions: [
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Ourfavorite()));
              },

              child: Icon(Icons.favorite,color: Colors.redAccent,size: 35,semanticLabel: "favorite",),
            ),
            SizedBox(width: 15,)
          ],
          bottom: TabBar(
            tabs: [
              Text("Pexels Image",style: TextStyle(fontSize: 20),),
              Text('Pexels Video',style: TextStyle(fontSize: 20),),
            ],
          ),

        ),
        body: TabBarView(
          children: [
            ImageList(),
            VideoList(),

          ],
        ),
      ),
    );

  }
}
