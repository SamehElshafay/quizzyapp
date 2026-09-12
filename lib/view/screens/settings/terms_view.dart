import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/view/custom_component/custom_circular_progress_indicator.dart';
import 'package:quizzy_app/view/custom_component/custom_text.dart';
import 'package:quizzy_app/view_model/settings/terms_view_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsView extends GetView<TermsViewModel> {
  const TermsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: CustomText(
            text: "الشروط",
            fontFamily: "Cairo",
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
          ),
          centerTitle: true,
        ),
        body: GetBuilder<TermsViewModel>(
          builder: (controller) {
            return !controller.isLoadPage
                ? const CustomCircularProgressIndicator()
                : WebViewWidget(
                    controller: controller.controller,
                  );
          },
        ));
  }
}
