import 'dart:async';

import 'package:get/get.dart';

class ChatViewModel extends GetxController {
  String? text;
  @override
  void onInit() {
    // TODO: implement onInit
    print("init Chat Controller");
    super.onInit();
    Timer(Duration(seconds: 10), () => updateData());
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    print("close Chat Controller");
  }

  void updateData() {
    text = "Mohamed";
    update();
  }
}
