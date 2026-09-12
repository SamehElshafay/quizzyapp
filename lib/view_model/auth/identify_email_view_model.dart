import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:pinput/pinput.dart';
import 'package:quizzy_app/Service/api/repository_implementaion_service/email_repository_service.dart';
import 'package:quizzy_app/Service/api/repository_implementaion_service/forget_password_repository_service.dart';
import 'package:quizzy_app/model/genral_response_mode.dart';
import 'package:quizzy_app/model/resend_verify_email_model.dart';
import 'package:quizzy_app/utils/dialog_helper.dart';
import 'package:quizzy_app/utils/routes.dart';
import 'package:quizzy_app/utils/snack_bar_helper.dart';
import 'package:quizzy_app/view_model/auth/forget_password_view_model.dart';
import 'package:quizzy_app/view_model/utils/theme/theme_view_model.dart';

class IdentifyEmailViewModel extends GetxController {
  late String email;
  int length = 6;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController pinController = TextEditingController();
  GlobalKey<FormState> identifyformKey = GlobalKey<FormState>();

  final focusNode = FocusNode();

  final defaultPinTheme = PinTheme(
    width: 56.w,
    height: 56.h,
    textStyle: TextStyle(
      fontSize: 22.sp,
      color: Get.find<ThemeViewMode>().isDarkMode()
          ? Colors.white
          : const Color.fromRGBO(30, 60, 87, 1),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12).r,
      border: Border.all(color: Color.fromRGBO(23, 171, 144, 0.4)),
    ),
  );

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments;
    print("Veify IdentifyEmailViewModel Page");
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    pinController.dispose();
    focusNode.dispose();
  }

  Future<void> confirmEmail() async {
    focusNode.unfocus();
    if (identifyformKey.currentState!.validate()) {
      DialogHelper.showLoading(
          message: "يتم التأكد من البريد الإلكتروني .....",
          textDirection: TextDirection.rtl);
      try {
        await verifyCode(email: email, code: pinController.text);
      } catch (e, s) {
        debugPrint(s.toString());
        SnackBarHelper.instance.showMessage(message: e.toString(), erro: true);
      } finally {
        DialogHelper.hideLoading();
      }
    }
  }

  String? validatePinCode(String? value) {
    return value == null || value.isEmpty || value.length < length
        ? "هذا الكود خطأ"
        : null;
  }

  ////////////////Api Service////////

  Future<void> verifyCode({required String email, required String code}) async {
    try {
      GeneralResponseModel generalResponseModel =
          await ForgetPasswordRepositoryService()
              .verifyCode(email: email, code: code);

      if (generalResponseModel.success!) {
        Get.find<ForgetPasswordViewModel>().setVerifyCode(code: code);
        DialogHelper.hideLoading();
        Get.toNamed(Routes.changePasswordView);
      } else {
        SnackBarHelper.instance
            .showMessage(message: generalResponseModel.message!, erro: true);
      }
    } catch (e, s) {
      debugPrint(s.toString());
      SnackBarHelper.instance.showMessage(message: e.toString(), erro: true);
    }
  }

  Future<void> reSendCode() async {
    try {
      pinController.clear();
      ReSendVeifyModel reSendVeifyEmailModel =
          await EmailRepositoryService().reSendVerifyEmail(email: email);

      if (reSendVeifyEmailModel.success!) {
        SnackBarHelper.instance
            .showMessage(message: reSendVeifyEmailModel.message!);
      } else {
        SnackBarHelper.instance
            .showMessage(message: reSendVeifyEmailModel.message!, erro: true);
      }
    } catch (e, s) {
      debugPrint(s.toString());
      SnackBarHelper.instance.showMessage(message: e.toString(), erro: true);
    }
  }
}
