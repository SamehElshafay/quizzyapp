import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/utils/constant.dart';
import 'package:quizzy_app/view/custom_component/custom_text.dart';
import 'package:quizzy_app/view/custom_component/custom_text_form_field.dart';
import 'package:quizzy_app/view_model/settings/balance_view_model.dart';

class CustomDialogBalance extends StatelessWidget {
  const CustomDialogBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BalanceViewModel>(
      builder: (controller) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          title: Container(
            padding: REdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8).r,
              color: primayColor,
            ),
            width: double.infinity,
            child: CustomText(
              text: "ادخل الكوبون",
              // textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              fontSize: 20.sp,
              fontFamily: "Cairo",
              color: Colors.white,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: controller.formKey,
                  child: CustomTextFormField(
                    // icon: Icons.wallet_giftcard,
                    icon: Icons.qr_code_scanner,

                    onPressedIconSuffic: () {
                      controller.showScanBarCode(
                          routeNameOfDialog: Get.currentRoute);
                    },
                    controller: controller.textEditingController,
                    textDirection: TextDirection.ltr,
                    validator: (value) =>
                        controller.validateBalanceController(value),
                  ),
                )
              ],
            ),
          ),
          actions: [
            TextButton(
                style: TextButton.styleFrom(backgroundColor: erroColor),
                onPressed: () => controller.cancel(),
                child: CustomText(
                  text: "إلغاء",
                  color: Colors.white,
                  fontSize: 13.sp,
                )),
            TextButton(
                style: TextButton.styleFrom(backgroundColor: primayColor),
                onPressed: () => controller.submit(),
                child: CustomText(
                  text: "تأكيد",
                  color: Colors.white,
                  fontSize: 13.sp,
                ))
          ],
        );
      },
    );
  }
}
