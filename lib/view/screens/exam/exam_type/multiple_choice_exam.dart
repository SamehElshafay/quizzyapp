import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quizzy_app/utils/constant/exam_costant.dart';
import 'package:quizzy_app/view/custom_component/answer_questions/custom_multiple_choice_container.dart';
import 'package:quizzy_app/view_model/exam/exam_type/multiple_choice_exam_view_model.dart';

class MultipleChoiceExam extends StatelessWidget {
  const MultipleChoiceExam({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MultipleChoiceExamViewModel>(
      create: (context) => MultipleChoiceExamViewModel(),
      builder: (context, child) {
        ExamConstatnt.setNewQuestionContext(context);
        var controller = context.read<MultipleChoiceExamViewModel>();
        return Wrap(
            alignment: WrapAlignment.start,
            spacing: 20.r,
            runSpacing: 20.r,
            children: List.generate(
                controller.listAnswersModel.length,
                (index) => CustomMultipleChoiceContainer(
                      answerModel: controller.listAnswersModel[index],
                      isActive: controller.isActive(index),
                      reviewExam: controller.isRevisionAnswers,
                      // answerUserSelectedID: controller.answerSelectedId,
                      answerUserSelectedID: controller.isIdExist(index),
                    )));
      },
    );
  }
}
