import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/model/Image_dimensions_model.dart';
import 'package:quizzy_app/utils/image_helper/custom_image_helper.dart';
import 'package:quizzy_app/utils/image_helper/custom_image_viewer.dart';
import 'package:quizzy_app/view_model/utils/theme/theme_view_model.dart';

import '../../../utils/general_utils.dart';

class CustomSourceImage extends StatelessWidget {
  const CustomSourceImage(
      {super.key, this.imageSourceLink, this.imageDimensionsModel});
  final String? imageSourceLink;
  final ImageDimensionsModel? imageDimensionsModel;
  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        height: 127.h,
        width: 190.w,
        decoration: BoxDecoration(
          color: Get.find<ThemeViewMode>().isDarkMode()
              ? GeneralUtils.instance
                  .convertColorToDark(const Color(0xff9FD800))
              : const Color(0xff9FD800),
          borderRadius: BorderRadius.circular(12).r,
        ),
        child: Stack(
          children: [
            CustomImageHelper(
                targetWidgetSize: Size(190.w, 127.h),
                fit: BoxFit.fill,
                imageDimensionsModel:
                    imageDimensionsModel ?? ImageDimensionsModel(),
                imageUrl: imageSourceLink ?? ""),
            Align(
              alignment: Alignment.topCenter,
              child: CustomImageViewer(
                isShowIconZoomOut: true,
                child: CustomImageHelper(
                    imageDimensionsModel:
                        imageDimensionsModel ?? ImageDimensionsModel(),
                    imageUrl: imageSourceLink ?? ""),
              ),
            ),
          ],
        ));
  }
}
/*
 CachedNetworkImage(
          fit: BoxFit.fill,
          height: 127.h,
          width: 190.w,
          imageUrl: imageSourceLink ?? "",
          fadeInDuration: const Duration(seconds: 1),
          placeholder: (context, url) =>
              const CustomCircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ))
*/
