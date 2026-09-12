import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:quizzy_app/model/Image_dimensions_model.dart';
import 'package:quizzy_app/model/answers_model.dart';
import 'package:quizzy_app/utils/constant/exam_costant.dart';
import 'package:quizzy_app/utils/general_utils.dart';
import 'package:quizzy_app/utils/image_helper/custom_image_helper.dart';
import 'package:quizzy_app/utils/image_helper/custom_image_viewer.dart';
import 'package:quizzy_app/utils/validation.dart';
import 'package:quizzy_app/view_model/exam/exam_type/multiple_choice_exam_view_model.dart';
import 'package:quizzy_app/view_model/utils/theme/theme_view_model.dart';

import '../custom_text.dart';

// ignore: must_be_immutable
class CustomMultipleChoiceContainer extends StatelessWidget {
  final Color color;

  final int? answerUserSelectedID; // id User Answer Selected

  final bool reviewExam;
  final AnswersModel answerModel;
  bool isActive;

  CustomMultipleChoiceContainer({
    super.key,
    this.isActive = false,
    this.reviewExam = false,
    required this.answerModel,
    this.answerUserSelectedID,
    this.color = const Color(0xff9FD800),
  });

  /*
   return GetBuilder<MultipleChoiceExamViewModel>(
      id: "MultipleChoice $id",
      builder: (controller) {
        return GestureDetector(
          onTap: reviewExam
              ? null
              : () {
                  isActive = !isActive;
                  controller.onTap(idAnswer: id, value: isActive);
                },
          child: Stack(alignment: AlignmentDirectional.topEnd, children: [

  */
  @override
  Widget build(BuildContext context) {
    return Consumer<MultipleChoiceExamViewModel>(
      builder: (context, controller, child) {
        return GestureDetector(
          onTap: reviewExam
              ? null
              : () {
                  isActive = !isActive;
                  controller.onTap(idAnswer: answerModel.id!, value: isActive);
                },
          child: Stack(alignment: AlignmentDirectional.topEnd, children: [
            Container(
              width: 144.w,
              height: 90.h,
              padding: REdgeInsets.symmetric(horizontal: 4, vertical: 4),
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                  //rgba(0, 0, 0, 0.25)
                  color: Get.find<ThemeViewMode>().isDarkMode()
                      ? GeneralUtils.instance.convertColorToDark(color)
                      : color,
                  image: answerModel.answerViewFormat ==
                              ExamConstatnt.answerViewFormatIamge ||
                          answerModel.answerViewFormat ==
                              ExamConstatnt.answerViewFormatTextImage
                      ? DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            answerModel.photo!,
                          ))
                      : null,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      offset: Offset(0, 5),
                      spreadRadius: 0,
                      blurRadius: 5,
                      color: Get.find<ThemeViewMode>().isDarkMode()
                          ? Colors.white24
                          : const Color.fromRGBO(0, 0, 0, 0.25),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(17).r),
              child: answerModel.answerViewFormat ==
                          ExamConstatnt.answerViewFormatText ||
                      answerModel.answerViewFormat ==
                          ExamConstatnt.answerViewFormatTextImage
                  ? SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: CustomText(
                        text: answerModel.title ?? "",
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w400,
                        textDirection: Validation.instance
                                .isEnglishText(text: answerModel.title!)
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                        fontSize: answerModel.title!.length > 35
                            ? 10.sp
                            : 16.sp, // to resize the Text
                        textAlign: answerModel.title!.length > 100
                            ? null
                            : TextAlign
                                .center, // if the Text More than 100 Char make it start otherWise make it Center
                        color: answerModel.answerViewFormat ==
                                ExamConstatnt.answerViewFormatTextImage
                            ? Colors.white
                            : null,
                        maxLines: 100,
                      ),
                    )
                  : const SizedBox(),
            ),
            isActive
                ? RPadding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.check_circle,
                      color: answerModel.answerViewFormat ==
                                  ExamConstatnt.answerViewFormatIamge ||
                              answerModel.answerViewFormat ==
                                  ExamConstatnt.answerViewFormatTextImage
                          ? Colors.black
                          : Colors.white,
                      size: 30,
                    ),
                  )
                : const SizedBox(),
            if (reviewExam)
              answerUserSelectedID == answerModel.id! && answerModel.isCorrect!
                  ? RPadding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.check_circle,
                        color: answerModel.answerViewFormat ==
                                    ExamConstatnt.answerViewFormatIamge ||
                                answerModel.answerViewFormat ==
                                    ExamConstatnt.answerViewFormatTextImage
                            ? Colors.black
                            : Colors.white,
                        size: 30,
                      ),
                    )
                  : answerUserSelectedID == answerModel.id! &&
                          !answerModel.isCorrect!
                      ? const RPadding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.cancel_sharp,
                            color: Color(0xffcc0000),
                            size: 30,
                          ),
                        )
                      : answerUserSelectedID == null && answerModel.isCorrect!
                          ? const RPadding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.check_circle,
                                color: Color(0xffcc0000),
                                size: 30,
                              ),
                            )
                          : const SizedBox(),
            answerModel.answerViewFormat ==
                        ExamConstatnt.answerViewFormatIamge ||
                    answerModel.answerViewFormat ==
                        ExamConstatnt.answerViewFormatTextImage
                ? Positioned(
                    left: 5,
                    right: 5,
                    child: RPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: CustomImageViewer(
                          isShowIconZoomOut: true,
                          child: CustomImageHelper(
                            // hieght= (width / aspect ratio)
                            imageDimensionsModel: answerModel.imageDimensions ??
                                ImageDimensionsModel(),

                            imageUrl: answerModel.photo ?? "",
                          )),
                    ),
                  )
                : const SizedBox()
          ]),
        );
      },
    );
  }
}
