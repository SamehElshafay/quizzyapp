import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:quizzy_app/view/custom_component/custom_button.dart';

import 'package:quizzy_app/view/custom_component/custom_text.dart';
import 'package:quizzy_app/view/custom_component/custom_text_form_field.dart';
import 'package:quizzy_app/view/custom_component/settings/custom_update_profile_picture.dart';
import 'package:quizzy_app/view_model/settings/update_account_view_model.dart';

class UpdateAccountView extends GetView<UpdateAccountViewModel> {
  const UpdateAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: CustomText(
          text: "تعديل الحساب",
          fontFamily: "Cairo",
          fontWeight: FontWeight.w500,
          fontSize: 12.sp,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              30.verticalSpace,
              // cutom

              GetBuilder<UpdateAccountViewModel>(
                id: 'updateProfileImage',
                builder: (controller) {
                  return CustomUpdateProfilePicture(
                    imageUrl: controller.imageUrl,
                    filePath: controller.filePath,
                    onTap: () {
                      controller.showBottomSheet(context);
                    },
                  );
                },
              ),
              50.verticalSpace,
              CustomText(
                text: "الاسم رباعي",
                fontFamily: "Cairo",
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: const Color(0xff4996BF),
                alignment: AlignmentDirectional.topEnd,
              ),
              15.verticalSpace,
              SizedBox(
                width: double.infinity.w,
                height: null,
                child: CustomTextFormField(
                  icon: null,
                  // height: 45.h,
                  height: null,
                  textAlignVertical: TextAlignVertical.top,
                  colorInitally: const Color(0xff4996BF),
                  colorFocus: const Color(0xff4996BF),
                  validator: (value) => controller.validateName(value: value),
                  controller: controller.nameController,
                ),
              ),
              30.verticalSpace,
              CustomText(
                text: "اسم المستخدم (الاسم المستعار)",
                fontFamily: "Cairo",
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: const Color(0xff4996BF),
                alignment: AlignmentDirectional.topEnd,
              ),
              15.verticalSpace,
              SizedBox(
                width: double.infinity.w,
                height: null,
                child: CustomTextFormField(
                  icon: null,
                  height: null,
                  // height: null,
                  textDirection: TextDirection.ltr,
                  textAlignVertical: TextAlignVertical.top,
                  colorInitally: const Color(0xff4996BF),
                  colorFocus: const Color(0xff4996BF),
                  validator: (value) =>
                      controller.validateUserName(value: value),
                  controller: controller.userNameController,
                ),
              ),
              80.verticalSpace,
              SizedBox(
                width: ScreenUtil().screenWidth * 0.70,
                child: CustomButton(
                    text: 'حفظ التغيير',
                    fontFamily: 'inter',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    onTap: () {
                      controller.changeAccountInformation();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
