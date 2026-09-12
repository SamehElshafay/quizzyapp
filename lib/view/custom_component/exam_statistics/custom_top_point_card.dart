import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/model/top_student_dataModel.dart';
import 'package:quizzy_app/utils/app_images.dart';
import 'package:quizzy_app/utils/general_utils.dart';
import 'package:quizzy_app/utils/validation.dart';
import 'package:quizzy_app/view/custom_component/custom_circular_progress_indicator.dart';
import 'package:quizzy_app/view/custom_component/custom_text.dart';
import 'package:quizzy_app/view_model/utils/theme/theme_view_model.dart';

class CustomTopPointCard extends StatelessWidget {
  const CustomTopPointCard(
      {super.key, required this.topStudentDataModel, required this.index});
  final TopStudentDataModel topStudentDataModel;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: topStudentDataModel.isCurrentStudent!
              ? Get.find<ThemeViewMode>().isDarkMode()
                  ? GeneralUtils.instance
                      .convertColorToDark(Color.fromRGBO(73, 150, 191, 0.37))
                  : Color.fromRGBO(73, 150, 191, 0.37)
              : null,
          borderRadius: BorderRadius.circular(8.r)), // rgba(73, 150, 191, 0.37)
      padding: REdgeInsets.symmetric(
        horizontal: 30,
        vertical: 8,
      ),
      margin: REdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Row(
        children: [
          Container(
            alignment: AlignmentDirectional.center,
            padding: REdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
                // color: const Color(0xffFBECFF),
                color: Get.find<ThemeViewMode>().isDarkMode()
                    ? Colors.black26
                    : const Color(0xffFBECFF),
                borderRadius: BorderRadius.circular(20).r),
            child: CustomText(
              text: "${topStudentDataModel.totalEarnedMarks ?? "0"} pt",
              fontSize: 14.sp,
              fontFamily: "Cairo",
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(flex: 4, child: SizedBox()),
          CustomText(
            text: topStudentDataModel.student!.username == null
                ? ""
                : topStudentDataModel.isCurrentStudent ?? false
                    ? "أنت"
                    : topStudentDataModel.student!.username!.length > 11
                        ? "${topStudentDataModel.student!.username!.substring(0, 11)}..."
                        : topStudentDataModel.student!.username.toString(),
            fontFamily: "Cairo",
            textDirection: Validation.instance.isEnglishText(
                    text: topStudentDataModel.student!.username ?? "")
                ? TextDirection.ltr
                : TextDirection.rtl,
            fontSize: 14.sp,
          ),
          Expanded(flex: 2, child: SizedBox()),
          Container(
            width: 60.w,
            height: 60.h,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              // border: Border.all(
              //     width: 2.r, color: Color(0xff4490BA)),
            ),
            child: topStudentDataModel.student!.photo == null
                ? Image.asset(
                    Assets.placeholderProfile,
                    fit: BoxFit.cover,
                  )
                : CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: topStudentDataModel.student!.photo!,
                    fadeInDuration: const Duration(seconds: 1),
                    placeholder: (context, url) =>
                        const CustomCircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
          ),
          Expanded(flex: 1, child: SizedBox()),
          CustomText(
            text: index < 9 ? "0${index + 1}" : "${index + 1}",
            fontFamily: "Cairo",
            textDirection: TextDirection.ltr,
            fontSize: 14.sp,
          ),
        ],
      ),
    );
  }
}
