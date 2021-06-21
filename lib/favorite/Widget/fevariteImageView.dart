import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class OurfevImageView extends StatefulWidget {
  Map<String, dynamic> data;
  OurfevImageView({this.data});

  @override
  _OurfevImageViewState createState() => _OurfevImageViewState();
}

class _OurfevImageViewState extends State<OurfevImageView> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.black54,
      body: Material(

        child:PhotoView(
          imageProvider: CachedNetworkImageProvider(
            widget.data["src"]["original"]
          ),
        ),

      ),
    );
  }

}