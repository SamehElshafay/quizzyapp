import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:quizzy_app/Service/Firebase/social_service/repository_implementaion_service/google_repository_Service.dart';
import 'package:quizzy_app/Service/Firebase/social_service/repository_implementaion_service/social_repository_manger_service.dart';
import 'package:quizzy_app/Service/local/auth_route_service.dart';
import 'package:quizzy_app/Service/local/auth_token_service.dart';
import 'package:quizzy_app/Service/local/cache_subject_service.dart';
import 'package:quizzy_app/Service/local/cache_user_service.dart';
import 'package:quizzy_app/model/academic_year_model.dart';
import 'package:quizzy_app/model/ads_model.dart';
import 'package:quizzy_app/model/user_model.dart';

import 'package:quizzy_app/utils/app_images.dart';
import 'package:quizzy_app/utils/general_utils.dart';
import 'package:quizzy_app/view/custom_component/custom_ads_and_offer.dart';
import 'package:quizzy_app/view/custom_component/custom_alert_message.dart';
import 'package:quizzy_app/view/custom_component/custom_circular_progress_indicator.dart';
import 'package:quizzy_app/view/custom_component/custom_dropdown_filter.dart';
import 'package:quizzy_app/view/custom_component/custom_exam_attempt.dart';
import 'package:quizzy_app/view/custom_component/custom_text.dart';
import 'package:quizzy_app/view/custom_component/custom_top_student_point.dart';
import 'package:quizzy_app/view_model/bottomNavigation/home_view_model.dart';
import 'package:quizzy_app/view_model/settings/settings_view_model.dart';
import 'package:quizzy_app/view_model/utils/theme/theme_view_model.dart';

import '../../custom_component/custom_search_field.dart';

