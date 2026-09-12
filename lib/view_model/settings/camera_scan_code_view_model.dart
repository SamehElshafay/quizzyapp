import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pinput/pinput.dart';
import 'package:quizzy_app/utils/routes.dart';
import 'package:quizzy_app/view_model/settings/balance_view_model.dart';

class CameraScanCodeViewModel extends GetxController {
  late MobileScannerController _mobileScannerController;

  MobileScannerController get mobileScannerController =>
      _mobileScannerController;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _mobileScannerController = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
    );
  }

  void barCodeCapture(BarcodeCapture capture, BuildContext context) async {
    if (capture.barcodes.isNotEmpty) {
      String value = capture.barcodes.first.rawValue!;

      Get.find<BalanceViewModel>().textEditingController.setText(value);
      Navigator.popUntil(
          context, (route) => Get.currentRoute == 'dialogBalance');

      // Get.back();
      // await Future.delayed(Duration(seconds: 50));
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose

    _mobileScannerController.dispose();
    super.onClose();
  }
}
