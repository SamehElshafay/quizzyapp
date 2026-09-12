import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/view/custom_component/custom_circular_progress_indicator.dart';
import 'package:quizzy_app/view/custom_component/custom_text.dart';

class DialogHelper {
  DialogHelper._();
  static void showLoading(
      {String? message = 'Loading...',
      TextDirection? textDirection = TextDirection.ltr,
      Widget? widget}) {
    Get.dialog(
        Dialog(
          child: Padding(
            padding: REdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                widget ?? const CustomCircularProgressIndicator(),
                8.verticalSpace,
                CustomText(
                  text: message!,
                  textDirection: textDirection,
                )
              ],
            ),
          ),
        ),
        barrierDismissible: false);
  }

  static void hideLoading() {
    if (Get.isDialogOpen != null && Get.isDialogOpen!) {
      Get.back();
    }
  }
}
