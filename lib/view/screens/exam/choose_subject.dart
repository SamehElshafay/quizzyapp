import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/Service/local/cache_user_service.dart';
import 'package:quizzy_app/utils/app_images.dart';
import 'package:quizzy_app/view/custom_component/custom_alert_message.dart';
import 'package:quizzy_app/view/custom_component/custom_circular_progress_indicator.dart';
import 'package:quizzy_app/view/custom_component/custom_subject.dart';
import 'package:quizzy_app/view_model/settings/settings_view_model.dart';
import 'package:quizzy_app/view_model/utils/theme/theme_view_model.dart';
import '../../../view_model/exam/manage_exam_view_model.dart';
import '../../custom_component/custom_search_field.dart';
import '../../custom_component/custom_text.dart';

class ChooseSubjectView extends GetView<ManageExamViewModel> {
  const ChooseSubjectView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsViewModel>(
      id: "updatDarkMode",
      builder: (updateOnlyTheme) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: CustomText(
              text: "الاختبارات",
              fontFamily: "Cairo",
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              color: Get.find<ThemeViewMode>().isDarkMode()
                  ? Colors.white
                  : Colors.black,
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
                },
              ),
            ],
          ),
          body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.h),
              child: Column(children: [
                CustomSearchField(
                  text: "البحث عن مادة",
                  onChanged: (value) => controller.searchSubject(value: value),
                ),
                25.verticalSpace,
                CustomText(
                  text: "اختر المادة",
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.w500,
                  fontSize: 20.sp,
                  alignment: AlignmentDirectional.topEnd,
                ),
                20.verticalSpace,
                Expanded(
                  child: GetBuilder<ManageExamViewModel>(
                    id: "updateSubject",
                    builder: (controller) {
                      return !controller.isLoadChoicePage
                          ? const CustomCircularProgressIndicator()
                          : controller.subjectList.isEmpty
                              ? CustomAlertMessage(
                                  text:
                                      "لايوجد مواد حاليا مضافة في ${CacheUserService.instance.getUser().academicYear?.name ?? 'هذا القسم'}")
                              : controller.searchSubjectList.isEmpty
                                  ? const CustomAlertMessage(
                                      text: "لايوجد مواد بهذا الإسم")
                                  : GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              mainAxisSpacing: 50.h,
                                              crossAxisSpacing: 50.w,
                                              crossAxisCount: 2),
                                      itemCount:
                                          controller.searchSubjectList.length,
                                      itemBuilder: (context, index) {
                                        return CustomSubject(
                                          subjectModel: controller
                                              .searchSubjectList[index],
                                          onTap: () {
                                            controller.chooseSubject(
                                                subjectSelectedInformation:
                                                    controller
                                                            .searchSubjectList[
                                                        index]);
                                          },
                                        );
                                      });
                    },
                  ),
                ),
              ])),
        );
      },
    );
  }
}
