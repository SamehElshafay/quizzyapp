import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_text.dart';

class CustomClassification extends StatelessWidget {
  final String text;
  const CustomClassification({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 93.w,
      height: 26.h,
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff268C6D), width: 2),
        borderRadius: BorderRadius.circular(12).r,
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: CustomText(
          text: text,
          fontFamily: "Cairo",
          fontWeight: FontWeight.w400,
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
