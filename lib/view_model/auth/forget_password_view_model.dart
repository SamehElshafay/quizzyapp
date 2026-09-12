import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quizzy_app/Service/api/repository_implementaion_service/forget_password_repository_service.dart';
import 'package:quizzy_app/model/forget_password_model.dart';
import 'package:quizzy_app/model/genral_response_mode.dart';
import 'package:quizzy_app/utils/dialog_helper.dart';

import 'package:quizzy_app/utils/form_validator.dart';

import 'package:quizzy_app/utils/routes.dart';
import 'package:quizzy_app/utils/snack_bar_helper.dart';
import 'package:quizzy_app/view_model/auth/identify_email_view_model.dart';

import '../../utils/validation.dart';

class ForgetPasswordViewModel extends GetxController {
  String initForgetPassword = "";
  String emailOrPhoneValue = "";
  String currentVerifyCode = "";
  GlobalKey<FormState> forgetPasswordformKey = GlobalKey<FormState>();

  GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();

  TextEditingController emailOrPhoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  void setVerifyCode({required String code}) {
    currentVerifyCode = code;
  }

  void send() async {
    print(emailOrPhoneController.text);

    if (forgetPasswordformKey.currentState!.validate()) {
      DialogHelper.showLoading(
          message: "يتم الإرسال .....", textDirection: TextDirection.rtl);

      emailOrPhoneValue = emailOrPhoneController.text.trim();
      if (Validation.instance.isEmail(email: emailOrPhoneValue)) {
        await _forgetPasswordByEmail();
      } else {
        await _forgetPasswordByPhone();
      }
    }
  }

  Future<void> _forgetPasswordByEmail() async {
    try {
      ForgetPasswordModel forgetPasswordModel =
          await ForgetPasswordRepositoryService()
              .forgetPassword(email: emailOrPhoneValue);

      if (forgetPasswordModel.success!) {
        DialogHelper.hideLoading();
        Get.toNamed(Routes.identifyEmailview,
            arguments: emailOrPhoneController.text.trim());
      } else {
        SnackBarHelper.instance
            .showMessage(message: forgetPasswordModel.message!, erro: true);
      }
    } catch (e, s) {
      debugPrint(s.toString());
      SnackBarHelper.instance.showMessage(message: e.toString(), erro: true);
    } finally {
      DialogHelper.hideLoading();
    }
  }

  Future<void> _forgetPasswordByPhone() async {
    try {
      String phone = "+972${emailOrPhoneController.text.trim().substring(1)}";
      ForgetPasswordModel forgetPasswordModel =
          await ForgetPasswordRepositoryService().forgetPassword(email: phone);

      if (forgetPasswordModel.success!) {
        DialogHelper.hideLoading();
        Get.toNamed(Routes.identifyPhoneview, arguments: phone);
      } else {
        SnackBarHelper.instance
            .showMessage(message: forgetPasswordModel.message!, erro: true);
      }
    } catch (e, s) {
      debugPrint(s.toString());
      SnackBarHelper.instance.showMessage(message: e.toString(), erro: true);
    } finally {
      DialogHelper.hideLoading();
    }
  }

  Future<void> resetPasswordService({
    required String emailOrPhone,
    required String code,
    required String password,
    required String passwordConfirmation,
    required String routes,
  }) async {
    try {
      GeneralResponseModel forgetPasswordModel =
          await ForgetPasswordRepositoryService().resetpassword(
              email: emailOrPhone,
              code: code,
              password: password,
              passwordConfirmation: passwordConfirmation);

      if (forgetPasswordModel.success!) {
        SnackBarHelper.instance
            .showMessage(message: forgetPasswordModel.message!);
        Get.toNamed(routes);
      } else {
        SnackBarHelper.instance
            .showMessage(message: forgetPasswordModel.message!, erro: true);
      }
    } catch (e) {
      SnackBarHelper.instance.showMessage(message: e.toString(), erro: true);
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  String? validatePhoneOrEmail({String? value}) {
    return FormValidator.instance.validatePhoneOrEmail(value!.trim());
  }

  String? validatePaswword({String? value}) {
    return FormValidator.instance.passwordValidator(value);
  }
  // confirmPasswordValidator

  String? confirmPasswordValidator({String? value}) {
    return FormValidator.instance.confirmPasswordValidator(
        passwordConfirmController.text.trim(), passwordController.text.trim());
  }

  Future<void> changePassword() async {
    String value = emailOrPhoneValue.trim();
    if (changePasswordFormKey.currentState!.validate()) {
      await resetPasswordService(
          routes: Routes.sucessPasswordChanged,
          password: passwordController.text.trim(),
          emailOrPhone:
              Validation.instance.isContacts(contact: emailOrPhoneValue.trim())
                  ? "+972${value.substring(1)}"
                  : emailOrPhoneValue.trim(),
          code: currentVerifyCode,
          passwordConfirmation: passwordConfirmController.text.trim());
    }
  }
}
