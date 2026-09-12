import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../custom_text.dart';

class CustomSourcePhotoInBottomSheet extends StatelessWidget {
  final String assetIamge;
  final String text;
  final Color color;

  final void Function()? onTap;

  const CustomSourcePhotoInBottomSheet(
      {super.key,
      required this.assetIamge,
      required this.onTap,
      required this.text,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: color, // rgba(255, 246, 171, 0.53)
            borderRadius: BorderRadius.circular(15.r)),
        width: 131.w,
        height: 134.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              assetIamge,
              cacheHeight: 40,
              cacheWidth: 40,
            ),
            10.verticalSpace,
            CustomText(
              text: text,
              textAlign: TextAlign.center,
              fontSize: 16.sp,
              fontFamily: "Cairo",
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}
