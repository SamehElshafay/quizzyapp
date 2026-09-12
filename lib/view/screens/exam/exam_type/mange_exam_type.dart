import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/view_model/exam/manage_exam_view_model.dart';

class ManageExamType extends StatelessWidget {
  const ManageExamType({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManageExamViewModel>(
      id: "examType",
      builder: (controler) {
        return controler.examTypeList[controler.currentExamTypeIndex];
      },
    );
  }
}
