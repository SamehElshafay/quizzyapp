import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:quizzy_app/model/top_student_dataModel.dart';
import 'package:quizzy_app/view/custom_component/custom_alert_message.dart';
import 'package:quizzy_app/view/custom_component/custom_circular_progress_indicator.dart';
import 'package:quizzy_app/view/custom_component/custom_text.dart';

import 'package:quizzy_app/view/custom_component/exam_statistics/custom_top_point_card.dart';
import 'package:quizzy_app/view/custom_component/exam_statistics/custom_top_three_student.dart';
import 'package:quizzy_app/view_model/exam/top_point_view_model.dart';
import 'package:quizzy_app/view_model/utils/theme/theme_view_model.dart';

class TopPointView extends GetView<TopPointViewModel> {
  const TopPointView({super.key});
// const Color.fromRGBO(38, 140, 109, 1)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Get.find<ThemeViewMode>().isDarkMode()
              ? Colors.transparent
              : const Color.fromRGBO(38, 140, 109, 1),
          elevation: 0,
          centerTitle: true,
          title: CustomText(
            text: "الأعلى نقاط",
            fontFamily: "Cairo",
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
            color: Colors.white,
          )),
      body: GetBuilder<TopPointViewModel>(
        id: "updateLoadTopPointView",
        builder: (controller) {
          return !controller.isLoadTopPointView
              ? const CustomCircularProgressIndicator()
              : controller.topStudentList.isEmpty
                  ? const CustomAlertMessage(
                      text: 'لا يوجد حاليا الأعلى نقاط في هذه المادة')
                  : Container(
                      color: Get.find<ThemeViewMode>().isDarkMode()
                          ? Theme.of(context).scaffoldBackgroundColor
                          : const Color.fromRGBO(38, 140, 109, 1),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: Get.find<ThemeViewMode>().isDarkMode()
                                  ? Theme.of(context).scaffoldBackgroundColor
                                  : const Color.fromRGBO(38, 140, 109, 1),
                              width: double.infinity,
                              margin: REdgeInsets.only(bottom: 50),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  RPadding(
                                    padding: REdgeInsets.only(top: 65),
                                    child: CustomTopThreeStudent(
                                      number: "2",
                                      isAvailable:
                                          (controller.topStudentList.length >=
                                              2),
                                      topStudentDataModel:
                                          controller.topStudentList.length >= 2
                                              ? controller.topStudentList[1]
                                              : TopStudentDataModel(
                                                  student: Student()),
                                      angleInDegrees: -12,
                                    ),
                                  ),
                                  RPadding(
                                    padding: REdgeInsets.symmetric(
                                      horizontal: 15,
                                    ),
                                    child: CustomTopThreeStudent(
                                      number: "1",
                                      width: 90,
                                      hight: 203,
                                      verticalSpacePicture: 20,
                                      color:
                                          const Color.fromRGBO(225, 230, 0, 1),
                                      isAvailable: (controller
                                          .topStudentList.isNotEmpty),
                                      topStudentDataModel:
                                          controller.topStudentList.isNotEmpty
                                              ? controller.topStudentList[0]
                                              : TopStudentDataModel(
                                                  student: Student()),
                                      angleInDegrees: 0,
                                    ),
                                  ),
                                  RPadding(
                                    padding: REdgeInsets.only(top: 65),
                                    child: CustomTopThreeStudent(
                                      number: "3",
                                      isAvailable:
                                          (controller.topStudentList.length >=
                                              3),
                                      color:
                                          const Color.fromRGBO(61, 232, 225, 1),
                                      topStudentDataModel:
                                          controller.topStudentList.length >= 3
                                              ? controller.topStudentList[2]
                                              : TopStudentDataModel(
                                                  student: Student()),
                                      angleInDegrees: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                                padding: REdgeInsets.symmetric(vertical: 20),
                                decoration: BoxDecoration(
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
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
                                    ],
                                    color: Get.find<ThemeViewMode>()
                                            .isDarkMode()
                                        ? Theme.of(context)
                                            .scaffoldBackgroundColor // //  const Color.fromRGBO(0, 0, 0, 0.50)
                                        : Colors.white,
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20.r))),
                                child: SizedBox(
                                  child: GetBuilder<TopPointViewModel>(
                                    id: "updateTopStudent",
                                    builder: (controller) {
                                      return ListView.separated(
                                          scrollDirection: Axis.vertical,
                                          controller:
                                              controller.scrollController,
                                          itemBuilder: (context, index) {
                                            if (index <
                                                controller
                                                    .topStudentList.length) {
                                              return SizedBox(
                                                child: CustomTopPointCard(
                                                    index: index,
                                                    topStudentDataModel:
                                                        controller
                                                                .topStudentList[
                                                            index]),
                                              );
                                            } else {
                                              return controller
                                                      .hasMoreDataTopStudent
                                                  ? Padding(
                                                      padding:
                                                          REdgeInsets.symmetric(
                                                              horizontal: 12),
                                                      child:
                                                          const CustomCircularProgressIndicator(),
                                                    )
                                                  : !controller
                                                          .hasNextPageTopStudent
                                                      ? Padding(
                                                          padding: REdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child:
                                                              const CustomAlertMessage(
                                                            text:
                                                                "لا مزيد من البيانات",
                                                          ))
                                                      : const SizedBox();
                                            }
                                          },
                                          separatorBuilder: (context, index) =>
                                              10.verticalSpace,
                                          itemCount: (controller
                                                      .hasMoreDataTopStudent ||
                                                  !controller
                                                      .hasNextPageTopStudent)
                                              ? controller
                                                      .topStudentList.length +
                                                  1
                                              : controller
                                                  .topStudentList.length);
                                    },
                                  ),
                                )),
                          ),
                        ],
                      ),
                    );
        },
      ),
    );
  }
}

class RotatedContainer extends StatelessWidget {
  final double angleInDegrees;
  final Widget child;
  final int? value;

  const RotatedContainer(
      {required this.angleInDegrees, required this.child, this.value = 180});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angleInDegrees * (3.1415926535 / 180),
      child: child,
    );
  }
}
