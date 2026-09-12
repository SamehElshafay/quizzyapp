import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:quizzy_app/utils/app_images.dart';
import 'package:quizzy_app/view/custom_component/custom_alert_message.dart';
import 'package:quizzy_app/view/custom_component/custom_text.dart';
import 'package:quizzy_app/view_model/bottomNavigation/chat_view_model.dart';
import 'package:quizzy_app/view_model/settings/settings_view_model.dart';
import 'package:quizzy_app/view_model/utils/theme/theme_view_model.dart';

import '../../custom_component/custom_message.dart';
import '../../custom_component/custom_search_field.dart';

class ChatView extends GetView<ChatViewModel> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsViewModel>(
      id: "updatDarkMode",
      builder: (updateOnleTheme) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: CustomText(
                text: "دردش مع معلمك",
                fontFamily: "Cairo",
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
              ),
              centerTitle: true,
              leading: IconButton(
                icon: Image.asset(
                  Assets.imagesMenu,
                  color: Get.find<ThemeViewMode>().isDarkMode()
                      ? Colors.white
                      : Colors.black,
                ),
                onPressed: () {
                  Get.find<SettingsViewModel>().settingViewPageRoute();
                },
              ),
              actions: [
                IconButton(
                  icon: Image.asset(
                    Assets.imagesNotification,
                    color: Get.find<ThemeViewMode>().isDarkMode()
                        ? Colors.white
                        : Colors.black,
                  ),
                  onPressed: () {
                    Get.find<SettingsViewModel>().notificationViewPageRoute();
                    print("Ok");
                  },
                ),
              ],
            ),
            body: 20 > 12
                ? const CustomAlertMessage(text: "قريبا")
                : GetBuilder<ChatViewModel>(
                    builder: (controller) {
                      return controller.text == null
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.h),
                              child: Column(
                                children: [
                                  CustomSearchField(
                                    text: "البحث في الشات",
                                  ),
                                  25.verticalSpace,
                                  CustomText(
                                    text: "الرسائل",
                                    fontFamily: "Cairo",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20.sp,
                                    alignment: AlignmentDirectional.topEnd,
                                  ),
                                  12.verticalSpace,
                                  CustomMessage(),
                                  15.verticalSpace,
                                  CustomMessage(
                                    isRecievedMessage: true,
                                  ),
                                  15.verticalSpace,
                                  CustomMessage(
                                    isRecievedMessage: true,
                                    numMessage: 12,
                                  ),
                                ],
                              ));
                    },
                  ));
      },
    );
  }
}
