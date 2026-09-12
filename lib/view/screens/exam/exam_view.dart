import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:quizzy_app/model/timer_model.dart';
import 'package:quizzy_app/utils/app_images.dart';

import 'package:quizzy_app/utils/general_utils.dart';
import 'package:quizzy_app/view/custom_component/answer_questions/csutom_above_section_of_question.dart';
import 'package:quizzy_app/view/custom_component/custom_alert_message.dart';

import 'package:quizzy_app/view/custom_component/custom_circular_progress_indicator.dart';
import 'package:quizzy_app/view/screens/exam/exam_type/mange_exam_type.dart';
import 'package:quizzy_app/view_model/exam/manage_exam_view_model.dart';
import 'package:quizzy_app/view_model/utils/theme/theme_view_model.dart';

import '../../custom_component/answer_questions/custom_bottom_section_of_question.dart';

import '../../custom_component/custom_text.dart';

class ExamView extends GetView<ManageExamViewModel> {
  const ExamView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: CustomText(
            text: controller.examTypeMessage,
            fontFamily: "Cairo",
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
          ),
          centerTitle: true,
          leading: !controller.isRevisionAnswers
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => controller.backFromExamViewPage(),
                )
              : const SizedBox(),
          actions: [
            (!controller.isExamAttempt && controller.isNoQuestionExist) ||
                    controller.isRevisionAnswers
                ? const SizedBox()
                : GetBuilder<ManageExamViewModel>(
                    id: "updateTimer",
                    builder: (controller) {
                      TimerModel timerModel = controller.getCurrentTimer();
                      return Stack(
                        children: [
                          Container(
                            margin: REdgeInsets.only(right: 12),
                            padding: REdgeInsets.symmetric(
                                vertical: 4, horizontal: 6),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(12.r)),
                            child: CustomText(
                              text:
                                  "${timerModel.minute}:${timerModel.secound}",
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
          ],
        ),
        body: GetBuilder<ManageExamViewModel>(
          id: "LoadExamViewPage",
          builder: (controller) {
            return !controller.isLoadExamViewPage
                ? const CustomCircularProgressIndicator()
                : controller.isEmptyExam
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CustomAlertMessage(
                                text: "لا يوجد لديك اسئلة في هذا الامتحان "),
                          ],
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.h),
                        child: SingleChildScrollView(
                            child: Column(children: [
                          15.verticalSpace,
                          GetBuilder<ManageExamViewModel>(
                            id: "updateLinearProgres",
                            builder: (controller) {
                              return LinearPercentIndicator(
                                percent: controller.countOfQuestion /
                                    controller.totalOfQuestion,
                                lineHeight: 12.h,
                                barRadius: Radius.circular(20),
                                progressColor: Get.find<ThemeViewMode>()
                                        .isDarkMode()
                                    ? GeneralUtils.instance.convertColorToDark(
                                        const Color(0xff268C6D))
                                    : const Color(0xff268C6D),
                                backgroundColor:
                                    Get.find<ThemeViewMode>().isDarkMode()
                                        ? GeneralUtils.instance
                                            .convertColorToDark(Colors.black)
                                        : const Color(0xffEEEEEE),
                              );
                            },
                          ),
                          25.verticalSpace,
// Above Section of the Exam
                          GetBuilder<ManageExamViewModel>(
                            id: "updateAboveSection",
                            builder: (controller) {
                              return CustomAboveSectionOfQuestion(
                                questionsModel:
                                    controller.getCurrentQuestionModel(
                                        index: controller.currentQuetionIndex),
                              );
                            },
                          ),
                          20.verticalSpace,
                          const ManageExamType(),
                          controller.isNoSourceInputForThisQuestion()
                              ? 40.verticalSpace
                              : 25.verticalSpace,
                          // Blew Section
                          GetBuilder<ManageExamViewModel>(
                            id: "updateBlewSection",
                            builder: (controller) {
                              return CustomBottomViewOfQuestion(
                                onPressedSendNote: () {
                                  controller.sendNote();
                                },
                                onTapNextQuestion: () {
                                  controller.nextQuestion();
                                },
                                onTapBackQuestion: () {
                                  controller.backQuestion();
                                },
                                onChanged: (value) {
                                  print(value);
                                  controller.wrongQuetion(
                                      isWrongQuestion: value);
                                },
                              );
                            },
                          ),
                          25.verticalSpace,
                        ])));
          },
        ));
  }
}
