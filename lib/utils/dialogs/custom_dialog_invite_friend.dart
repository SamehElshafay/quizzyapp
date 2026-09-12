import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:quizzy_app/utils/constant.dart';
import 'package:quizzy_app/utils/snack_bar_helper.dart';

import 'package:quizzy_app/view/custom_component/custom_text.dart';

import 'package:quizzy_app/view_model/settings/invite_friend_view_model.dart';
import 'package:quizzy_app/view_model/utils/theme/theme_view_model.dart';

class CustomDialogInviteFriend extends StatelessWidget {
  const CustomDialogInviteFriend({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InviteFriendViewModel>(
      init: InviteFriendViewModel(),
      builder: (controller) {
        return AlertDialog(
          //    actionsAlignment: MainAxisAlignment.spaceEvenly,
          title: Container(
            padding: REdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8).r,
              color: primayColor,
            ),
            width: double.infinity,
            child: CustomText(
              text: "كيفية إرسال الدعوة",
              // textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              fontSize: 20.sp,
              fontFamily: "Cairo",
              color: Colors.white,
            ),
          ),
          content: SingleChildScrollView(
            child: RPadding(
              padding: REdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                child: Column(
                  children: [
                    // CustomText(
                    //   text: "كيفية إرسال الدعوة",
                    //   fontFamily: "Cairo",
                    //   fontSize: 18.sp,
                    //   alignment: AlignmentDirectional.topEnd,
                    // ),
                    // 10.verticalSpace,
                    CustomText(
                      text: controller.getMessageHelperOfInvitition(),
                      fontSize: 14.sp,
                      maxLines: 10000,
                      textAlign: TextAlign.center,
                      color: Get.find<ThemeViewMode>().isDarkMode()
                          ? Colors.grey.shade400
                          : Colors.grey.shade700,
                    ),
                    RPadding(
                      padding: REdgeInsets.symmetric(vertical: 20),
                      child: const Divider(),
                    ),
                    CustomText(
                      text: "كود الدعوة الخاص بك : -",
                      textDirection: TextDirection.rtl,
                      fontFamily: "Cairo",
                      fontSize: 16.sp,
                      alignment: AlignmentDirectional.topEnd,
                      color: Get.find<ThemeViewMode>().isDarkMode()
                          ? Colors.grey.shade400
                          : Colors.grey.shade700,
                      //  fontWeight: FontWeight.bold,
                    ),
                    20.verticalSpace,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize:
                              Size(MediaQuery.of(context).size.width, 50),
                          padding: REdgeInsets.symmetric(
                              horizontal: 20, vertical: 10)),
                      onPressed: () async {
                        await Clipboard.setData(ClipboardData(
                            text: controller.getInvitationCode()));

                        SnackBarHelper.instance
                            .showMessage(message: "تم نسخ الكود بنجاح");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.copy_sharp),
                          CustomText(
                            text: controller.getInvitationCode(),
                            // color: Get.find<ThemeViewMode>().isDarkMode()
                            //     ? Colors.grey.shade400
                            //     : Colors.grey.shade700,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          // actions: [
          //   TextButton(
          //       style: TextButton.styleFrom(backgroundColor: erroColor),
          //       onPressed: () => controller.cancel(),
          //       child: CustomText(
          //         text: "إلغاء",
          //         color: Colors.white,
          //         fontSize: 13.sp,
          //       )),
          //   TextButton(
          //       style: TextButton.styleFrom(backgroundColor: primayColor),
          //       onPressed: () => controller.submit(),
          //       child: CustomText(
          //         text: "تأكيد",
          //         color: Colors.white,
          //         fontSize: 13.sp,
          //       ))
          // ],
        );
      },
    );
  }
}
