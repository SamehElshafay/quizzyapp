import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/utils/general_utils.dart';
import 'package:quizzy_app/view/custom_component/custom_text.dart';
import 'package:quizzy_app/view_model/utils/theme/theme_view_model.dart';

class CustomMessageSource extends StatelessWidget {
  const CustomMessageSource(
      {super.key, this.message = "غير قادر علي تحميل الملف الصوتي"});
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      height: 130.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Get.find<ThemeViewMode>().isDarkMode()
              ? GeneralUtils.instance
                  .convertColorToDark(const Color(0xff9FD800))
              : const Color(0xff9FD800),
          boxShadow: const <BoxShadow>[
            BoxShadow(
                offset: Offset(0, 5),
                spreadRadius: 0,
                blurRadius: 5,
                color: Color.fromRGBO(0, 0, 0, 0.25)),
          ],
          borderRadius: BorderRadius.circular(17).r),
      child: CustomText(
        text: message!,
        fontFamily: "Cairo",
        fontSize: 16.sp,
        textDirection: TextDirection.rtl,
      ),
    );
  }
}
