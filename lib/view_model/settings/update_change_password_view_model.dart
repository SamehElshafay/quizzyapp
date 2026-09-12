import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/Service/api/repository/profile_repository.dart';
import 'package:quizzy_app/Service/api/repository_implementaion_service/profile_repository_service.dart';
import 'package:quizzy_app/Service/local/cache_user_service.dart';
import 'package:quizzy_app/model/user_model.dart';
import 'package:quizzy_app/utils/dialog_helper.dart';

import 'package:quizzy_app/utils/form_validator.dart';
import 'package:quizzy_app/utils/snack_bar_helper.dart';

class UpdateChangePasswordViewModel extends GetxController {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late User _user;

  TextEditingController get passwordController => _passwordController;
  TextEditingController get passwordConfirmController =>
      _passwordConfirmController;
  GlobalKey<FormState> get formKey => _formKey;
  @override
  void onInit() {
    super.onInit();
    _getUserFromCahce();
  }

/////////////////////////////////////////// Validate //////////////////////////////////
  String? validatePaswword({String? value}) {
    return FormValidator.instance.passwordValidator(value!.trim());
  }

  String? confirmPasswordValidator({String? value}) {
    return FormValidator.instance.confirmPasswordValidator(
        _passwordConfirmController.text.trim(),
        _passwordController.text.trim());
  }

  void changePassword() {
    if (formKey.currentState!.validate()) {
      changePasswordService();
    }
  }

////////////////////////////////////////// Service ///////////////////////////////////////////
  ///
  void _getUserFromCahce() async {
    _user = CacheUserService.instance.getUser();
  }

  void changePasswordService() {
    DialogHelper.showLoading(
        message: 'جاري تغيير كلمة السر ', textDirection: TextDirection.rtl);
    PofileRepositoryService()
        .updateProfile(
            password: _passwordController.text, name: _user.name ?? "")
        .then((value) {
      DialogHelper.hideLoading();
      if (value.success!) {
        SnackBarHelper.instance.showMessage(
          message: 'تم تغيير كلمة السر بنجاح ',
          isEnglish: false,
        );
        Get.back();
      } else {
        SnackBarHelper.instance.showMessage(
          message: 'فشل في تغيير كلمة السر ',
          isEnglish: false,
        );
      }
    }).catchError((e) {
      DialogHelper.hideLoading();
      SnackBarHelper.instance.showMessage(
        message: e.toString(),
        erro: true,
        showByGetx: true,
      );
    });
  }
}
