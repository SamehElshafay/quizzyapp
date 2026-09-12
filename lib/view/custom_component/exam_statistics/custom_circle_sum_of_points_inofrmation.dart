import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quizzy_app/utils/general_utils.dart';
import 'package:quizzy_app/view/custom_component/custom_text.dart';
import 'package:quizzy_app/view_model/utils/theme/theme_view_model.dart';

class CustomCircleSumOfPointInformation extends StatelessWidget {
  final String sumOfPoint;
  const CustomCircleSumOfPointInformation(
      {super.key, required this.sumOfPoint});

  @override
  Widget build(BuildContext context) {
    final color = Get.find<ThemeViewMode>().isDarkMode()
        ? GeneralUtils.instance.convertColorToDark(const Color(0xff268C6D))
        : const Color(0xff268C6D);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: REdgeInsets.only(bottom: 35),
          decoration: BoxDecoration(
            // rgba(255, 255, 255, 0.25)

            border: Border.all(
                color:
                    // strokeAlign: ,
                    Get.find<ThemeViewMode>().isDarkMode()
                        ? GeneralUtils.instance.convertColorToDark(
                            const Color.fromRGBO(255, 255, 255, 0.25))
                        : const Color.fromRGBO(255, 255, 255, 0.25),
                width: 20.r),
            shape: BoxShape.circle,
          ),
          child: Container(
            width: 150.r,
            height: 150.r,
            decoration: BoxDecoration(
                // rgba(255, 255, 255, 0.25)
                border: Border.all(
                    color: Get.find<ThemeViewMode>().isDarkMode()
                        ? GeneralUtils.instance.convertColorToDark(
                            const Color.fromRGBO(0, 167, 50, 0.20))
                        : const Color.fromRGBO(0, 167, 50, 0.20),
                    width: 15.r),
                shape: BoxShape.circle,
                color: Get.find<ThemeViewMode>().isDarkMode()
                    ? GeneralUtils.instance.convertColorToDark(
                        const Color.fromRGBO(255, 255, 255, 1))
                    : const Color.fromRGBO(255, 255, 255, 1)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: 'مجموع نقاطك',
                  fontFamily: 'Cairo',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  alignment: Alignment.center,
                  textAlign: TextAlign.center,
                  color: color,
                ),
                CustomText(
                  text: '$sumOfPoint pt',
                  fontFamily: 'DMSans',
                  fontSize: sumOfPoint.length > 3 ? 16.sp : 32.sp,
                  fontWeight: FontWeight.w700,
                  color: color,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
