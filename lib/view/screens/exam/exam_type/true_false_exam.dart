import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import 'package:quizzy_app/utils/constant/exam_costant.dart';
import 'package:quizzy_app/view/custom_component/answer_questions/custom_true_false_choice_container.dart';
import 'package:quizzy_app/view_model/exam/exam_type/true_false_exam_view_model.dart';

class TrueFalseExam extends StatelessWidget {
  const TrueFalseExam({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TrueFalseExamViewModel>(
      create: (context) => TrueFalseExamViewModel(),
      builder: (context, child) {
        ExamConstatnt.setNewQuestionContext(context); //controller
        return Consumer<TrueFalseExamViewModel>(
          builder: (context, controller, child) {
            return Wrap(
                alignment: WrapAlignment.start,
                spacing: 20.r,
                runSpacing: 20.r,
                children: List.generate(
                  controller.listAnswersModel.length,
                  (index) => CustomTrueFalseChoice(
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
