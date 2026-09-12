//DMSans

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quizzy_app/view/custom_component/custom_text.dart';

class CustomStatisticsText extends StatelessWidget {
  final Color? color;
  final String text;
  final String numbertext;

  const CustomStatisticsText(
      {super.key, this.color, required this.text, required this.numbertext});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            CustomText(
              text: numbertext,
              fontFamily: "DMSans",
              fontWeight: FontWeight.w500,
              color: color,
              fontSize: 20.sp,
            ),
            5.horizontalSpace,
            Container(
              width: 12.r,
              height: 12.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
            ),
          ],
        ),
        CustomText(
          text: text,
          fontFamily: "DMSans",
          fontWeight: FontWeight.w400,
          fontSize: 16.sp,
        )
      ],
    );
  }
}
