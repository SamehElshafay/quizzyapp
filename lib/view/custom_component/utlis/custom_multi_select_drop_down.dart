import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/utils/constant.dart';
import 'package:quizzy_app/view/custom_component/custom_text.dart';
import 'package:quizzy_app/view_model/utils/multiselectDropdown/multiselect_dropdown_view_model.dart';

class CustomMultiSelectDropDown extends GetView<MultiSelectDropDownViewModel> {
  final List<String> item;
  const CustomMultiSelectDropDown({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      title: Container(
        width: double.infinity,
        padding: REdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8).r,
          color: primayColor,
        ),
        child: CustomText(
          text: "اختر نوع الأسئلة",
          // textDirection: TextDirection.rtl,
          textAlign: TextAlign.center,
          fontSize: 20.sp,
          fontFamily: "Cairo",
          color: Colors.white,
        ),
      ),
      content: SingleChildScrollView(
        child: GetBuilder<MultiSelectDropDownViewModel>(
          builder: (controller) {
            return ListBody(
                children: controller.allItem
                    .map((item) => CheckboxListTile(
                        value: controller.selectedItem.contains(item),
                        title: Text(
                          item,
                          textDirection: TextDirection.rtl,
                        ),
                        activeColor: primayColor,
                        controlAffinity: ListTileControlAffinity.trailing,
                        onChanged: (isChecked) =>
                            controller.itemChange(item, isChecked!)))
                    .toList());
          },
        ),
      ),
      actions: [
        TextButton(
            style: TextButton.styleFrom(backgroundColor: erroColor),
            onPressed: () => controller.cancel(),
            child: CustomText(
              text: "إلغاء",
              color: Colors.white,
              fontSize: 13.sp,
            )),
        TextButton(
            style: TextButton.styleFrom(backgroundColor: primayColor),
            onPressed: () => controller.submit(),
            child: CustomText(
              text: "تأكيد",
              color: Colors.white,
              fontSize: 13.sp,
            ))
      ],
    );
  }
}
