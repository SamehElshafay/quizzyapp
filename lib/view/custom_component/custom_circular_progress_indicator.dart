import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/utils/constant.dart';
import 'package:quizzy_app/utils/general_utils.dart';
import 'package:quizzy_app/view_model/utils/theme/theme_view_model.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      backgroundColor:
          Get.find<ThemeViewMode>().isDarkMode() ? Colors.black : Colors.white,
      color: Get.find<ThemeViewMode>().isDarkMode()
          ? GeneralUtils.instance.convertColorToDark(primayColor)
          : primayColor,
    ));
  }
}