class HomeView extends GetView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsViewModel>(
      id: "updatDarkMode",
      builder: (updateOnlyTheme) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: GetBuilder<HomeViewModel>(
              id: 'updateAcademicYears',
              builder: (homeController) {
                var currentUser = CacheUserService.instance.getUser();
                String currentYearName =
                    currentUser?.academicYear?.name ?? 'اختيار الفرع';
                AcademicYearModel? selectedValue;
                if (homeController.academicYearsList.isNotEmpty &&
                    currentUser != null) {
                  selectedValue = homeController.academicYearsList
                      .firstWhereOrNull(
                          (y) => y.id == currentUser.academicYearId);
                }

                return DropdownButtonHideUnderline(
                  child: DropdownButton<AcademicYearModel>(
                    value: selectedValue,
                    hint: CustomText(
                      text: currentYearName,
                      color: Get.find<ThemeViewMode>().isDarkMode()
                          ? Colors.white
                          : Colors.black,
                      fontSize: 16.sp,
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.w700,
                    ),
                    icon: Icon(Icons.arrow_drop_down,
                        color: Get.find<ThemeViewMode>().isDarkMode()
                            ? Colors.white
                            : Colors.black),
                    onChanged: (AcademicYearModel? newValue) {
                      if (newValue != null &&
                          newValue.id != currentUser?.academicYearId) {
                        homeController.changeAcademicYear(newValue);
                      }
                    },
                    items: homeController.academicYearsList
                        .map((AcademicYearModel year) {
                      return DropdownMenuItem<AcademicYearModel>(
                        value: year,
                        child: CustomText(
                          text: year.name ?? '',
                          color: Get.find<ThemeViewMode>().isDarkMode()
                              ? Colors.white
                              : Colors.black,
                          fontSize: 14.sp,
                          fontFamily: "Cairo",
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
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
                onPressed: () async {
                  Get.find<SettingsViewModel>().notificationViewPageRoute();
                  print("Ok");
                  print("Ok");
                  // Remove tHE rOUTE PROCESS

                  // remove Acees Toeken
                  print(CacheUserService.instance.getUser()!.email);
                  print(CacheUserService.instance.getUser()!.phone);
                  print(CacheUserService.instance.getUser()!.username);
                  print(CacheUserService.instance.getUser()!.id);
                  print(CacheUserService.instance.getUser().photo);
                  // await CacheSubjectService.instance.deleteSubjects();

                  // await SocialRepositoryMangerService()
                  //     .logout(GoogleRepositoryService()); // apply Polymarphism
                },
              ),
            ],
          ),
          body: GetBuilder<HomeViewModel>(
            builder: (controller) {
              return !controller.isLoadHomeViewPage
                  ? const Center(child: CustomCircularProgressIndicator())
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.h),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomSearchField(
                              text: "البحث عن استئناف امتحان",
                              onChanged: (value) =>
                                  controller.searchExamAttempts(value: value),
                            ),
                            50.verticalSpace,
                            SizedBox(
                              height: 150.h,
                              child: GetBuilder<HomeViewModel>(
                                id: 'updateExamAttempts',
                                builder: (controller) {
                                  return controller
                                              .searchExamAttemptsList.isEmpty &&
                                          controller.listExamAttempts.isEmpty
                                      ? CustomExamAttempts(
                                          isEmpty: true,
                                          onPressed: () =>
                                              controller.onTapExamAttempt(),
                                        )
                                      : controller
                                              .searchExamAttemptsList.isEmpty
                                          ? CustomExamAttempts(
                                              isEmpty: true,
                                              showSearchEmpty: true,
                                              onPressed: () =>
                                                  controller.onTapExamAttempt(),
                                            )
                                          : ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              controller: controller
                                                  .examAttemptScrollController,
                                              itemBuilder: (context, index) {
                                                if (index <
                                                    controller
                                                        .searchExamAttemptsList
                                                        .length) {
                                                  return CustomExamAttempts(
                                                    onPressed: () => controller
                                                        .onTapExamAttempt(
                                                            index: index),
                                                    examAttemptsDataModel:
                                                        controller
                                                                .searchExamAttemptsList[
                                                            index],
                                                  );
                                                } else {
                                                  return controller
                                                          .hasMoreDataExam
                                                      ? Padding(
                                                          padding: REdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child:
                                                              const CustomCircularProgressIndicator(),
                                                        )
                                                      : !controller
                                                              .hasNextPageExam
                                                          ? Padding(
                                                              padding: REdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          12),
                                                              child:
                                                                  const CustomAlertMessage(
                                                                text:
                                                                    "لا مزيد من البيانات",
                                                              ))
                                                          : const SizedBox();
                                                }
                                              },
                                              separatorBuilder:
                                                  (context, index) {
                                                return 10.horizontalSpace;
                                              },
                                              itemCount: controller
                                                          .hasMoreDataExam ||
                                                      !controller
                                                          .hasNextPageExam
                                                  ? controller
                                                          .searchExamAttemptsList
                                                          .length +
                                                      1
                                                  : controller
                                                      .searchExamAttemptsList
                                                      .length,
                                            );
                                },
                              ),
                            ),
                            25.verticalSpace,
                            CustomText(
                              text: "اعلانات وعروض خاصة",
                              fontFamily: "Cairo",
                              alignment: AlignmentDirectional.topEnd,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                            ),
                            15.verticalSpace,
                            GetBuilder<HomeViewModel>(
                              id: 'updateAds',
                              builder: (controller) {
                                return controller.adsList.isEmpty
                                    ? CustomAdsAndOffer(adsModel: AdsData())
                                    : SizedBox(
                                        height: 150.h,
                                        child: ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return CustomAdsAndOffer(
                                                adsModel:
                                                    controller.adsList[index]);
                                          },
                                          separatorBuilder: (context, index) {
                                            return 10.horizontalSpace;
                                          },
                                          itemCount: controller.adsList.length,
                                        ),
                                      );
                              },
                            ),
                            25.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GetBuilder<HomeViewModel>(
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
                                        onChanged: (value) =>
                                            controller.updateSubject(value!),
                                        borderColor: Get.find<ThemeViewMode>()
                                                .isDarkMode()
                                            ? GeneralUtils.instance
                                                .convertColorToDark(
                                                    const Color(0xff9ADFEF))
                                            : const Color(0xff9ADFEF),
                                        defaultValue: "اختر المادة",
                                      ),
                                    );
                                  },
                                ),
                                CustomText(
                                  text: "الأعلى تقييم",
                                  fontSize: 16.sp,
                                  fontFamily: "Cairo",
                                ),
                              ],
                            ),
                            15.verticalSpace,
                            SizedBox(
                              height: 130.h,
                              child: GetBuilder<HomeViewModel>(
                                id: "updateTopStudent",
                                builder: (controller) {
                                  return controller.listTopStudent.isEmpty
                                      ? const CustomAlertMessage(
                                          text:
                                              "لايوجد  حاليا الأعلي تقييم في هذه المادة")
                                      : ListView.separated(
                                          controller: controller
                                              .topStudentScrollController,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            if (index <
                                                controller
                                                    .listTopStudent.length) {
                                              return CustomTopStudentPoints(
                                                  topStudentDataModel:
                                                      controller.listTopStudent[
                                                          index]);
                                            } else {
                                              return controller
                                                      .hasMoreDataTopStudent
                                                  ? Padding(
                                                      padding:
                                                          REdgeInsets.symmetric(
                                                              horizontal: 12),
                                                      child:
                                                          const CustomCircularProgressIndicator(),
                                                    )
                                                  : !controller
                                                          .hasNextPageTopStudent
                                                      ? Padding(
                                                          padding: REdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child:
                                                              const CustomAlertMessage(
                                                            text:
                                                                "لا مزيد من البيانات",
                                                          ))
                                                      : const SizedBox();
                                            }
                                          },
                                          separatorBuilder: (context, index) {
                                            return 10.horizontalSpace;
                                          },
                                          itemCount: controller
                                                      .hasMoreDataTopStudent ||
                                                  !controller
                                                      .hasMoreDataTopStudent
                                              ? controller
                                                      .listTopStudent.length +
                                                  1
                                              : controller
                                                  .listTopStudent.length);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    );
            },
          ),
        );
      },
    );
  }
}
