import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quizzy_app/model/top_student_dataModel.dart';
import 'package:quizzy_app/utils/app_images.dart';
import 'package:quizzy_app/view/custom_component/custom_circular_progress_indicator.dart';
import 'package:quizzy_app/view/custom_component/custom_text.dart';
import 'package:quizzy_app/view/custom_component/exam_statistics/custom_rotated_container.dart';

/*
Angle 1 : -7.29
Color.fromRGBO(225, 230, 0,
                                              1)
*/
class CustomTopThreeStudent extends StatelessWidget {
  final TopStudentDataModel topStudentDataModel;
  final double? width;
  final double? hight;
  final String number;
  final double? numberFontSize;
  final bool isAvailable;
  final double angleInDegrees;
  final Color? color;
  final double verticalSpacePicture;
  const CustomTopThreeStudent({
    super.key,
    this.width = 103,
    this.hight = 166,
    this.color = const Color.fromRGBO(159, 225, 83, 1),
    this.numberFontSize = 75,
    required this.number,
    this.verticalSpacePicture = 10,
    required this.isAvailable,
    required this.angleInDegrees,
    required this.topStudentDataModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RotatedContainer(
          angleInDegrees: angleInDegrees,
          child: Column(
            children: [
              Container(
                width: 56.w,
                height: 53.h,
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
              verticalSpacePicture.verticalSpace,
              Container(
                  width: width!.w,
                  height: hight!.h,
                  color: color, // rgba(159, 255, 83, 1)
                  child: Column(
                    children: [
                      CustomText(
                        text: number,
                        fontSize: numberFontSize,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontFamily: 'DMSans',
                      ),
                      2.verticalSpace,
                      CustomText(
                        text: isAvailable
                            ? "${topStudentDataModel.totalEarnedMarks.toString()} pt"
                            : "لايوجد",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontFamily: 'DMSans',
                      )
                    ],
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
