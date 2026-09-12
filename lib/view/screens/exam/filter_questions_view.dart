import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/utils/constant.dart';
import 'package:quizzy_app/utils/general_utils.dart';
import 'package:quizzy_app/view/custom_component/custom_circular_progress_indicator.dart';
import 'package:quizzy_app/view_model/exam/filter_questions_view_model.dart';
import 'package:quizzy_app/view_model/exam/manage_exam_view_model.dart';
import 'package:quizzy_app/view_model/utils/multiselectDropdown/multiselect_dropdown_view_model.dart';
import 'package:quizzy_app/view_model/utils/theme/theme_view_model.dart';

import '../../../utils/app_images.dart';
import '../../custom_component/custom_button.dart';
import '../../custom_component/custom_dropdown_filter.dart';
import '../../custom_component/custom_text.dart';

class FilterQuestionsView extends StatelessWidget {
  const FilterQuestionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: CustomText(
          text: "الإختبار الإختياري",
          fontFamily: "Cairo",
          fontWeight: FontWeight.w500,
          fontSize: 12.sp,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // controller.backFromFilter();
            Get.find<ManageExamViewModel>().backFromFilter();
          },
        ),
      ),
      body: GetBuilder<FilterQuestionsViewModel>(
        init: FilterQuestionsViewModel(),
        id: 'updateLoadFilterPage',
        builder: (controller) {
          return !controller.isLoadFilterPage
              ? const CustomCircularProgressIndicator()
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.h),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      Center(
                        child: Image.asset(
                          Assets.imagesSubjectFilter,
                          cacheHeight: 200.toInt(),
                          cacheWidth: 201.w.toInt(),
                          fit: BoxFit.fill,
                        ),
                      ),
                      GetBuilder<FilterQuestionsViewModel>(
                        id: 'updateSemester',
                        builder: (controller) {
                          return CustomDropDownFilter(
                            items: controller.semester,
                            value: controller.semesterValue,
                            onChanged: (value) =>
                                controller.updateSemester(value),
                            borderColor: const Color(0xff5BC8FD),
                            defaultValue: "الفصل",
                          );
                        },
                      ),
                      10.verticalSpace,
                      GetBuilder<FilterQuestionsViewModel>(
                        id: "updateUnits",
                        builder: (controller) {
                          return CustomDropDownFilter(
                            items: controller.unitsValueList,
                            value: controller.unitValue,
                            onChanged: (value) {
                              controller.updateUnits(value!);
                            },
                            borderColor: const Color(0xffFF3DC8),
                            defaultValue: "وحدة",
                          );
                        },
                      ),
                      10.verticalSpace,
                      GetBuilder<FilterQuestionsViewModel>(
                        id: "updateLeasons",
                        builder: (controller) {
                          return CustomDropDownFilter(
                            items: controller.leasonsValueList,
                            value: controller.leasonValue,
                            onChanged: (value) {
                              controller.updateLeasons(value!);
                            },
                            borderColor: const Color(0xff9FD800),
                            defaultValue: "الدرس",
                          );
                        },
                      ),
                      10.verticalSpace,
                      GetBuilder<FilterQuestionsViewModel>(
                        id: 'updateTime',
                        builder: (controller) {
                          return CustomDropDownFilter(
                              items: controller.time,
                              value: controller.timeValue,
                              onChanged: (value) =>
                                  controller.updateTime(value),
                              borderColor: const Color(0xffFFC700),
                              defaultValue: '''وقت (دقيقة)''');
                        },
                      ),
                      10.verticalSpace,
                      Container(
                        height: 42.h,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffFC9A9A),
                              width: 2.r,
                            ),
                            color: Get.find<ThemeViewMode>().isDarkMode()
                                ? Colors.black
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8.r)),
                        padding: const EdgeInsets.symmetric(horizontal: 12).w,
                        child: GetBuilder<MultiSelectDropDownViewModel>(
                          builder: (controller) {
                            return TextFormField(
                              readOnly: true,
                              onTap: () {
                                controller.showMultiSelect(context);
                                print("show Dialog Here");
                              },
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                  isCollapsed: true,
                                  prefixIcon: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      RPadding(
                                        padding: EdgeInsets.only(top: 4),
                                        child: Icon(
                                          Icons.add,
                                          color: Color(0xff268C6D),
                                          size: 17,
                                        ),
                                      ),
                                    ],
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 0),
                                  border: InputBorder.none,
                                  hintText: "نوع الاسئلة",
                                  hintStyle: TextStyle(
                                      fontSize: 12.sp,
                                      fontFamily: "Cairo",
                                      fontWeight: FontWeight.w400),
                                  hintTextDirection: TextDirection.rtl),
                              textDirection: TextDirection.rtl,
                            );
                          },
                        ),
                      ),
                      10.verticalSpace,
                      GetBuilder<MultiSelectDropDownViewModel>(
                        id: "updateWrapTypeOfQuestion",
                        builder: (controller) {
                          return Wrap(
                            direction: Axis.horizontal,
                            spacing: 10.r,
                            runSpacing: 5.r,
                            children: controller.selectedItem
                                .map(
                                  (e) => Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Chip(
                                        backgroundColor:
                                            Get.find<ThemeViewMode>()
                                                    .isDarkMode()
                                                ? null
                                                : const Color(0xffE2E2E2)
                                                    .withOpacity(0.6),
                                        onDeleted: () {
                                          controller.removeElementFromWrap(e);
                                        },
                                        deleteIconColor: erroColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20).r),
                                        side: const BorderSide(
                                            color: Colors.green, width: 1),
                                        label: CustomText(
                                          text: e.replaceAll('سؤال', "").trim(),
                                          color: primayColor,
                                          fontSize: 13.sp,
                                        )),
                                  ),
                                )
                                .toList(),
                          );
                        },
                      ),
                      10.verticalSpace,
                      GetBuilder<FilterQuestionsViewModel>(
                        id: 'updateLevelOfExam',
                        builder: (controller) {
                          return CustomDropDownFilter(
                            items: controller.levelOfExam,
                            value: controller.levelofExamValue,
                            onChanged: (value) =>
                                controller.updateLevelOfExam(value),
                            borderColor: const Color(0xffDD90F0),
                            defaultValue: "مستوى الاختبار",
                          );
                        },
                      ),
                      15.verticalSpace,
                      GetBuilder<FilterQuestionsViewModel>(
                        id: 'updateEvaluation',
                        builder: (controller) {
                          return Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () => controller.updateEvaluation(1),
                                  child: Padding(
                                    padding: REdgeInsets.all(8),
                                    child: Row(
                                      children: [
                                        CustomText(
                                          text: " التقييم عند الانتهاء",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        4.horizontalSpace,
                                        Radio(
                                          visualDensity: const VisualDensity(
                                            horizontal:
                                                VisualDensity.minimumDensity,
                                            vertical:
                                                VisualDensity.minimumDensity,
                                          ),
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          value: 1,
                                          groupValue:
                                              controller.evaluationGroupValue,
                                          activeColor: const Color(0xff268C6D),
                                          onChanged: (value) => controller
                                              .updateEvaluation(value!),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => controller.updateEvaluation(2),
                                  child: Padding(
                                    padding: REdgeInsets.all(8),
                                    child: Row(
                                      children: [
                                        CustomText(
                                          text: "التقييم مباشرة",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        4.horizontalSpace,
                                        Radio(
                                          visualDensity: const VisualDensity(
                                            horizontal:
                                                VisualDensity.minimumDensity,
                                            vertical:
                                                VisualDensity.minimumDensity,
                                          ),
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          value: 2,
                                          groupValue:
                                              controller.evaluationGroupValue,
                                          activeColor: Get.find<ThemeViewMode>()
                                                  .isDarkMode()
                                              ? GeneralUtils.instance
                                                  .convertColorToDark(
                                                      const Color(0xff268C6D))
                                              : const Color(0xff268C6D),
                                          onChanged: (value) => controller
                                              .updateEvaluation(value!),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      15.verticalSpace,
                      CustomButton(
                        text: "التالي",
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        onTap: () {
                          controller.confirmFilter(context);
                        },
                      ),
                      50.verticalSpace,
                    ]),
                  ));
        },
      ),
    );
  }
}
