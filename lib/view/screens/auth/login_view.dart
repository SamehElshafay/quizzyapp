import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/Service/local/cache_settings_service.dart';
import 'package:quizzy_app/utils/app_images.dart';
import 'package:quizzy_app/utils/constant.dart';
import 'package:quizzy_app/utils/general_utils.dart';
import 'package:quizzy_app/utils/snack_bar_helper.dart';
import 'package:quizzy_app/view/custom_component/custom_text_form_field.dart';
import 'package:quizzy_app/utils/phone_or_email_formatter.dart';
import 'package:quizzy_app/view_model/auth/login_view_model.dart';
import 'package:quizzy_app/view_model/utils/theme/theme_view_model.dart';

import '../../custom_component/custom_button.dart';
import '../../custom_component/custom_text.dart';

class LoginView extends GetView<LoginViewModel> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          controller.contactUsRoute();
        },
        child: Container(
          padding: REdgeInsets.symmetric(horizontal: 6, vertical: 4),
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(12).r),
          child: CustomText(
            text: "اتصل بنا",
            fontFamily: "Segoe",
            fontWeight: FontWeight.w600,
            fontSize: 10.sp,
            color: Colors.white,
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.h),
        child: SingleChildScrollView(
          child: Form(
            key: controller.loginFormKey,
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    Assets.imagesLogoImage,
                    cacheHeight: 132,
                    cacheWidth: 132,
                  ),
                ),
                CustomText(
                  text: "اهلا بعودتك عزيزي الطالب",
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.w400,
                  fontSize: 18.sp,
                  color: Color(0xff077C58),
                ),
                CustomText(
                  text: "${controller.initViewModel}من فضلك سجل الدخول",
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.w400,
                  fontSize: 18.sp,
                  color: Color(0xff077C58),
                ),
                40.verticalSpace,
                // Text(controller.initViewModel),
                CustomText(
                  text: "رقم الهاتف أو البريد الإلكتروني",
                  fontFamily: "Segoe",
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                  color: Color(0xff077C58),
                  alignment: AlignmentDirectional.topEnd,
                ),
                5.verticalSpace,
                SizedBox(
                  //  height: 52.h,
                  width: double.infinity.w,
                  child: CustomTextFormField(
                    icon: Icons.person,
                    hintText: "من فضلك ادخل رقم هاتفك أو الإيميل",
                    textAlignVertical: TextAlignVertical.center,
                    textDirection: TextDirection.ltr,
                    iconColor: Color(0xff268C6D),
                    validator: (value) =>
                        controller.validatePhoneOrEmail(value: value),
                    controller: controller.emailOrPhoneController,
                    inputFormatters: [PhoneOrEmailFormatter()],
                  ),
                ),
                20.verticalSpace,
                CustomText(
                  text: "كلمة السر",
                  fontFamily: "Segoe",
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                  color: Color(0xff077C58),
                  alignment: AlignmentDirectional.topEnd,
                ),
                5.verticalSpace,
                SizedBox(
                  // height: 52.h,
                  width: double.infinity.w,
                  child: CustomTextFormField(
                    icon: null,
                    eyes: true,
                    textDirection: TextDirection.ltr,
                    obscureText: true,
                    validator: (value) =>
                        controller.validatePasword(value: value),
                    controller: controller.passwordController,
                    textAlignVertical: TextAlignVertical.center,
                  ),
                ),
                5.verticalSpace,
                TextButton(
                  onPressed: () {
                    controller.forgetPassword();
                  },
                  child: CustomText(
                    text: "نسيت كلمة السر؟",
                    fontFamily: "Segoe",
                    fontWeight: FontWeight.w700,
                    fontSize: 12.sp,
                    color: Get.find<ThemeViewMode>().isDarkMode()
                        ? Colors.white38
                        : const Color(0xff414141),
                    alignment: AlignmentDirectional.topEnd,
                  ),
                ),
                25.verticalSpace,
                CustomButton(
                  text: "تسجيل الدخول",
                  fontFamily: "Poppins",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  onTap: () {
                    controller.loginButton();
                  },
                ),
                25.verticalSpace,
                CustomButton(
                  text: "المتابعة كزائر",
                  fontFamily: "Poppins",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  colorOfContainer: Colors.grey,
                  onTap: () {
                    controller.guestLoginButton();
                  },
                ),
                15.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        controller.createAccount();
                        print("إنشاء حساب");
                      },
                      child: CustomText(
                        text: " انشاء حساب",
                        fontFamily: "Segoe",
                        fontWeight: FontWeight.w600,
                        fontSize: 10.sp,
                        color: Color(0xff178462),
                        alignment: AlignmentDirectional.topEnd,
                      ),
                    ),
                    3.horizontalSpace,
                    CustomText(
                      text: "ليس لديك حساب بالفعل؟",
                      fontFamily: "Segoe",
                      fontWeight: FontWeight.w600,
                      fontSize: 10.sp,
                      color: Get.find<ThemeViewMode>().isDarkMode()
                          ? Colors.white38
                          : const Color(0xff414141),
                      alignment: AlignmentDirectional.topEnd,
                    ),
                  ],
                ),
                15.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
