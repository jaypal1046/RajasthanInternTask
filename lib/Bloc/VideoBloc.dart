import 'dart:async';

import 'package:pexel/ApiHelper/ApiResponce.dart';
import 'package:pexel/ImageReposetry.dart';
import 'package:pexel/Imagerespond.dart';
import 'package:pexel/Videorepo.dart';
import 'package:pexel/Videoresp.dart';

class VideoBlockBloc {
  VideoRepository _VideoRepository;
  StreamController _VideoListController;
  String baseurl;
  StreamSink<ApiResponse<videoData>> get VideoListSink =>
      _VideoListController.sink;

  Stream<ApiResponse<videoData>> get VideoListStream {
    print(_VideoListController.stream);
    return _VideoListController.stream;
  }


  VideoBlockBloc({this.baseurl}) {

    _VideoListController = StreamController<ApiResponse<videoData>>();
    _VideoRepository = VideoRepository(url: baseurl);

    fetchVideoList();
  }

  fetchVideoList() async {
    VideoListSink.add(ApiResponse.loading('Fetching Pexels Video'));
    try {
      videoData movies = await _VideoRepository.fetchMovieList();
      VideoListSink.add(ApiResponse.completed(movies));
    } catch (e) {
      VideoListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _VideoListController?.close();
  }
}