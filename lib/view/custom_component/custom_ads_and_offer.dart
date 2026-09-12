import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quizzy_app/model/ads_model.dart';
import 'package:quizzy_app/utils/app_images.dart';
import 'package:quizzy_app/view/custom_component/custom_circular_progress_indicator.dart';
import 'package:quizzy_app/view/custom_component/custom_text.dart';

class CustomAdsAndOffer extends StatelessWidget {
  final AdsData adsModel;
  const CustomAdsAndOffer({super.key, required this.adsModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: AlignmentDirectional.centerEnd,
      // // alignment: null,

      clipBehavior: Clip.antiAliasWithSaveLayer,
      // margin: EdgeInsets.only(bottom: 15.h, left: 15.w, right: 15.w),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxHeight: 150.h, maxWidth: ScreenUtil().screenWidth * 0.80),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            adsModel.photo != null
                ? CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: adsModel.photo!,
                    fadeInDuration: const Duration(seconds: 1),
                    placeholder: (context, url) =>
                        const CustomCircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                : Image.asset(
                    Assets.imagesElan,
                    fit: BoxFit.fill,
                  ),
            adsModel.title != null
                ? Padding(
                    padding: REdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: SingleChildScrollView(
                      child: CustomText(
                        textDirection: TextDirection.rtl,
                        text: adsModel.title!,
                        fontSize: 18.sp,
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        textAlign: TextAlign.center,
                        maxLines: 500,
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
