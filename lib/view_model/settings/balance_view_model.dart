import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:pinput/pinput.dart';

import 'package:quizzy_app/Service/api/repository_implementaion_service/profile_repository_service.dart';
import 'package:quizzy_app/model/user_model.dart';
import 'package:quizzy_app/utils/dialogs/custom_dialog_balance_widget.dart';
import 'package:quizzy_app/utils/end_point.dart';
import 'package:quizzy_app/utils/routes.dart';
import 'package:quizzy_app/utils/snack_bar_helper.dart';
import 'package:quizzy_app/view_model/settings/settings_view_model.dart';

class BalanceViewModel extends GetxController {
  late User _user;
  TextEditingController _textEditingController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController get textEditingController => _textEditingController;
  GlobalKey<FormState> get formKey => _formKey;
  bool _isLoadBalanceView = false;

  String _routeNameOfDialog = "dfs";

  int get balance => _user.balance ?? 0;
  String get routeNameOfDialog => _routeNameOfDialog;
  bool get isLoadBalanceView => _isLoadBalanceView;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    _getProfileService();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    _textEditingController.dispose();
  }

  ///////////////////////////////// Service ////////////////////////////////////////
  ///

  void showScanBarCode({required String routeNameOfDialog}) {
    _routeNameOfDialog = routeNameOfDialog;
    Get.toNamed(Routes.cameraScanCodeView);

    print(EndPoint.terms);
    print(EndPoint.privacyPolicy);
  }

  Future<void> rechargeAccount({required String code}) async {
    await PofileRepositoryService().rechargeAccount(code: code).then((value) {
      if (value.success!) {
        updateCache(value.data!);
        SnackBarHelper.instance.showMessage(
          isEnglish: false,
          message: value.message!,
        );
        update(['updateBalance']);
      } else {
        SnackBarHelper.instance.showMessage(
          erro: true,
          isEnglish: false,
          message: value.message!,
        );
      }
    });
  }

  void _getProfileService() {
    PofileRepositoryService().getProfile().then((value) async {
      _user = value.data!;
      _isLoadBalanceView = true;
      updateCache(_user);
      update(['updateLoadBalanceView']);
    });
  }

  void updateCache(User userValue) async {
    _user = userValue;
    await Get.find<SettingsViewModel>().updateUserCache(userValue: userValue);
  }

///////////////////////////////////////////////////////////////////////////////////////

  String? validateBalanceController(String? value) {
    if (value == null || value.isEmpty) {
      return "يرجي ادخال الكوبون";
    } else {
      return null;
    }
  }

  void showAlertDialog(BuildContext context) async {
    _textEditingController.clear(); // at the End

    await Get.dialog(const CustomDialogBalance(),
        routeSettings: const RouteSettings(name: "dialogBalance"));
  }

  void cancel() {
    Get.back();
  }

  void submit() async {
    if (formKey.currentState!.validate()) {
      rechargeAccount(code: _textEditingController.text.trim());
      cancel();
    }
  }
}
