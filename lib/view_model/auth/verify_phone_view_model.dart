import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:quizzy_app/Service/api/repository_implementaion_service/phone_repository_service.dart';
import 'package:quizzy_app/Service/local/auth_route_service.dart';
import 'package:quizzy_app/model/genral_response_mode.dart';
import 'package:quizzy_app/model/resend_verify_email_model.dart';
import 'package:quizzy_app/utils/dialog_helper.dart';
import 'package:quizzy_app/utils/routes.dart';
import 'package:quizzy_app/utils/snack_bar_helper.dart';
import 'package:quizzy_app/view_model/utils/theme/theme_view_model.dart';

class VerifyPhoneViewModel extends GetxController {
  String initVerifyEmailViewModel = "";
  int length = 6;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController pinController = TextEditingController();
  GlobalKey<FormState> verifyFormKey = GlobalKey<FormState>();

  final focusNode = FocusNode();
  late String _phone;
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
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    print("Veify Phone Page");
    _phone = Get.arguments; // to get the Phone Number

    await reSendCode();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    pinController.dispose();
    focusNode.dispose();
  }

  void confirmPhone() async {
    focusNode.unfocus();
    if (verifyFormKey.currentState!.validate()) {
      await verifyCode(phone: _phone, code: pinController.text);
    }
  }

  String? validatePinCode(String? value) {
    return value == null || value.isEmpty || value.length < length
        ? "هذا الكود خطأ"
        : null;
  }

  String get phone => _phone;

  //////////////////////////////////////// Api Service ///////////////////////////////////////////////////////////////////////////

  Future<void> verifyCode({required String phone, required String code}) async {
    try {
      DialogHelper.showLoading(
          message: 'يتم تأكيد الهاتف ......', textDirection: TextDirection.rtl);
      GeneralResponseModel generalResponseModel = await PhoneRepositoryService()
          .verifyPhoneCode(phone: phone, code: code);

      if (generalResponseModel.success!) {
        SnackBarHelper.instance
            .showMessage(message: generalResponseModel.message!);

        await AuthRouteService.instance.logIn(); // to Make a LogIn
        Get.offAllNamed(Routes.bottomNavgation);
      } else {
        SnackBarHelper.instance
            .showMessage(message: generalResponseModel.message!, erro: true);
      }
    } catch (e) {
      SnackBarHelper.instance.showMessage(message: e.toString(), erro: true);
    } finally {
      DialogHelper.hideLoading();
    }
  }

  Future<void> reSendCode() async {
    try {
      pinController.text = "";
      ReSendVeifyModel reSendVerifyPhone =
          await PhoneRepositoryService().reSendVerifyPhone(phone: phone);

      if (reSendVerifyPhone.success!) {
        SnackBarHelper.instance
            .showMessage(message: reSendVerifyPhone.message!);
      } else {
        SnackBarHelper.instance
            .showMessage(message: reSendVerifyPhone.message!, erro: true);
      }
    } catch (e) {
      SnackBarHelper.instance.showMessage(message: e.toString(), erro: true);
    }
  }
}
