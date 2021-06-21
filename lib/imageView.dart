import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pexel/Imagerespond.dart';
import 'package:photo_view/photo_view.dart';

class OurImageView extends StatefulWidget {
  Photos photo;
  OurImageView({this.photo});

  @override
  _OurImageViewState createState() => _OurImageViewState();
}

class _OurImageViewState extends State<OurImageView> {
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
    return Scaffold(


      body: Material(

        child:  Column(
            children: [

             Expanded(child:  PhotoView(

               imageProvider: CachedNetworkImageProvider(
                 widget.photo.src.medium,
                 maxWidth: 250,
                 maxHeight: 250,
               ),
             ),
             ),
              Spacer(),
              Text(getImageName("${widget.photo.url}"),style: TextStyle(fontSize: 15,),),
              Text("${widget.photo.photographer}",style: TextStyle(fontSize: 13,),),
              Text("${widget.photo.width}X${widget.photo.height}",style: TextStyle(fontSize: 13,),),



            ],
          ),

      ),
    );

  }
}
