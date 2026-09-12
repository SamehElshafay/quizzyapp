// update_account_view
// UpdateAccountViewModel
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quizzy_app/Service/api/repository_implementaion_service/profile_repository_service.dart';
import 'package:quizzy_app/Service/local/cache_user_service.dart';
import 'package:quizzy_app/Service/package/image_picker_service.dart';
import 'package:quizzy_app/Service/premession/permission_service.dart';
import 'package:quizzy_app/model/user_model.dart';
import 'package:quizzy_app/utils/app_images.dart';

import 'package:quizzy_app/utils/dialog_helper.dart';
import 'package:quizzy_app/utils/form_validator.dart';
import 'package:quizzy_app/utils/snack_bar_helper.dart';
import 'package:quizzy_app/view/custom_component/settings/custom_source_photo_in_bottom_sheet.dart';
import 'package:quizzy_app/view_model/settings/settings_view_model.dart';

class UpdateAccountViewModel extends GetxController {
  late User _user;

  String? _filePath;

  late TextEditingController _nameController;
  late TextEditingController _userNameController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? get imageUrl => (_user.photo != null &&
          _user.photo !=
              "https://quizzy.quizzy.site/images/students/avatar.png")
      ? _user.photo
      : null;
  String? get filePath => _filePath;
  TextEditingController get nameController => _nameController;
  TextEditingController get userNameController => _userNameController;
  GlobalKey<FormState> get formKey => _formKey;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _getUserFromCahce();
    _nameController = TextEditingController(text: _user.name);
    _userNameController = TextEditingController(text: _user.username);
  }

  ///////////////////////////////////////////////// Validator /////////////////////////////////////////////////
  String? validateName({String? value}) {
    return FormValidator.instance.anyTextFormValidator(value, "Name");
  }

  String? validateUserName({String? value}) {
    return FormValidator.instance.anyTextFormValidator(value, "User Name");
  }
///////////////////////////////////////////////Premission///////////////////////////////////////////////////

  Future<bool> _checkPremissionPhoto() async {
    PermissionService permissionService = PermissionService.instance;

    return await permissionService.checkGallary();
  }

  Future<bool> _checkPremissionCamera() async {
    PermissionService permissionService = PermissionService.instance;

    return await permissionService.checkCamera();
  }

//////////////////////////////////////////////// End Section ///////////////////////////////////////////////////
  void changeAccountInformation() {
    if (formKey.currentState!.validate()) {
      _updateProfileService();
    }
  }

  Future<void> _onTapSelectImage({required bool isCamera}) async {
    debugPrint('pick Image');
    XFile? pickFile;
    bool isGranted;
    if (isCamera) {
      isGranted = await _checkPremissionCamera();
    } else {
      isGranted = await _checkPremissionPhoto();
    }
    if (!isGranted)
      return; // if the Premission not Allowed return from this Method
    pickFile = await _pickImageService(isCamera: isCamera);

    if (isCamera) {
      DialogHelper.showLoading();
      Timer(Duration(seconds: 3), () {
        if (pickFile != null) {
          // s mean it select file
          _filePath = pickFile.path;
          update(['updateProfileImage']);
          DialogHelper.hideLoading();
          Get.back(); // to pop from Bottom Sheet
        } else {
          // 'You have not yet picked an image.'
          DialogHelper.hideLoading();
        }
      });
    } else {
      if (pickFile != null) {
        // s mean it select file
        _filePath = pickFile.path;
        update(['updateProfileImage']);
        Get.back(); // to pop from Bottom Sheet
      } else {
        // 'You have not yet picked an image.'
        DialogHelper.hideLoading();
      }
    }
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 200.h,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomSourcePhotoInBottomSheet(
                        assetIamge: Assets.cameraSource,
                        onTap: () async {
                          await _onTapSelectImage(isCamera: true);
                        },
                        text: "الكاميرا",
                        color: const Color.fromRGBO(159, 216, 0, 0.52)),
                    CustomSourcePhotoInBottomSheet(
                        onTap: () async {
                          await _onTapSelectImage(isCamera: false);
                        },
                        assetIamge: Assets.gallerySource,
                        text: "المعرض",
                        color: const Color.fromRGBO(221, 144, 240, 0.7))
                  ],
                ),
              ],
            ),
          );
        });
  }
  ///////////////////////////////////////////////// Service /////////////////////////////////////////////////

  void _getUserFromCahce() async {
    _user = CacheUserService.instance.getUser();
  }

  Future<void> updateUserCache({required User userValue}) async {
    _user = userValue;
    await Get.find<SettingsViewModel>().updateUserCache(userValue: userValue);
  }

  void _updateProfileService() {
    DialogHelper.showLoading(
        message: 'جاري حفظ التغييرات', textDirection: TextDirection.rtl);
    PofileRepositoryService()
        .updateProfile(
            name: nameController.text.trim(),
            userName: userNameController.text.trim(),
            onSendProgress: (count, total) {
              debugPrint("$count  , $total");
            },
            pathPhoto: _filePath)
        .then((value) {
      DialogHelper.hideLoading();
      if (value.success!) {
        updateUserCache(userValue: value.data!); // to update the Cache
        SnackBarHelper.instance.showMessage(
          message: ' تم حفظ التغييرات بنجاح ',
          isEnglish: false,
        );

        Get.back();
      } else {
        SnackBarHelper.instance.showMessage(
          message: ' فشل في  حفظ التغييرات ',
          isEnglish: false,
        );
      }
    }).catchError((e) {
      DialogHelper.hideLoading();
      SnackBarHelper.instance.showMessage(
        message: e.toString(),
        erro: true,
        showByGetx: true,
      );
    });
  }

  Future<XFile?> _pickImageService({required bool isCamera}) async {
    try {
      if (isCamera) {
        return await ImagePickerService().pickFromCamera();
      } else {
        return await ImagePickerService().pickFromgGallery();
      }
    } catch (e) {
      debugPrint("User Close Premisson ${e.toString()}");
    }
  }
}
