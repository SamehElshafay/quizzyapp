import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/utils/app_images.dart';

import 'package:quizzy_app/view/custom_component/custom_circular_progress_indicator.dart';
import 'package:quizzy_app/view/custom_component/exam_statistics/custom_card_exam_result.dart';

import 'package:quizzy_app/view/custom_component/exam_statistics/custom_circle_sum_of_points_inofrmation.dart';
import 'package:quizzy_app/view/custom_component/exam_statistics/custom_statistics_icon.dart';
import 'package:quizzy_app/view_model/exam/exam_statistics_view_model.dart';
import 'package:quizzy_app/view_model/utils/theme/theme_view_model.dart';

class ExamStatisticsView extends GetView<ExamStatisticsViewModel> {
  const ExamStatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ExamStatisticsViewModel>(
        id: "updateExamStatisticsView",
        builder: (controller) {
          return !controller.isLoadExamStatisticsViewPage
              ? const CustomCircularProgressIndicator()
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(30).r),
                                color: Get.find<ThemeViewMode>().isDarkMode()
                                    ? Theme.of(context)
                                        .scaffoldBackgroundColor
                                        .withRed(30)
                                    : const Color(0xff268C6D),
                              ),
                              child: CustomCircleSumOfPointInformation(
                                sumOfPoint: controller
                                    .examAttemptStatisticsInofrmation
                                    .earnedMarks
                                    .toString(),
                              )),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            decoration: BoxDecoration(),
                            child: Column(
                              children: [
                                const Expanded(child: SizedBox()),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: const BoxDecoration(),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CustomStatisticsIcon(
                                              text: 'اعادة الاختبار',
                                              color: Color(0xff40C2E0),
                                              cacheHeight: 21,
                                              cacheWidth: 21,
                                              iconAssetPath:
                                                  Assets.repetitionStatistics,
                                              onTap: () =>
                                                  controller.repetitionExam(),
                                            ),
                                            30.verticalSpace,
                                            CustomStatisticsIcon(
                                              text: 'تحويلها pdf',
                                              color: Color(0xff37AFA1),
                                              cacheHeight: 18,
                                              cacheWidth: 24,
                                              onTap: () {
                                                controller.convertToPdf();
                                              },
                                              iconAssetPath:
                                                  Assets.convertPdfStatistics,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CustomStatisticsIcon(
                                                text: 'مشاركة',
                                                color: Color(0xff6680DB),
                                                cacheHeight: 22,
                                                cacheWidth: 21,
                                                iconAssetPath:
                                                    Assets.shareStatistics,
                                                onTap: () {
                                                  controller.shareFile();
                                                }),
                                            30.verticalSpace,
                                            CustomStatisticsIcon(
                                              text: 'مراجعة الاجابات',
                                              color: Color(0xffF75959),
                                              cacheHeight: 21,
                                              cacheWidth: 14,
                                              iconAssetPath: Assets
                                                  .revisionAnswerStatistics,
                                              onTap: () {
                                                controller.revisionaAnswers();
                                              },
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CustomStatisticsIcon(
                                              text: 'الرئيسية',
                                              color: Color(0xffAD8AE8),
                                              cacheHeight: 18,
                                              cacheWidth: 24,
                                              iconAssetPath:
                                                  Assets.homeStatistics,
                                              onTap: () =>
                                                  controller.goToHomePage(),
                                            ),
                                            30.verticalSpace,
                                            CustomStatisticsIcon(
                                              text: 'الأعلى نقاط',
                                              color: Color(0xff5F6A6E),
                                              cacheHeight: 18,
                                              cacheWidth: 24,
                                              iconAssetPath:
                                                  Assets.highPointsStatistics,
                                              onTap: () {
                                                controller.topPointRoute();
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    CustomCardExamResult(
                      numberCorrectAnswer: controller
                          .examAttemptStatisticsInofrmation.numberCorrectAnswer
                          .toString(),
                      numberWrongAnswer: controller
                          .examAttemptStatisticsInofrmation.numberWrongAnswer
                          .toString(),
                      totalQuestions: controller
                          .examAttemptStatisticsInofrmation.totalQuestions
                          .toString(),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
