import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quizzy_app/model/questions_model.dart';
import 'package:quizzy_app/utils/constant/exam_costant.dart';
import 'package:quizzy_app/utils/general_utils.dart';
import 'package:quizzy_app/utils/validation.dart';

import '../../../utils/constant.dart';
import '../custom_classification.dart';
import '../custom_text.dart';
import 'custom_question_source_type.dart';

class CustomAboveSectionOfQuestion extends StatelessWidget {
  final QuestionsModel questionsModel;
  const CustomAboveSectionOfQuestion({
    super.key,
    required this.questionsModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomQuestionSourceType(
            imageDimensionsModel: questionsModel.imageDimensions,
            fileSourceLink: questionsModel.file,
            questionSourceType: questionsModel.fileType == null
                ? questionsModel.photo != null
                    ? QuestionSourceType.image
                    : QuestionSourceType.none
                : questionsModel.fileType == ExamConstatnt.video
                    ? QuestionSourceType.video
                    : QuestionSourceType.sound,
            imageSourceLink: questionsModel.photo),
        10.verticalSpace,
        questionsModel.name != null && questionsModel.name!.isNotEmpty
            ? CustomText(
                text: questionsModel.name!,
                fontFamily: "Cairo",
                fontSize: 16.sp,
                textDirection: Validation.instance
                        .isEnglishText(text: questionsModel.name!)
                    ? TextDirection.ltr
                    : TextDirection.rtl,
                textAlign: TextAlign.center,
                maxLines: 10000, // the Question can Be 6 Line
              )
            : 15.verticalSpace,
        questionsModel.reference != null && questionsModel.reference!.isNotEmpty
            ? 4.verticalSpace
            : const SizedBox(),
        questionsModel.reference != null && questionsModel.reference!.isNotEmpty
            ? Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.rectangle, color: Colors.lightGreen),
                padding: REdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  questionsModel.reference!,
                  textDirection: Validation.instance
                          .isEnglishText(text: questionsModel.reference!)
                      ? TextDirection.ltr
                      : TextDirection.rtl,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  style: TextStyle(
                      fontFamily: "Cairo",
                      fontSize: 10.sp,
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                      decorationColor: Colors.lightGreen,
                      decoration: TextDecoration.underline),
                ),
              )
            : const SizedBox(),
        questionsModel.fileType == null && questionsModel.photo == null
            ? 40.verticalSpace
            : 25.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomClassification(
              text: questionsModel.level != null
                  ? GeneralUtils.instance
                      .convertLevelToArabic(value: questionsModel.level!)
                  : "لايوجد", // لسه تتعدل من Api
            ),
            CustomClassification(
              text: '${questionsModel.points} نقطة',
            ),
            CustomClassification(
              text: '${questionsModel.time} ثواني',
            ),
          ],
        ),
        questionsModel.fileType == null && questionsModel.photo == null
            ? 25.verticalSpace
            : const SizedBox()
      ],
    );
  }
}
