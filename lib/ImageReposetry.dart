import 'package:pexel/ApiHelper/ApiBasehelper.dart';
import 'package:pexel/Imagerespond.dart';

class ImageRepository {
  final String _apiKey = "78b9f63937763a206bff26c070b94158";

  ApiBaseHelper _helper = ApiBaseHelper();
String url;
  ImageRepository( {this.url});

  Future<ImageData> fetchMovieList() async {

   final response = await _helper.get(url);
   print("${response} jay1046");
    return ImageData.fromJson(response);
  }
}