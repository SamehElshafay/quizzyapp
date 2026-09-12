import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quizzy_app/Service/local/cache_settings_service.dart';
import 'package:quizzy_app/Service/local/cache_user_service.dart';
import 'package:quizzy_app/utils/app_images.dart';
import 'package:quizzy_app/utils/constant.dart';
import 'package:quizzy_app/utils/validation.dart';
import 'package:quizzy_app/view/custom_component/custom_circular_progress_indicator.dart';
import 'package:quizzy_app/view/custom_component/custom_text.dart';

class CustomTopSectionOfSettingsView extends StatelessWidget {
  const CustomTopSectionOfSettingsView(
      {super.key,
      this.imageUrl,
      required this.name,
      required this.emailOrPhoneValue});

  final String emailOrPhoneValue;
  final String name;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return RPadding(
      padding: REdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              children: [
                CustomText(
                  text: emailOrPhoneValue,
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp,
                  color: primayColor,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          const Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText(
                  text: name, //  "ألاء سعيد"
                  fontWeight: FontWeight.w400,
                  fontSize: 18.sp,
                  fontFamily: "Cairo",
                  textDirection: Validation.instance.isEnglishText(text: name)
                      ? TextDirection.ltr
                      : TextDirection.rtl,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                CustomText(
                  text:
                      CacheUserService.instance.getUser().academicYear?.name ??
                          "زائر",
                  fontWeight: FontWeight.w200,
                  fontSize: 13.sp,
                  color: Colors.grey,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          10.horizontalSpace,
          Container(
            width: 40.w,
            height: 40.w,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: const BoxDecoration(
              color: Colors.amber,
              shape: BoxShape.circle,
              // border: Border.all(
              //     width: 2.r, color: Color(0xff4490BA)),
            ),
            child: imageUrl == null
                ? Image.asset(
                    Assets.placeholderProfile,
                    fit: BoxFit.cover,
                  )
                : CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: imageUrl!,
                    fadeInDuration: const Duration(seconds: 1),
                    placeholder: (context, url) =>
                        const CustomCircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
          ),
        ],
      ),
    );
  }
}
