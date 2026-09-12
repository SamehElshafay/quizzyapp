import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/view/custom_component/custom_button.dart';
import 'package:quizzy_app/view/custom_component/custom_text.dart';
import 'package:quizzy_app/view/custom_component/custom_text_form_field.dart';
import 'package:quizzy_app/view_model/settings/update_change_password_view_model.dart';

class UpdateChangePasswordView extends GetView<UpdateChangePasswordViewModel> {
  const UpdateChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: CustomText(
          text: 'تغيير كلمة السر',
          fontFamily: "Cairo",
          fontWeight: FontWeight.w500,
          fontSize: 12.sp,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                150.verticalSpace,
                CustomText(
                  text: 'كلمة السر الجديدة',
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  color: const Color(0xff4996BF),
                  alignment: AlignmentDirectional.topEnd,
                ),
                15.verticalSpace,
                SizedBox(
                  width: double.infinity.w,
                  height: null,
                  child: CustomTextFormField(
                    icon: null,
                    height: null,
                    // height: 50.h,
                    textAlignVertical: TextAlignVertical.center,
                    colorInitally: const Color(0xff4996BF),
                    colorFocus: const Color(0xff4996BF),
                    textDirection: TextDirection.ltr,
                    validator: (value) =>
                        controller.validatePaswword(value: value),
                    controller: controller.passwordController,
                    eyes: true,
                    obscureText: true,
                  ),
                ),
                30.verticalSpace,
                CustomText(
                  text: 'تأكيد كلمة السر',
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  color: const Color(0xff4996BF),
                  alignment: AlignmentDirectional.topEnd,
                ),
                15.verticalSpace,
                SizedBox(
                  width: double.infinity.w,
                  height: null,
                  child: CustomTextFormField(
                    icon: null,
                    // height: 50.h,
                    height: null,
                    textDirection: TextDirection.ltr,
                    textAlignVertical: TextAlignVertical.center,
                    colorInitally: const Color(0xff4996BF),
                    colorFocus: const Color(0xff4996BF),
                    validator: (value) =>
                        controller.confirmPasswordValidator(value: value),
                    controller: controller.passwordConfirmController,
                    eyes: true,
                    obscureText: true,
                  ),
                ),
                80.verticalSpace,
                SizedBox(
                  width: ScreenUtil().screenWidth * 0.70,
                  child: CustomButton(
                      text: 'تغيير كلمة السر',
                      fontFamily: 'inter',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      onTap: () {
                        controller.changePassword();
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
