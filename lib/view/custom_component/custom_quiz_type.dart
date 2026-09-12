import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quizzy_app/utils/app_images.dart';
import 'custom_text.dart';

class CustomQuizType extends StatelessWidget {
  final String name;
  final String imageAssetName;
  final Color color;
  final bool isShowArrow;
  final void Function()? onTap;

  const CustomQuizType(
      {super.key,
      required this.imageAssetName,
      required this.name,
      this.isShowArrow = true,
      this.onTap,
      this.color = const Color(0xffFC9A9A)});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 110.w,
        height: 140.h,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(17).r,
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  blurRadius: 5,
                  offset: const Offset(0, 4))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 15.w, top: 10.h),
              child: CustomText(
                text: name,
                fontFamily: "Cairo",
                fontWeight: FontWeight.w800,
                fontSize: 12.sp,
                color: Colors.white,
                textAlign: TextAlign.end,
              ),
            ),
            2.verticalSpace,
            !isShowArrow
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Image.asset(
                      Assets.imagesNextArrow,
                      cacheHeight: 24,
                      cacheWidth: 24,
                      color: Colors.white,
                    ),
                  ),
            Expanded(
                child: Image.asset(
              imageAssetName,
              width: double.infinity,
              fit: BoxFit.fitHeight,
            ))
          ],
        ),
      ),
    );
  }
}
// custom_quiz_type
//custom_subject.dart
