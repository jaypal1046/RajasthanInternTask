import 'package:flutter/material.dart';
import 'package:pexel/ApiHelper/ApiResponce.dart';
import 'package:pexel/Bloc/VideoBloc.dart';

import 'package:pexel/Imagerespond.dart';
import 'package:pexel/VideoPlayScreen.dart';
import 'package:pexel/Videoresp.dart';
import 'package:pexel/imageView.dart';

class VideoList extends StatefulWidget {
  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  VideoBlockBloc _bloc;
String baseurl="https://api.pexels.com/videos";
  @override
  void initState() {
    super.initState();
    _bloc = VideoBlockBloc(baseurl: baseurl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.black54,
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchVideoList(),
        child: StreamBuilder<ApiResponse<videoData>>(
          stream: _bloc.VideoListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data.message);
                  break;
                case Status.COMPLETED:
                  return MovieList(movieList: snapshot.data.data);
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _bloc.fetchVideoList(),
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class MovieList extends StatelessWidget {
  final videoData movieList;

  const MovieList({Key key, this.movieList}) : super(key: key);
  getImageName(String email){
    if(email.contains("/video/")) {
      String retval=  "${email.split("/video/")[1]}";
      if( retval.contains("/")){
        return "${retval.split("/")[0]}";
      }else{
        return retval;
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(

      child: ListView.builder(
        itemCount: movieList.videos.length,

        itemBuilder: (context, index) {
          print(movieList.videos[index]);
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: (){
                 //   print("${movieList.videos[index].videoFiles[index].link} 123456");
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PlayVideoByLink(video: movieList.videos[index].videoFiles[1].link,data: movieList.videos[index],)));
                  },
                  child: Image.network(
          '${movieList.videos[index].image}',
          fit: BoxFit.fill,
          ),

                ),
               Text(getImageName("${movieList.videos[index].url}"),style: TextStyle(fontSize: 15,),),
                Text("${movieList.videos[index].user.name}",style: TextStyle(fontSize: 13,),),

              ],
            ),
          );

        },
      ),);
  }
}

lodmoreImage() {

}

class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.lightGreen,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            color: Colors.lightGreen,
            child: Text('Retry', style: TextStyle(color: Colors.white)),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.lightGreen,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
          ),
        ],
      ),
    );
  }
}