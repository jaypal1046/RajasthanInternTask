import 'dart:async';

import 'package:pexel/ApiHelper/ApiResponce.dart';
import 'package:pexel/ImageReposetry.dart';
import 'package:pexel/Imagerespond.dart';

class ImageBlockBloc {
  ImageRepository _ImageRepository;
  StreamController _ImageListController;
String baseurl;
  StreamSink<ApiResponse<ImageData>> get ImageListSink =>
      _ImageListController.sink;

  Stream<ApiResponse<ImageData>> get ImageListStream {
    print(_ImageListController.stream);
    return _ImageListController.stream;
  }


  ImageBlockBloc({this.baseurl}) {

    _ImageListController = StreamController<ApiResponse<ImageData>>();
    _ImageRepository = ImageRepository(url: baseurl);

    fetchImageList();
  }

  fetchImageList() async {
    ImageListSink.add(ApiResponse.loading('Fetching Pexels Image'));
    try {
      ImageData movies = await _ImageRepository.fetchMovieList();
      ImageListSink.add(ApiResponse.completed(movies));
    } catch (e) {
      ImageListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _ImageListController?.close();
  }
}