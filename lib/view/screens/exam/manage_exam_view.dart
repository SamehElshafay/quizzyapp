import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../view_model/exam/manage_exam_view_model.dart';

class ManageExamView extends GetView<ManageExamViewModel> {
  const ManageExamView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManageExamViewModel>(
      id: "updateCurrentManageExamsPagesIndex",
      builder: (context) {
        return controller.examViewList[controller.currentManageExamsPagesIndex];
      },
    );
  }
}
