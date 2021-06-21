import 'package:flutter/material.dart';
import 'package:pexel/favorite/Widget/fevariteImage.dart';
import 'package:pexel/favorite/Widget/fevariteVideo.dart';
class Ourfavorite extends StatefulWidget {
  @override
  _OurfavoriteState createState() => _OurfavoriteState();
}

class _OurfavoriteState extends State<Ourfavorite> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(

      length: 2,
      child: Scaffold(

backgroundColor: Colors.white38,
        appBar: AppBar(
         title:Text("My Fevaritete"),
          bottom: TabBar(
            tabs: [
              Text("Pexels Image",style: TextStyle(fontSize: 20),),
              Text('Pexels Video',style: TextStyle(fontSize: 20),),
            ],
          ),

        ),
        body: TabBarView(

          children: [
            fevariteImageList(),
            fevariteVideoList(),

          ],
        ),
      ),
    );
  }
}
