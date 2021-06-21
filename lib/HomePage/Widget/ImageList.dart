import 'package:flutter/material.dart';
import 'package:pexel/ApiHelper/ApiResponce.dart';
import 'package:pexel/Bloc/block.dart';
import 'package:pexel/Imagerespond.dart';
import 'package:pexel/imageView.dart';

class ImageList extends StatefulWidget {
  @override
  _ImageListState createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  ImageBlockBloc _bloc;
  final String _baseUrl = "https://api.pexels.com/v1/";
  @override
  void initState() {
    super.initState();
    _bloc = ImageBlockBloc(baseurl: _baseUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.black54,
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchMovieList(),
        child: StreamBuilder<ApiResponse<ImageData>>(
          stream: _bloc.movieListStream,
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
                    onRetryPressed: () => _bloc.fetchMovieList(),
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
  final ImageData movieList;

  const MovieList({Key key, this.movieList}) : super(key: key);
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

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollDetails){
        if(movieList.photos.length==movieList.perPage){
          lodmoreImage();
        }
      },
      child: ListView.builder(
        itemCount: movieList.photos.length,

        itemBuilder: (context, index) {
          print(movieList.photos[index]);
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>OurImageView(photo:movieList.photos[index])));
                  },
                  child:  Image.network(
                    '${movieList.photos[index].src.landscape}',
                    fit: BoxFit.fill,
                  ),),
                Text(getImageName("${movieList.photos[index].url}"),style: TextStyle(fontSize: 15,),),
                Text("${movieList.photos[index].photographer}",style: TextStyle(fontSize: 13,),),

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