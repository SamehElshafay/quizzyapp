import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/utils/app_images.dart';
import 'package:quizzy_app/utils/general_utils.dart';
import 'package:quizzy_app/view/custom_component/charts/custom_line_chart.dart';
import 'package:quizzy_app/view/custom_component/custom_circular_progress_indicator.dart';
import 'package:quizzy_app/view/custom_component/custom_dropdown_filter.dart';
import 'package:quizzy_app/view/custom_component/custom_text.dart';
import 'package:quizzy_app/view_model/bottomNavigation/account_view_model.dart';
import 'package:quizzy_app/view_model/settings/settings_view_model.dart';
import 'package:quizzy_app/view_model/utils/theme/theme_view_model.dart';

import '../../custom_component/custom_achievement.dart';

class AccountView extends GetView<AccountViewModel> {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsViewModel>(
      id: "updatDarkMode",
      builder: (updateOnlyTheme) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
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
                  },
                ),
              ],
            ),
            body: GetBuilder<AccountViewModel>(
              builder: (controller) {
                return !controller.isLoadAccountView
                    ? const CustomCircularProgressIndicator()
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.h),
                        child: Column(
                          children: [
                            20.verticalSpace,
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(17).r,
                                    border: Border.all(
                                      color: const Color(0xffD9D9D9),
                                    )),
                                child: Column(
                                  children: [
                                    RPadding(
                                      padding: REdgeInsets.symmetric(
                                          vertical: 12, horizontal: 4),
                                      child: CustomText(
                                        text:
                                            "مجموع نقاطك هذا الاسبوع في ${controller.selectedSubject()} ${controller.achievementModel!.data!.chart!.totalEarnedMarks!} نقطة",
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const Divider(),
                                    Expanded(
                                        child: AspectRatio(
                                            aspectRatio: 2,
                                            child: CustomLineChart(
                                              maxY: controller
                                                  .maxNumberInCharts(),
                                              listData:
                                                  controller.chartListData,
                                            )))
                                  ],
                                ),
                              ),
                            ),
                            20.verticalSpace,
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GetBuilder<AccountViewModel>(
                                        id: "updateSubject",
                                        builder: (controller) {
                                          return SizedBox(
                                            height: 26.h,
                                            width: 111.w,
                                            child: CustomDropDownFilter(
                                              items: controller
                                                  .subjectListDropDownValues,
                                              value: controller.subjectValue,
                                              isSubject: true,
                                              onChanged: (value) => controller
                                                  .updateSubject(value!),
                                              borderColor:
                                                  Get.find<ThemeViewMode>()
                                                          .isDarkMode()
                                                      ? GeneralUtils
                                                          .instance
                                                          .convertColorToDark(
                                                              const Color(
                                                                  0xff9ADFEF))
                                                      : const Color(0xff9ADFEF),
                                              defaultValue: "اختر المادة",
                                            ),
                                          );
                                        },
                                      ),
                                      CustomText(
                                        text: "إنجازاتك",
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20.sp,
                                      ),
                                    ],
                                  ),
                                  20.verticalSpace,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomAchievement(
                                        text: "سؤال",
                                        number: controller.achievementModel!
                                                .data!.totalQuestions ??
                                            "0",
                                        assetImage: Assets.imagesCorrectansswer,
                                      ),
                                      CustomAchievement(
                                        text: "نقطة",
                                        number: controller.achievementModel!
                                                .data!.totalEarnedMarks ??
                                            "0",
                                        assetImage: Assets.imagesPoints,
                                      ),
                                    ],
                                  ),
                                  25.verticalSpace,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomAchievement(
                                        text: "النجاح",
                                        number: controller.achievementModel!
                                            .data!.numberCorrectAnswer
                                            .toString(),
                                        assetImage: Assets.imagesFire,
                                      ),
                                      CustomAchievement(
                                        text: "من الأوائل",
                                        number: controller.achievementModel!
                                                .data!.yourRanking ??
                                            "0",
                                        assetImage: Assets.imagesMedal,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ));
              },
            ));
      },
    );
  }
}
