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
import 'package:quizzy_app/view_model/exam/exam_type/single_choice_exam_view_model.dart';
import 'package:quizzy_app/view_model/utils/theme/theme_view_model.dart';

import '../custom_text.dart';

class CustomSingleChoiceContainer extends StatelessWidget {
  final Color? color;
  final int? answerUserSelectedID; // id User Answer Selected
  final bool reviewExam;
  final int index;
  final AnswersModel answerModel;

  const CustomSingleChoiceContainer(
      {super.key,
      this.reviewExam = false,
      required this.index,
      this.answerUserSelectedID,
      this.color = const Color(0xff9FD800),
      required this.answerModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: reviewExam
          ? null
          : () {
              context
                  .read<SingleChoiceExamViewModel>()
                  .onTap(idAnswerValue: answerModel.id!, index: index);
            },
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 144.w,
            height: 90.h,
            padding: REdgeInsets.symmetric(horizontal: 4, vertical: 4),
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
                //rgba(0, 0, 0, 0.25)
                color: Get.find<ThemeViewMode>().isDarkMode()
                    ? GeneralUtils.instance.convertColorToDark(color!)
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
                        : Color.fromRGBO(0, 0, 0, 0.25),
                  ),
                ],
                borderRadius: BorderRadius.circular(17).r),
            child: (answerModel.answerViewFormat ==
                        ExamConstatnt.answerViewFormatText) ||
                    (answerModel.answerViewFormat ==
                        ExamConstatnt.answerViewFormatTextImage)
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
          context.read<SingleChoiceExamViewModel>().selectedIndex == index
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
            answerUserSelectedID == answerModel.id && answerModel.isCorrect!
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
                    ))
                : answerModel.isCorrect!
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
                    : answerUserSelectedID == answerModel.id!
                        ? const RPadding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.cancel_sharp,
                              color: Color(0xffcc0000),
                              size: 30,
                            ),
                          )
                        : const SizedBox(),
          answerModel.answerViewFormat == ExamConstatnt.answerViewFormatIamge ||
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
        ],
      ),
    );
  }
}
