import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_images.dart';
import 'custom_text.dart';

class CustomMessage extends StatelessWidget {
  final bool isRecievedMessage;
  final int numMessage;
  const CustomMessage(
      {super.key, this.isRecievedMessage = false, this.numMessage = 1});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      width: double.infinity,
      padding: EdgeInsets.all(5).r,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14).r,
          border: Border.all(width: 2, color: const Color(0xff9ADFEF))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4).h,
            child: Column(
              children: [
                CustomText(
                  text: "15:32",
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400,
                  fontSize: 11.sp,
                  alignment: AlignmentDirectional.topStart,
                ),
                !isRecievedMessage
                    ? const SizedBox()
                    : Container(
                        width: 27.w,
                        height: 27.h,
                        alignment: AlignmentDirectional.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xff268C6D)),
                        child: CustomText(
                          text: "$numMessage",
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    text: "محمد محمود",
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                  Row(
                    children: [
                      CustomText(
                        text: "مرحبا كيف أحوالك اليوم",
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        fontSize: 13.sp,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2).h,
                        child: Image.asset(
                          isRecievedMessage
                              ? Assets.imagesRecievemessage
                              : Assets.imagesSendmessage,
                          cacheHeight: 15,
                          cacheWidth: 15,
                        ),
                      )
                    ],
                  )
                ],
              ),
              2.horizontalSpace,
              Container(
                width: 46.w,
                height: 50.h,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xffD9D9D9)),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(Assets.imagesStudent))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
