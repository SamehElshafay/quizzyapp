import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/view/custom_component/custom_button.dart';
import 'package:quizzy_app/view/custom_component/custom_circular_progress_indicator.dart';
import 'package:quizzy_app/view/custom_component/custom_text.dart';
import 'package:quizzy_app/view_model/settings/balance_view_model.dart';

class BalanceView extends GetView<BalanceViewModel> {
  const BalanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<BalanceViewModel>(
        id: "updateLoadBalanceView",
        builder: (controller) {
          return !controller.isLoadBalanceView
              ? const CustomCircularProgressIndicator()
              : SingleChildScrollView(
                  padding: REdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    // color: Colors.amber,
                    height: MediaQuery.of(context).size.height * 0.60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.90,
                          height: 150.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12).r,
                              color: const Color(0xff268C6D)),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  text: "رصيدك الحالي",
                                  fontFamily: "Cairo",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 30.sp,
                                  color: Colors.white,
                                ),
                                10.verticalSpace,
                                GetBuilder<BalanceViewModel>(
                                  id: 'updateBalance',
                                  builder: (controller) {
                                    return CustomText(
                                      text: "${controller.balance} سؤال",
                                      fontFamily: "Segoe",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.sp,
                                      color: Colors.white,
                                      textDirection: TextDirection.rtl,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        100.verticalSpace,
                        CustomButton(
                            text: "شحن رصيد",
                            colorOfContainer: Colors.redAccent,
                            onTap: () {
                              controller.showAlertDialog(context);
                            })
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
