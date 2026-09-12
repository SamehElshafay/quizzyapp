import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/view/custom_component/custom_button.dart';
import 'package:pinput/pinput.dart';
import 'package:quizzy_app/view_model/auth/verify_phone_view_model.dart';
import '../../custom_component/custom_text.dart';

class VerifyPhoneView extends GetView<VerifyPhoneViewModel> {
  const VerifyPhoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.h),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              50.verticalSpace,
              Center(
                child: CustomText(
                  text: "تاكيد رقم الهاتف",
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.w500,
                  fontSize: 20.sp,
                  color: Color(0xff077C58),
                ),
              ),
              50.verticalSpace,
              CustomText(
                text: "لقد ارسلنا كود التأكيد علي هذا الرقم",
                fontFamily: "Segoe",
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                //  color: Color.fromRGBO(0, 0, 0, 0.7),
              ),
              CustomText(
                maxLines: 1,
                text: controller.phone,
                fontFamily: "Segoe",
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                //  color: Color.fromRGBO(0, 0, 0, 0.7),
              ),
              30.verticalSpace,
              Form(
                key: controller.verifyFormKey,
                child: Pinput(
                  controller: controller.pinController,
                  focusNode: controller.focusNode,
                  length: controller.length,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    return controller.validatePinCode(value);
                  },
                  errorPinTheme: controller.defaultPinTheme.copyWith(
                      decoration: controller.defaultPinTheme.decoration!
                          .copyWith(
                              border: Border.all(color: Colors.redAccent))),
                  defaultPinTheme: controller.defaultPinTheme,
                  focusedPinTheme: controller.defaultPinTheme.copyWith(
                      decoration: controller.defaultPinTheme.decoration!
                          .copyWith(
                              border:
                                  Border.all(color: const Color(0xff268C6D)))),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "لم يصل لي الكود",
                    fontFamily: "inter",
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    //  color: Color.fromRGBO(0, 0, 0, 0.7),
                  ),
                  5.horizontalSpace,
                  TextButton(
                    onPressed: () async {
                      await controller.reSendCode();
                    },
                    child: CustomText(
                        text: "اعادة الارسال",
                        fontFamily: "inter",
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        color: Color(0xff268C6D)),
                  ),
                ],
              ),
              30.verticalSpace,
              CustomButton(
                text: "تأكيد",
                onTap: () {
                  controller.confirmPhone();
                },
                fontFamily: "inter",
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              )
            ])));
  }
}
