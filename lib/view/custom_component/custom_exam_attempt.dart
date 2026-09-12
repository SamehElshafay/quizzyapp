import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:quizzy_app/model/exam_attempts_model.dart';
import 'package:quizzy_app/utils/app_images.dart';
import 'package:quizzy_app/utils/constant.dart';
import 'package:quizzy_app/utils/general_utils.dart';
import 'package:quizzy_app/view/custom_component/custom_text.dart';
import 'package:quizzy_app/view_model/bottomNavigation/home_view_model.dart';
import 'package:quizzy_app/view_model/bottomNavigation/mange_bottom_navigation_view_model.dart';
import 'package:quizzy_app/view_model/utils/theme/theme_view_model.dart';

class CustomExamAttempts extends StatelessWidget {
  final ExamAttemptsDataModel? examAttemptsDataModel;
  final void Function()? onPressed;
  final bool isEmpty;
  final bool showSearchEmpty;

  const CustomExamAttempts(
      {super.key,
      this.examAttemptsDataModel,
      this.isEmpty = false,
      this.showSearchEmpty = false,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          alignment: AlignmentDirectional.center,
          width: MediaQuery.of(context).size.width * 0.90,
          height: 150.h,
          padding: REdgeInsets.symmetric(horizontal: 8).r,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12).r,
              color: Get.find<ThemeViewMode>().isDarkMode()
                  ? GeneralUtils.instance
                      .convertColorToDark(const Color(0xff268C6D))
                  : const Color(0xff268C6D)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomText(
                    text: showSearchEmpty
                        ? "لايوجد امتحانات بهذا الإسم"
                        : isEmpty ||
                                examAttemptsDataModel == null ||
                                examAttemptsDataModel!.subject == null
                            ? "هل تود بدء امتحان"
                            : "هل تود استئناف امتحان",
                    fontFamily: "Cairo",
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                    color: Get.find<ThemeViewMode>().isDarkMode()
                        ? GeneralUtils.instance.convertColorToDark(Colors.white)
                        : Colors.white,
                  ),
                  5.verticalSpace,
                  Row(
                    children: [
                      showSearchEmpty
                          ? const SizedBox()
                          : Container(
                              alignment: AlignmentDirectional.center,
                              width: 30.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6).r,
                                  color: Get.find<ThemeViewMode>().isDarkMode()
                                      ? GeneralUtils.instance
                                          .convertColorToDark(Colors.white)
                                      : Colors.white),
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  size: 16.w,
                                  color: Colors.green,
                                ),
                                onPressed: isEmpty ||
                                        examAttemptsDataModel == null ||
                                        examAttemptsDataModel!.subject == null
                                    ? () {
                                        Get.find<
                                                ManageBottomNavigationViewModel>()
                                            .gotToExamPageManuallyWithoutClickOnIt();
                                      }
                                    : onPressed,
                              )),
                      10.horizontalSpace,
                      CustomText(
                        textDirection: TextDirection.rtl,
                        text: showSearchEmpty
                            ? 'لكي يتم استئنافها'
                            : isEmpty ||
                                    examAttemptsDataModel == null ||
                                    examAttemptsDataModel!.subject == null
                                ? "جديد"
                                : examAttemptsDataModel!.subject!.name!.length >
                                        40
                                    ? '${examAttemptsDataModel!.subject!.name!.substring(0, 20)} ....؟'
                                    : "${examAttemptsDataModel!.subject!.name} ؟",
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp,
                        color: Get.find<ThemeViewMode>().isDarkMode()
                            ? GeneralUtils.instance
                                .convertColorToDark(Colors.white)
                            : Colors.white,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          top: -30.h,
          left: -18.w,
          child: SizedBox(
            child: Image.asset(
              Assets.imagesStudent,
              cacheWidth: 150,
              cacheHeight: 500,
              filterQuality: FilterQuality.high,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        Positioned(
          // top: -45.h,
          // left: 125.w,
          // right: 0.0,
          // bottom: 0.0,
          top: -45.0,
          left: 0.0,
          right: 0.0,
          bottom: 0.0,
          child: SizedBox(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: const EdgeInsets.all(5).h,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Get.find<ThemeViewMode>().isDarkMode()
                        ? Theme.of(context).scaffoldBackgroundColor
                        : Colors.white),
                child: Container(
                  // color: Colors.amber,
                  child: CircularPercentIndicator(
                    radius: 35.r,
                    percent: isEmpty ||
                            examAttemptsDataModel == null ||
                            examAttemptsDataModel!.subject == null
                        ? 0
                        : examAttemptsDataModel!.totalAnsweredQuestions! /
                            examAttemptsDataModel!.totalQuestions!,
                    backgroundColor: Get.find<ThemeViewMode>().isDarkMode()
                        ? Theme.of(context).scaffoldBackgroundColor
                        : Colors.white,
                    progressColor: Get.find<ThemeViewMode>().isDarkMode()
                        ? GeneralUtils.instance
                            .convertColorToDark(Colors.blueAccent)
                        : Colors.blueAccent,
                    center: isEmpty ||
                            examAttemptsDataModel == null ||
                            examAttemptsDataModel!.subject == null
                        ? Icon(
                            Icons.wb_sunny,
                            size: 30.r,
                            color: primayColor,
                          )
                        : CustomText(
                            color: Get.find<ThemeViewMode>().isDarkMode()
                                ? GeneralUtils.instance
                                    .convertColorToDark(Colors.blue)
                                : Colors.blue,
                            text: examAttemptsDataModel!.totalAnsweredQuestions!
                                .toString(),
                            fontWeight: FontWeight.bold,
                            fontSize: examAttemptsDataModel!
                                        .totalAnsweredQuestions!
                                        .toString()
                                        .length >
                                    3
                                ? 20.sp
                                : 25.sp,
                          ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
