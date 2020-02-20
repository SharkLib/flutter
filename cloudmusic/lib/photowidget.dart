import 'package:flutter/material.dart';
//import 'package:photo/photo.dart';
//import 'package:photo_manager/photo_manager.dart';
import 'package:camera/camera.dart';
class PhotoWidget extends StatelessWidget {
  final Color color  ;

  PhotoWidget(this.color);
  List<CameraDescription> cameras;



  @override
  Widget build(BuildContext context) {

    void pickAssets() async {
      //List<AssetEntity> assetList = await PhotoPicker.pickAsset(context: context);
      /// Use assetList to do something.
    }

    Future<void> prepareCamera() async {
      cameras = await availableCameras();
  
    }


    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon:  Icon(Icons.star_border),
            color: Colors.red[500],
            onPressed: ()
            {
              pickAssets();
            },
          ),

        ),
        SizedBox(
          width: 18,
          child: Container(
            child: Text('ddfd'),
          ),
        ),

      ],
    );

  }
}