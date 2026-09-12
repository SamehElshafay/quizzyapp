import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:quizzy_app/view_model/exam/manage_exam_view_model.dart';

import '../custom_button.dart';
import '../custom_text.dart';

// ignore: must_be_immutable
class CustomBottomViewOfQuestion extends GetView<ManageExamViewModel> {
  CustomBottomViewOfQuestion(
      {super.key,
      required this.onPressedSendNote,
      this.currentValue = false,
      required this.onChanged,
      this.onTapBackQuestion,
      required this.onTapNextQuestion});
  final void Function()? onPressedSendNote;
  final void Function()? onTapNextQuestion;
  final void Function()? onTapBackQuestion;
  final void Function(bool)? onChanged;

  bool currentValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 75.h,
          alignment: AlignmentDirectional.center,
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xff268C6D)),
              borderRadius: BorderRadius.circular(8.r)),
          padding: const EdgeInsets.symmetric(horizontal: 12).w,
          child: TextFormField(
            controller: controller.noteController,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
                isCollapsed: true,
                prefixIcon: IconButton(
                  onPressed: onPressedSendNote,
                  icon: Icon(
                    Icons.arrow_back,
                    size: 20.r,
                    color: Color(0xff268C6D),
                  ),
                ),
                border: InputBorder.none,
                hintText: "ارسال ملاحظة....",
                hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xff268C6D),
                    fontFamily: "Cairo",
                    fontWeight: FontWeight.w400),
                hintTextDirection: TextDirection.rtl),
            textDirection: TextDirection.rtl,
          ),
        ),
        controller.isNoSourceInputForThisQuestion()
            ? 30.verticalSpace
            : 20.verticalSpace,
        StatefulBuilder(
          builder: (context, seState) {
            return Align(
              alignment: AlignmentDirectional.topEnd,
              child: SizedBox(
                width: 180.w,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: const VisualDensity(
                          horizontal: VisualDensity.minimumDensity,
                          vertical: VisualDensity.minimumDensity),
                      value: currentValue,
                      title: CustomText(
                        text: "مشكوك في صحته",
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                      ),
                      activeColor: Colors.white,
                      activeTrackColor: const Color(0xff7EBD4C),
                      onChanged: (value) {
                        seState(() {
                          currentValue = value;
                          onChanged!(value); // to Know the Current Value
                        });
                      }),
                ),
              ),
            );
          },
        ),
        controller.isNoSourceInputForThisQuestion()
            ? 30.verticalSpace
            : 20.verticalSpace,
        Row(
          children: [
            controller.isAfterFinish
                ? Expanded(
                    child: CustomButton(
                        text: 'السابق',
                        colorOfContainer: controller.isFirstQuestion
                            ? const Color(0xff268C6D).withOpacity(0.4)
                            : const Color(0xff268C6D),
                        fontFamily: "Cairo",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        onTap: controller.isFirstQuestion
                            ? null
                            : onTapBackQuestion),
                  )
                : const SizedBox(),
            controller.isAfterFinish ? 15.horizontalSpace : const SizedBox(),
            Expanded(
              child: controller.isLastQuestion
                  ? controller.isRevisionAnswers
                      ? CustomButton(
                          text: 'إلي القائمة الرئيسية',
                          fontFamily: "Cairo",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          colorOfContainer: Colors.red,
                          onTap: onTapNextQuestion)
                      : CustomButton(
                          text: 'إرسال الإمتحان',
                          fontFamily: "Cairo",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          colorOfContainer: Colors.red,
                          onTap: onTapNextQuestion)
                  : CustomButton(
                      text: 'التالي',
                      fontFamily: "Cairo",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      onTap: onTapNextQuestion),
            ),
          ],
        ),
      ],
    );
  }
}
