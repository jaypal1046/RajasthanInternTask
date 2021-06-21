import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pexel/Database/database.dart';
import 'package:pexel/Imagerespond.dart';
import 'package:photo_view/photo_view.dart';

class OurImageView extends StatefulWidget {
  Photos photo;
  OurImageView({this.photo});

  @override
  _OurImageViewState createState() => _OurImageViewState();
}

class _OurImageViewState extends State<OurImageView> {
  bool like;

  getImageName(String email) {
    if (email.contains("/photo/")) {
      String retval = "${email.split("/photo/")[1]}";
      if (retval.contains("/")) {
        return "${retval.split("/")[0]}";
      } else {
        return retval;
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      like = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Material(

        child: Column(
          children: [

            Expanded(child: PhotoView(

              imageProvider: CachedNetworkImageProvider(
                widget.photo.src.medium,
                maxWidth: 250,
                maxHeight: 250,
              ),
            ),
            ),
            GestureDetector(
              onTap: () {
                Photos imagedata = Photos();
                setState(() {
                  if (like == true) {
                    like = false;
                  } else {
                    imagedata.url = widget.photo.url;
                    imagedata.width = widget.photo.width;
                    imagedata.height = widget.photo.height;
                    imagedata.id = widget.photo.id;

                    imagedata.avgColor = widget.photo.avgColor;
                    imagedata.photographer = widget.photo.photographer;

                    imagedata.photographerId = widget.photo.photographerId;
                    imagedata.photographerUrl = widget.photo.photographerUrl;
                    imagedata.src = widget.photo.src;

                    OurDatabase().createImage(imagedata).then((value) {
                      like = true;
                    });
                  }
                }

                );


                // Navigator.push(context, MaterialPageRoute(builder: (context)=>Ourfavorite()));
              },

              child: like == false ? likes() : unlike(),
            ),
            Text(getImageName("${widget.photo.url}"),
              style: TextStyle(fontSize: 15,),),
            Text(
              "${widget.photo.photographer}", style: TextStyle(fontSize: 13,),),
            Text("${widget.photo.width}X${widget.photo.height}",
              style: TextStyle(fontSize: 13,),),


          ],
        ),

      ),
    );
  }

  Widget likes() {
    return Icon(Icons.favorite, color: Colors.redAccent,
      size: 34,
      semanticLabel: "favorite",);
  }

  Widget unlike() {
    return Icon(Icons.favorite_border, color: Colors.black87,
      size: 34,
      semanticLabel: "favorite",);
  }
}
