import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:quizzy_app/view_model/settings/camera_scan_code_view_model.dart';

class CameraScanCodeView extends GetView<CameraScanCodeViewModel> {
  const CameraScanCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CameraScanCodeViewModel>(
      init: CameraScanCodeViewModel(),
      builder: (controller) {
        return MobileScanner(
            controller: controller.mobileScannerController,
            onDetect: (capture) {
              print("-" * 50);
              print("Detected");
              print("-" * 50);
              controller.barCodeCapture(capture, context);
            });
      },
    );
  }
}
