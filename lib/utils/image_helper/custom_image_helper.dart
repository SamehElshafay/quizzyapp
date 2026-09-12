import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quizzy_app/model/Image_dimensions_model.dart';

import 'package:quizzy_app/utils/image_helper/image_extension.dart';
import 'package:quizzy_app/view/custom_component/custom_circular_progress_indicator.dart';

enum TypeOfImageWidget { asset, network, cacheNetworkPackage }

// ignore: must_be_immutable
class CustomImageHelper extends StatelessWidget {
  final String imageUrl;
  final TypeOfImageWidget typeOfImageWidget;
  double originImageAspectRatio = 0;
  final BoxFit? fit;
  Size?
      targetWidgetSize; // = const Size(250, 250);    // The Width , hight you wnat to put the image in the Screen  , if it null i Know you wnat display in
  // full Image or Display or diaplay in the Same AceptRaatio of the Image

  final ImageDimensionsModel imageDimensionsModel;

  CustomImageHelper(
      {super.key,
      this.targetWidgetSize,
      required this.imageDimensionsModel,
      this.fit,
      this.typeOfImageWidget = TypeOfImageWidget.network,
      required this.imageUrl}) {
    originImageAspectRatio =
        imageDimensionsModel.width! / imageDimensionsModel.height!;
    // height = (Iamgewidth / aspect ratio OfMobile)
    //  width = (Imageheight / aspect ratio OfMobile)
    if (imageUrl != "" ||
        imageDimensionsModel.height != null ||
        imageDimensionsModel.width != null) // to skip the Execption
    if (targetWidgetSize == null) {
      // it show it use Full Image
      print(ScreenUtil().pixelRatio!);
      double height = imageDimensionsModel.width! / ScreenUtil().pixelRatio!;
      double width = imageDimensionsModel.height! / ScreenUtil().pixelRatio!;
      targetWidgetSize = Size(width, height);
    }
  }

  @override
  Widget build(BuildContext context) {
    int? cacheWidth, cacheHeight;

    // If the original image aspect ratio is greater than 0, it means the image is wider than it is tall.
    if (imageUrl == "" ||
        imageDimensionsModel.height == null ||
        imageDimensionsModel.width == null) {
      // to Skip the Exception
      // if the image Url no  Link

      return Center(
          child: Icon(
        Icons.error,
        color: Colors.white,
        size: 30.r,
      ));
    }
    // to this
    if (originImageAspectRatio > 0) {
      cacheHeight = targetWidgetSize!.height.cacheSize(context);
    } else {
      cacheWidth = targetWidgetSize!.width.cacheSize(context);
    }

    return Image.network(
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null)
          return child; // to Change a State from  Loading to the Show Image

        return const Center(child: CustomCircularProgressIndicator());
      },

      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return Center(
            child: Icon(
          Icons.error,
          color: Colors.white,
          size: 30.r,
        ));
      },
      imageUrl,
      width: targetWidgetSize!.width,
      height: targetWidgetSize!.height,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
      fit: fit,
      // fit: BoxFit.fill,
    );
  }
}

// class ImageDimensionsModel {
//   int? width;
//   int? height;

//   ImageDimensionsModel({this.width, this.height});

//   factory ImageDimensionsModel.fromJson(Map<String, dynamic> json) {
//     return ImageDimensionsModel(height: json['height'], width: json['width']);
//   }

//   Map<String, dynamic> toJson() {
//     return {'width': width, 'height': height};
//   }
// }
