import 'package:flutter/material.dart';
import 'package:pexel/Videoresp.dart';
import 'package:video_player/video_player.dart';

class fevaritePlayVideoByLink extends StatefulWidget {
  Map<String, dynamic> data;
  fevaritePlayVideoByLink (  {this.data } );
  @override
  _OurVideoState createState() => _OurVideoState();
}
class _OurVideoState extends State<fevaritePlayVideoByLink> {

  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  bool like=false;

  List fileData=[];
  @override
  void initState() {
    var docList = widget.data["videoFiles"];
   
    setState(() {
      like=false;
    });
    _controller = VideoPlayerController.network(
        docList[0]["link"]
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
      backgroundColor: Colors.black12,
      body:Align(
        alignment: Alignment.center,
        child: Center(
          child: GestureDetector(
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
        ),
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