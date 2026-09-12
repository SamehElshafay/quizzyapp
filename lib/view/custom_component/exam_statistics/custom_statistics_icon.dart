//DMSans

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quizzy_app/view/custom_component/custom_text.dart';

class CustomStatisticsIcon extends StatelessWidget {
  final Color? color;
  final String text;
  final String iconAssetPath;
  final int cacheHeight;
  final int cacheWidth;
  final void Function()? onTap;
  const CustomStatisticsIcon(
      {super.key,
      this.color,
      required this.text,
      required this.iconAssetPath,
      required this.cacheHeight,
      this.onTap,
      required this.cacheWidth});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            child: Image.asset(
              iconAssetPath,
              cacheHeight: cacheHeight,
              cacheWidth: cacheWidth,
            ),
          ),
          5.verticalSpace,
          CustomText(
            text: text,
            fontFamily: "Cairo",
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
          )
        ],
      ),
    );
  }
}
