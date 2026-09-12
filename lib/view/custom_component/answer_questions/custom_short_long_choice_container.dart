import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/model/Image_dimensions_model.dart';
import 'package:quizzy_app/model/answers_model.dart';
import 'package:quizzy_app/utils/constant/exam_costant.dart';

import 'package:quizzy_app/utils/image_helper/custom_image_helper.dart';
import 'package:quizzy_app/utils/image_helper/custom_image_viewer.dart';
import 'package:quizzy_app/utils/validation.dart';
import 'package:quizzy_app/view_model/utils/theme/theme_view_model.dart';

class CustomShortLongChoiceContainer extends StatelessWidget {
  final Color color;

  final bool? isCorrectAnswer;

  final AnswersModel answersModel; // id User Answer Selected
  final TextEditingController? controllerText;
  final void Function(String)? onChanged;
  final int? maxCharLength;
  final double? width;
  final double? height;
  final bool reviewExam;
  const CustomShortLongChoiceContainer({
    super.key,
    required this.answersModel,
    required this.controllerText,
    required this.onChanged,
    this.width = 300,
    this.height = 200,
    this.maxCharLength,
    this.reviewExam = false,
    this.isCorrectAnswer,
    this.color = Colors.amber,
  });

  @override
  Widget build(BuildContext context) {
    final bool isAnswerViewFormatTextImage = answersModel.answerViewFormat ==
        ExamConstatnt.answerViewFormatTextImage;
    final bool isEnglishText = Validation.instance
            .isEnglishText(text: answersModel.answerTwoGapMatch ?? '') ||
        Validation.instance.isEnglishText(text: answersModel.title ?? '');

    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
            width: width!.w,
            height: height!.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                image: answersModel.answerViewFormat ==
                            ExamConstatnt.answerViewFormatIamge ||
                        isAnswerViewFormatTextImage
                    ? DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          answersModel.photo!,
                        ))
                    : null,
                color: Get.find<ThemeViewMode>().isDarkMode() ? null : color,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    //offset: Offset(0, 7),
                    /* BoxShadow(
                                        offset: Offset(0, 4),
                                        spreadRadius: 0,
                                        blurRadius: 20,
                                        color: Get.find<ThemeViewMode>()
                                                .isDarkMode()
                                            ? Colors.white
                                            : const Color.fromRGBO(
                                                0, 0, 0, 0.25),
                                        //  color: Colors.white30
                                      ),

                    */
                    spreadRadius: 0,
                    blurRadius: 5,
                    color: Get.find<ThemeViewMode>().isDarkMode()
                        ? const Color.fromRGBO(0, 0, 0, 0.25)
                        : const Color.fromRGBO(0, 0, 0, 0.25),
                  ),
                ],
                // border: Border.all(
                //   color: Colors.black38,
                // ),
                borderRadius: BorderRadius.circular(17).r),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: TextFormField(
                controller: reviewExam
                    ? isCorrectAnswer != null && isCorrectAnswer!
                        ? controllerText
                        : TextEditingController(
                            text: answersModel.answerTwoGapMatch)
                    : controllerText,
                textAlign: TextAlign.center,
                readOnly: reviewExam,

                onChanged: onChanged,

                textInputAction: TextInputAction.done,
                autovalidateMode: AutovalidateMode.onUserInteraction,

                validator: reviewExam
                    ? null
                    : maxCharLength != null
                        ? (value) {
                            // eaxh Line Have 50 Charter
                            if (value!.trim().length > maxCharLength!) {
                              return "لابد أن يكون النص عدد حروفه الكلية  $maxCharLength";
                            } else {
                              return null;
                            }
                          }
                        : null,

                textDirection:
                    isEnglishText ? TextDirection.ltr : TextDirection.rtl,
                maxLines: null, // to write the Text in MultiLine

                cursorColor: isAnswerViewFormatTextImage ? Colors.white : null,
                style: TextStyle(
                    fontFamily: "Cairo",
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    color: isAnswerViewFormatTextImage ? Colors.white : null,
                    overflow: TextOverflow.ellipsis),
                decoration: InputDecoration(
                    errorStyle: TextStyle(
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.w800,
                      fontSize: 16.sp,
                    ),
                    isCollapsed: true,
                    isDense: true,
                    contentPadding: REdgeInsets.symmetric(horizontal: 10),
                    border: InputBorder.none,
                    hintText: answersModel.title ?? '',
                    hintMaxLines: 5, // to mprevent it in a Single line

                    hintTextDirection:
                        isEnglishText ? TextDirection.ltr : TextDirection.rtl,
                    hintStyle: TextStyle(
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: isAnswerViewFormatTextImage ? Colors.white : null,
                    )),
              ),
            )),

        answersModel.answerViewFormat == ExamConstatnt.answerViewFormatIamge ||
                answersModel.answerViewFormat ==
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
                        imageDimensionsModel: answersModel.imageDimensions ??
                            ImageDimensionsModel(),

                        imageUrl: answersModel.photo ?? "",
                      )),
                ),
              )
            : const SizedBox()
        // controller.selectedIndex == index
        //     ? const RPadding(
        //         padding: EdgeInsets.all(8.0),
        //         child: Icon(
        //           Icons.check_circle,
        //           color: Colors.white,
        //           size: 30,
        //         ),
        //       )
        //     : const SizedBox(),
        // if (reviewExam)
        //   answerUserSelectedID == id && isCorrect
        //       ? const RPadding(
        //           padding: EdgeInsets.all(8.0),
        //           child: Icon(
        //             Icons.check_circle,
        //             color: Colors.white,
        //             size: 30,
        //           ))
        //       : isCorrect
        //           ? const RPadding(
        //               padding: EdgeInsets.all(8.0),
        //               child: Icon(
        //                 Icons.check_circle,
        //                 color: Colors.white,
        //                 size: 30,
        //               ),
        //             )
        //           : answerUserSelectedID == id
        //               ? const RPadding(
        //                   padding: EdgeInsets.all(8.0),
        //                   child: Icon(
        //                     Icons.cancel_sharp,
        //                     color: Color(0xffcc0000),
        //                     size: 30,
        //                   ),
        //                 )
        //               : const SizedBox()
      ],
    );
  }
}
