import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:quizzy_app/utils/constant/exam_costant.dart';
import 'package:quizzy_app/view/custom_component/answer_questions/custom_single_choice_container.dart';
import 'package:quizzy_app/view_model/exam/exam_type/single_choice_exam_view_model.dart';
import 'package:quizzy_app/view_model/exam/manage_exam_view_model.dart';

class SingleChoiceExam extends StatelessWidget {
  const SingleChoiceExam({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SingleChoiceExamViewModel>(
      create: (context) => SingleChoiceExamViewModel(),
      builder: (context, child) {
        ExamConstatnt.setNewQuestionContext(
            context); // tu update the Current Context of the Question
        return Consumer<SingleChoiceExamViewModel>(
          builder: (context, controller, child) {
            return Wrap(
                alignment: WrapAlignment.start,
                spacing: 20.r,
                runSpacing: 20.r,
                children: List.generate(
                  controller.listAnswersModel.length,
                  (index) => CustomSingleChoiceContainer(
                    index: index,
                    answerModel: controller.listAnswersModel[index],
                    reviewExam: controller.isRevisionAnswers,
                    answerUserSelectedID: controller.answerSelectedId,
                  ),
                ));
          },
        );
      },
    );
  }
}
