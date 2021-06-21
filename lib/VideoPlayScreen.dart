import 'package:flutter/material.dart';
import 'package:pexel/Database/database.dart';
import 'package:pexel/Videoresp.dart';
import 'package:pexel/favorite/favarite.dart';
import 'package:video_player/video_player.dart';
class PlayVideoByLink extends StatefulWidget {
  String video;
 Videos data;
  PlayVideoByLink ( {this.video,this.data,});
  @override
  _OurVideoState createState() => _OurVideoState();
}

class _OurVideoState extends State<PlayVideoByLink> {

  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
String link;
bool like=false;

  List fileData=[];
  @override
  void initState() {

    _controller = VideoPlayerController.network(
       widget.video
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  getImageName(String title){
    if(title.contains("/video/")) {
      String retval=  "${title.split("/video/")[1]}";
      if( retval.contains("/")){
        return "${retval.split("/")[0]}";
      }else{
        return retval;
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          GestureDetector(
            onTap:  () {
              setState(() {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {

                  _controller.play();
                }
              });
            },
            child: FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,

                    child: VideoPlayer(_controller),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),

          Row(children: [
            SizedBox(width: 20,),
            GestureDetector(
              onTap: (){
                Videos videodata=Videos();
                 setState(() {
                   if(like==true){
                   like=false;
                  }else{
                 like=true;
                 videodata.url=widget.data.url;
                 videodata.width=widget.data.width;
                 videodata.height=widget.data.height;
                 videodata.duration=widget.data.duration;
                 videodata.image=widget.data.image;
                 videodata.id=widget.data.id;
                 videodata.videoFiles=widget.data.videoFiles;
                 videodata.videoPictures=widget.data.videoPictures;
                 videodata.user=widget.data.user;
                 print(videodata.videoFiles[1].link);
                 print(videodata.videoPictures);
                 print(videodata.user);
                 OurDatabase().createVider(videodata);
                   }





                 }


                   );
              

               // Navigator.push(context, MaterialPageRoute(builder: (context)=>Ourfavorite()));
              },

              child:  like==false ? likes() : unlike(),
            ),
            SizedBox(width: 20,),
            Text(" Title: ${getImageName("${widget.data.url}")}",style: TextStyle(fontSize: 15,),),
          ],),
          Text(" Duration:${widget.data.duration} seconds",style: TextStyle(fontSize: 15,),),
       Row(children: [
         SizedBox(width: 20,),
         Text("Resulation:${widget.data.videoFiles[1].height}x${widget.data.videoFiles[1].width}",style: TextStyle(fontSize: 15,),),
         SizedBox(width: 10,),
         Text(" quality:${widget.data.videoFiles[1].quality}",style: TextStyle(fontSize: 15,),),
       ],),
          Text("Creator:${widget.data.user.name}",style: TextStyle(fontSize: 15,),),



        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
  Widget likes(){
    return Icon(Icons.favorite,color: Colors.redAccent,size: 34,semanticLabel: "favorite",);
  }
  Widget unlike(){
    return Icon(Icons.favorite_border,color: Colors.black87,size: 34,semanticLabel: "favorite",);
  }
}
