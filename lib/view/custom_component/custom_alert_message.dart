import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quizzy_app/view/custom_component/custom_text.dart';

class CustomAlertMessage extends StatelessWidget {
  final String text;
  const CustomAlertMessage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomText(
        text: text,
        fontFamily: "Cairo",
        fontWeight: FontWeight.w800,
        fontSize: 18.sp,
        color: const Color(0xffC6C6C6),
        textAlign: TextAlign.end,
      ),
    );
  }
}
