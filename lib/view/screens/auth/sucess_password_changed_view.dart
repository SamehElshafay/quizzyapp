import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../utils/app_images.dart';
import '../../../view_model/auth/sucess_password_changed_view_model.dart';
import '../../custom_component/custom_button.dart';
import '../../custom_component/custom_text.dart';

class SucessPasswordChangedView
    extends GetView<SucessPasswordChangedViewModel> {
  const SucessPasswordChangedView({super.key});

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
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Center(
                child: Image.asset(
                  Assets.imageSucess,
                  cacheHeight: 84,
                  cacheWidth: 90,
                ),
              ),
              50.verticalSpace,
              CustomText(
                text: "تم تغيير كلمة السر",
                fontFamily: "Segoe",
                fontWeight: FontWeight.w700,
                fontSize: 30.sp,
                color: Color(0xff077C58),
              ),
              20.verticalSpace,
              CustomText(
                text: "تم تغيير كلمة السر بنجاح",
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
                fontSize: 16.sp, // rgba(0, 0, 0, 0.7)
                color: Color.fromRGBO(0, 0, 0, 0.7),
              ),
              50.verticalSpace,
              CustomButton(
                  text: 'الرجوع لتسجيل الدخول',
                  fontFamily: "inter",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  onTap: () {
                    controller.backLoginPage();
                  }),
              30.verticalSpace,
            ])));
  }
}
