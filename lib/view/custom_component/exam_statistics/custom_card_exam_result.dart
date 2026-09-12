import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/view/custom_component/exam_statistics/custom_statistics_text.dart';
import 'package:quizzy_app/view_model/utils/theme/theme_view_model.dart';

class CustomCardExamResult extends StatelessWidget {
  final String totalQuestions;
  final String numberWrongAnswer;
  final String numberCorrectAnswer;
  const CustomCardExamResult(
      {super.key,
      required this.numberCorrectAnswer,
      required this.numberWrongAnswer,
      required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 305.w,
      height: 250.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(0, 4),
              spreadRadius: 0,
              blurRadius: 5,
              color: Get.find<ThemeViewMode>().isDarkMode()
                  ? Colors.white30
                  : const Color.fromRGBO(0, 0, 0, 0.50),
              //  color: Colors.white30
            ),
          ],
          borderRadius: BorderRadius.circular(30).r,
          color: Get.find<ThemeViewMode>().isDarkMode()
              ? Theme.of(context).scaffoldBackgroundColor
              : Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomStatisticsText(
                text: 'مجموع الاسئلة',
                numbertext: totalQuestions,
                color: const Color(0xff4996BF),
              ),
              30.verticalSpace,
              CustomStatisticsText(
                text: 'اجابة خاطئة',
                numbertext: numberWrongAnswer,
                color: const Color(0xffFA3939),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const CustomStatisticsText(
                text: 'اكتمل الاختبار',
                numbertext: "100%",
                color: Color(0xff4996BF),
              ),
              30.verticalSpace,
              CustomStatisticsText(
                text: 'اجابة صحيحة',
                numbertext: numberCorrectAnswer,
                color: const Color(0xff2FD21C),
              ),
            ],
          )
        ],
      ),
    );
  }
}
