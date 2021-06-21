import 'dart:async';

import 'package:pexel/ApiHelper/ApiResponce.dart';
import 'package:pexel/ImageReposetry.dart';
import 'package:pexel/Imagerespond.dart';

class ImageBlockBloc {
  ImageRepository _movieRepository;
  StreamController _movieListController;
String baseurl;
  StreamSink<ApiResponse<ImageData>> get movieListSink =>
      _movieListController.sink;

  Stream<ApiResponse<ImageData>> get movieListStream {
    print(_movieListController.stream);
    return _movieListController.stream;
  }


  ImageBlockBloc({this.baseurl}) {

    _movieListController = StreamController<ApiResponse<ImageData>>();
    _movieRepository = ImageRepository(url: baseurl);

    fetchMovieList();
  }

  fetchMovieList() async {
    movieListSink.add(ApiResponse.loading('Fetching Popular Image'));
    try {
      ImageData movies = await _movieRepository.fetchMovieList();
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