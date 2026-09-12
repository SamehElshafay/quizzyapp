import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:quizzy_app/view_model/auth/forget_password_view_model.dart';

import '../../custom_component/custom_button.dart';
import '../../custom_component/custom_text.dart';
import '../../custom_component/custom_text_form_field.dart';

class ChangePasswordView extends GetView<ForgetPasswordViewModel> {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.h),
              child: Form(
                key: controller.changePasswordFormKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      100.verticalSpace,
                      Center(
                        child: CustomText(
                          text: "استعادة كلمة المرور",
                          fontFamily: "Segoe",
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          color: Color(0xff077C58),
                          alignment: AlignmentDirectional.topEnd,
                        ),
                      ),
                      20.verticalSpace,
                      CustomText(
                        text: "كلمة السر الجديدة",
                        fontFamily: "Segoe",
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                        color: Color(0xff077C58),
                        alignment: AlignmentDirectional.topEnd,
                      ),
                      3.verticalSpace,
                      SizedBox(
                        width: double.infinity.w,
                        child: CustomTextFormField(
                          icon: null,
                          eyes: true,
                          obscureText: true,
                          controller: controller.passwordController,
                          textAlignVertical: TextAlignVertical.center,
                          textDirection: TextDirection.ltr,
                          validator: (value) =>
                              controller.validatePaswword(value: value),
                        ),
                      ),
                      20.verticalSpace,
                      CustomText(
                        text: "تأكيد كلمة السر",
                        fontFamily: "Segoe",
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                        color: Color(0xff077C58),
                        alignment: AlignmentDirectional.topEnd,
                      ),
                      3.verticalSpace,
                      SizedBox(
                        width: double.infinity.w,
                        child: CustomTextFormField(
                          icon: null,
                          eyes: true,
                          obscureText: true,
                          textAlignVertical: TextAlignVertical.center,
                          controller: controller.passwordConfirmController,
                          textDirection: TextDirection.ltr,
                          validator: (value) =>
                              controller.confirmPasswordValidator(value: value),
                        ),
                      ),
                      40.verticalSpace,
                      CustomButton(
                        text: "تغير كلمة السر",
                        fontFamily: "Poppins",
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        onTap: () async {
                          await controller.changePassword();
                        },
                      ),
                      40.verticalSpace,
                    ]),
              )),
        ));
  }
}
