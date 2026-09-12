// notificationView
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quizzy_app/view/custom_component/custom_text.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/view_model/settings/notification_view_model.dart';

class NotificationView extends GetView<NotificationViewModel> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            CustomText(text: "NotificationView"),
            TextButton(
                onPressed: () {
                  controller.getToken();
                },
                child: Text("Get the Token"))
          ],
        ),
      ),
    );
  }
}
