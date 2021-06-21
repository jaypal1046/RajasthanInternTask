import 'dart:async';

import 'package:pexel/ApiHelper/ApiResponce.dart';
import 'package:pexel/ImageReposetry.dart';
import 'package:pexel/Imagerespond.dart';
import 'package:pexel/Videorepo.dart';
import 'package:pexel/Videoresp.dart';

class VideoBlockBloc {
  VideoRepository _movieRepository;
  StreamController _movieListController;
  String baseurl;
  StreamSink<ApiResponse<videoData>> get movieListSink =>
      _movieListController.sink;

  Stream<ApiResponse<videoData>> get movieListStream {
    print(_movieListController.stream);
    return _movieListController.stream;
  }


  VideoBlockBloc({this.baseurl}) {

    _movieListController = StreamController<ApiResponse<videoData>>();
    _movieRepository = VideoRepository(url: baseurl);

    fetchMovieList();
  }

  fetchMovieList() async {
    movieListSink.add(ApiResponse.loading('Fetching Popular Image'));
    try {
      videoData movies = await _movieRepository.fetchMovieList();
      movieListSink.add(ApiResponse.completed(movies));
    } catch (e) {
      movieListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _movieListController?.close();
  }
}