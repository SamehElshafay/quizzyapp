import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/utils/app_images.dart';
import 'package:quizzy_app/utils/constant.dart';
import 'dart:io' show Platform;

import 'package:quizzy_app/view/custom_component/custom_text.dart';
import 'package:quizzy_app/view/custom_component/settings/custom_list_tile.dart';
import 'package:quizzy_app/view/custom_component/settings/custom_top_section_of_settings_view.dart';
import 'package:quizzy_app/view_model/settings/settings_view_model.dart';

class SettingsView extends GetView<SettingsViewModel> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GetBuilder<SettingsViewModel>(
              id: "updateTopSectionOfSettingView",
              builder: (controller) {
                return CustomTopSectionOfSettingsView(
                  emailOrPhoneValue: controller.emailOrPhone,
                  name: controller.name,
                  imageUrl: controller.photo,
                );
              },
            ),
            controller.isSocialLogin ? 25.verticalSpace : 20.verticalSpace,
            RPadding(
              padding: REdgeInsets.symmetric(horizontal: 10),
              child: const Divider(),
            ),
            controller.isSocialLogin ? 20.verticalSpace : 15.verticalSpace,
            Container(
              margin: REdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  CustomText(
                    text: 'اعدادات الحساب',
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    fontFamily: "Cairo",
                    color: primayColor,
                    alignment: AlignmentDirectional.topEnd,
                  ),
                  controller.isSocialLogin
                      ? 20.verticalSpace
                      : 10.verticalSpace,
                  CustomListTile(
                    onTap: () {
                      controller.updateAccountViewRoute();
                    },
                    text: 'تعديل الحساب',
                  ),
                  controller.isSocialLogin
                      ? const SizedBox()
                      : CustomListTile(
                          onTap: () {
                            controller.updateChangePasswordViewRoute();
                          },
                          text: 'تغيير كلمة السر',
                        ),
                  Platform.isIOS && !controller.showBalance
                      ? const SizedBox()
                      : CustomListTile(
                          onTap: () {
                            controller.balanceViewRoute();
                          },
                          text: 'رصيدي',
                        ),
                  CustomListTile(
                    // imageWidget: const Icon(
                    //   Icons.wallet_giftcard,
                    // ),
                    onTap: () {
                      controller.inviteFriendDialog(context);
                    },
                    text: 'دعوة صديق',
                  ),
                  GetBuilder<SettingsViewModel>(
                    id: "updateNotification",
                    builder: (controller) {
                      return CustomListTile(
                        onTap: () {
                          controller.updateNotification();
                        },
                        text: 'الاشعارات',
                        imageWidget: Switch(
                          value: controller.isNotificationEnabled,
                          onChanged: (value) async {
                            await controller.updateNotification();
                          },
                        ),
                      );
                    },
                  ),
                  GetBuilder<SettingsViewModel>(
                    id: "updatDarkMode",
                    builder: (controller) {
                      return CustomListTile(
                        onTap: () {
                          controller.updatDarkMode();
                        },
                        text: 'الوضع الليلي',
                        imageWidget: Switch(
                          value: controller.isDarkMode,
                          onChanged: (value) async {
                            await controller.updatDarkMode();
                          },
                        ),
                      );
                    },
                  ),
                ], // تغيير كلمة السر
              ),
            ),
            controller.isSocialLogin ? 40.verticalSpace : 15.verticalSpace,
            RPadding(
              padding: REdgeInsets.symmetric(horizontal: 10),
              child: Divider(),
            ),
            Container(
              margin: REdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  controller.isSocialLogin
                      ? 20.verticalSpace
                      : 15.verticalSpace,
                  CustomText(
                    text: 'سياسة الاستخدام',
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    fontFamily: "Cairo",
                    color: primayColor,
                    alignment: AlignmentDirectional.topEnd,
                  ),
                  controller.isSocialLogin
                      ? 20.verticalSpace
                      : 10.verticalSpace,
                  CustomListTile(
                    onTap: () {
                      controller.privacyPolicyRoute();
                    },
                    text: 'سياسة الخصوصية',
                  ),
                  CustomListTile(
                    onTap: () {
                      controller.termsRoute();
                    },
                    text: 'الشروط',
                  ),
                  Platform.isIOS && !controller.showBalance
                      ? const SizedBox()
                      : CustomListTile(
                          onTap: () {
                            controller.cobonLocationRoute();
                          },
                          text: 'نقاط بيع الكابون',
                        ),
                  CustomListTile(
                    onTap: () {
                      controller.contactUsRoute();
                    },
                    text: 'اتصل بنا',
                  ),
                  Platform.isIOS && controller.showDeleteAccount
                      ? CustomListTile(
                          onTap: () async {
                            await controller.deleteAccount();
                          },
                          text: 'حذف حسابك',
                        )
                      : const SizedBox(),
                  CustomListTile(
                      onTap: () async {
                        print("OK");
                        await controller.logout();
                      },
                      text: 'تسجيل الخروج',
                      imageWidget: RPadding(
                        padding: REdgeInsets.only(left: 5),
                        child: Image.asset(
                          Assets.logout,
                          cacheHeight: 22,
                          fit: BoxFit.cover,
                        ),
                      )),
                  15.verticalSpace
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
