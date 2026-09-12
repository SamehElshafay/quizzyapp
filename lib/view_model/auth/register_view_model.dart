import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quizzy_app/Service/api/repository_implementaion_service/academic_years_repository_service.dart';
import 'package:quizzy_app/Service/api/repository_implementaion_service/auth_repository_service.dart';
import 'package:quizzy_app/Service/local/cache_notification_service.dart';
import 'package:quizzy_app/Service/local/cache_settings_service.dart';
import 'package:quizzy_app/Service/nottification/push_notification_service.dart';
import 'package:quizzy_app/model/academic_year_model.dart';
import 'package:quizzy_app/model/auth_model.dart';
import 'package:quizzy_app/model/register_model.dart';
import 'package:quizzy_app/model/social_login_model.dart';
import 'package:quizzy_app/utils/constant/app_list_data.dart';
import 'package:quizzy_app/utils/dialog_helper.dart';
import 'package:quizzy_app/utils/general_utils.dart';
import 'package:quizzy_app/utils/snack_bar_helper.dart';
import 'package:quizzy_app/utils/validation.dart';
import 'package:quizzy_app/view_model/auth/login_view_model.dart';
import '../../utils/form_validator.dart';
import '../../utils/routes.dart';

class RegisterViewModel extends GetxController {
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  bool get isLoading => _isLoading.value;

  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> continueRegisterFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController inviteController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController emailOrPhoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  ///////////// register  Socail Variable//////////////////
  String providerType = "";
  String providerId = "";
  bool isSocial = false;
/////////////////////////////////////////////////

  String? governorateValue;
  String? stateOfAreaValue;
  String? areaName;
  String? specializationValue = "";
  String? academicYearValue;
  List<String> governorateListValue = []; //  the value of the Drop Down
  bool isVisibilityErroMessage = false;
  int groupValue = 1; // 1 deafult value mean "قطاع غزة"
  List<AcademicYearModel> academicYearModelList = []; // general Model
  List<String> academicYearListDropDown = []; // for DropDown
  List<String> areaNameList = [
    "ٌيرجي اختيار اسم المحافظة أولا",
  ];

  /////////////////////////// Get From Constant App list Data /////////////////////////////////////
  late final List<String> stateOfAreaList;
  late final List<String> specializationList;
  late final List<String> governoratListGaza;
  late final List<String> governorateListWest;
  late final Map<String, List<String>>
      getAreaName; // to get the Area Name based on the valu of governorateList (west , giza) that selected from dropDown

////////////////////////////////////////////////////Api Service , init , dispose/////////////////////////////////////////////////

  void initConstantList() {
    // to inint alll const list
    stateOfAreaList = AppListData.stateOfAreaList;
    specializationList = AppListData.specializationList;
    governoratListGaza = AppListData.governoratListGaza;
    governorateListWest = AppListData.governorateListWest;
    getAreaName = AppListData.getAreaName;
  }

  void disposeAllController() {
    nameController.dispose();
    userNameController.dispose();
    dateController.dispose();
    emailOrPhoneController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    inviteController.dispose();
    _isLoading.dispose();
  }

  void _getAllAcdemicYears() async {
    try {
      AcademicYearsRepositoryService().getAllAcademicYear().then((value) {
        academicYearModelList = value.data!;
        academicYearListDropDown = GeneralUtils.instance
            .convertAcdemicYearToListOfString(
                academicYearList:
                    academicYearModelList); // cover the Acdemic Year Model to String value
        // to conver
        _isLoading.value = true;
        update(['loading']);
      });
    } on DioException catch (e) {
      debugPrint(
          'Erro in RegisterViewModel getAllAcdemicYears Methods: Erro is \n$e');
    } catch (e) {
      debugPrint(
          'Erro in RegisterViewModel getAllAcdemicYears Methods: Erro is \n$e');
    }
  }

////////////////////////////////////////////////// onInit , onDispose ///////////////////////////////////////////////////
  @override
  void onInit() {
    super.onInit();
    initConstantList(); // to inint alll const list
    updateGovernorateListBasedOnRadioButtonSelection(); // to init the GovernorateList
    _getAllAcdemicYears(); // get Acdemic Year from Api
  }

  @override
  void onClose() {
    super.onClose();
    FocusScope.of(Get.context!).unfocus();
    disposeAllController(); // to dispose All Controller of the Data Members
  }

  String getHintTextOfInviteCode() {
    return CacheSettingsService.instance
            .getSettings()
            .settingsData!
            .inputInvitationCodeMsg ??
        "لكي تحصل علي عدد اسئلة مجانا  مجانا مجانا مجانا مجانا مجانا مجانا مجاناإلي رصيد ادخل كود الدعوة";
    //   "لكي تحصل علي عدد اسئلة مجانا إلي رصيد ادخل كود الدعوة"
  }

  bool isShowBirthDate() {
    return CacheSettingsService.instance
                .getSettings()
                .settingsData!
                .showBalance ==
            "1"
        ? true
        : false;
    ;
  }

//////////////////////////////////// Update the Element of The UI //////////////////////////////////////////////
  void updateGovernorateListBasedOnRadioButtonSelection() {
    governorateListValue =
        groupValue == 1 ? governoratListGaza : governorateListWest;
  }

  void updateRadioButton({required int value}) {
    groupValue = value;
    update(["regionRadioButton"]);
    governorateValue = null; // to set the default
    areaName = null; // to set the default
    areaNameList = [
      "ٌيرجي اختيار اسم المحافظة أولا", // to set the default
    ];
    update(['areaName']);
    updateGovernorateListBasedOnRadioButtonSelection();
    update(['governorate']);
  }

  void updateGovernorate({required String value}) {
    governorateValue = value;

    areaNameList =
        getAreaName["$governorateValue"]!; // to update the areName List
    areaName =
        null; // to skip the erro becuase the initial value must contain a value of areNameList , so you must clear after a areList have a newValue
    update(['governorate']);
    update(['areaName']); // to update the list of the areaName
  }

  void updateStateOfAreaList({required String value}) {
    stateOfAreaValue = value;
    update(['stateOfArea']);
  }

  void updateAreaName({required String value}) {
    areaName = value;
    update(['areaName']);
  }

  void updateAcademicYear({required String value}) {
    academicYearValue = value; // academicYearIdValue
    update(['academicYear']);
  }

  void updateSpecialization({required String value}) {
    specializationValue = value;
    update(['specialization']);
  }

  Future<void> showDate(BuildContext context) async {
    await showDatePicker(
            context: context,
            initialDate: DateTime(2000),
            firstDate: DateTime(1900),
            lastDate: DateTime(2023))
        .then((value) {
      if (value != null) {
        // 'yyy-MM-dd' 2022
        String date = DateFormat('yyyy-MM-dd').format(value);
        dateController.text = date;
      }
    });
  }

////////////////////////////////////////////////////// Validation for the Screen ///////////////////////////////////////////////
  String? validatePhoneOrEmail({String? value}) {
    if (isSocial) {
      return FormValidator.instance
          .contactsValidator(value!.trim(), startPlusCode: false);
    } else {
      return FormValidator.instance.validatePhoneOrEmail(value!.trim());
    }
  }

  String? validatePhone({String? value}) {
    return FormValidator.instance
        .contactsValidator(value!.trim(), startPlusCode: false);
  }

  String? validateEmail({String? value}) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    if (!Validation.instance.isEmail(email: value.trim())) {
      return 'يرجى إدخال عنوان بريد إلكتروني صالح';
    }
    return null;
  }

  String? validateName({String? value}) {
    return FormValidator.instance.anyTextFormValidator(value, "Name");
  }

  String? validateUserName({String? value}) {
    return FormValidator.instance.anyTextFormValidator(value, "User Name");
  }

  String? validateBirthDate({String? value}) {
    return FormValidator.instance.anyTextFormValidator(value, "Birth Data");
  }

  String? validatePaswword({String? value}) {
    return FormValidator.instance.passwordValidator(value);
  }
  // confirmPasswordValidator

  String? confirmPasswordValidator({String? value}) {
    return FormValidator.instance.confirmPasswordValidator(
        passwordConfirmController.text.trim(), passwordController.text.trim());
  }

  bool validateFieldsOfDropDown() {
    if (governorateValue == null ||
        stateOfAreaValue == null ||
        areaName == null ||
        academicYearValue == null) {
      isVisibilityErroMessage = true;
      update(['visibility']);
      return true;
    } else {
      isVisibilityErroMessage = false;

      return false;
    }
  }

////////////////////////////////////////////////////////// Goals Methods of Screen //////////////////////////////////////////////////////////////////
  void continueRegisterView() {
    if (registerFormKey.currentState!.validate()) {
      if (validateFieldsOfDropDown()) {
        return; // to show the Message erro if any Fields equal null
      } else {
        isVisibilityErroMessage = false;
        update(['visibility']);
      }

      Get.toNamed(Routes.continueRegisterView);
    }
  }

  void logIn() async {
    if (continueRegisterFormKey.currentState!.validate()) {
      bool isSucessProcess = false;
      DialogHelper.showLoading();

      bool isEmail = Validation.instance
          .isEmail(email: emailOrPhoneController.text.trim());

      if (isSocial) {
        // call register the information of the Social
        Get.find<LoginViewModel>().registerInformationOfSocial(
            socialLoginModel: SocialLoginModel(
          providerId: providerId,
          providerType: providerType,
          name: nameController.text,
          inviteCode: inviteController.text,
          dateOfBirth: dateController.text, // SOLVE IT THROW EXCEPTION
          area: GeneralUtils.instance.getGroupValueName(groupValue: groupValue),
          username: userNameController.text, // YYYY-M-D
          specialization: specializationValue,
          governorate: governorateValue,
          residenceArea: stateOfAreaValue,
          academicYearId: GeneralUtils.instance.getAcademicYearById(
              academicYearList: academicYearModelList,
              value: academicYearValue!),
          locationArea: areaName,
          deviceToken: await PushNotificationService().getToken() ?? "",
          phone: isEmail
              ? ''
              : "+972${emailOrPhoneController.text.trim().substring(1)}",
        ));
      } else {
        // call Registr End Point
        isSucessProcess = await _registerService();
      }
      DialogHelper.hideLoading();
      if (isSucessProcess) Get.offAllNamed(Routes.loginView);
    }
  }

  Future<bool> _registerService() async {
    bool isEmail =
        Validation.instance.isEmail(email: emailOrPhoneController.text.trim());
    RegisterModel registerModel = RegisterModel(
      name: nameController.text,
      //dateController.text,
      email: isEmail ? emailOrPhoneController.text.trim() : '',
      phone: isEmail
          ? ''
          : "+972${emailOrPhoneController.text.trim().substring(1)}",
      area: GeneralUtils.instance.getGroupValueName(groupValue: groupValue),
      username: userNameController.text,
      inviteCode: inviteController.text,
      specialization: specializationValue,
      password: passwordController.text.trim(),
      dateOfBirth: dateController.text,
      governorate: governorateValue,
      residenceArea: stateOfAreaValue,
      academicYearId: GeneralUtils.instance.getAcademicYearById(
          academicYearList: academicYearModelList, value: academicYearValue!),
      locationArea: areaName,
      deviceToken: await PushNotificationService().getToken() ?? "",
    );

    try {
      AuthModel response = await AuthRepositoryService.instance
          .register(registerModel: registerModel);
      debugPrint('$response');
      SnackBarHelper.instance
          .showMessage(message: response.message!, milliseconds: 1000);
      return true;
    } catch (e, s) {
      DialogHelper.hideLoading();
      SnackBarHelper.instance
          .showMessage(message: e.toString(), milliseconds: 2000, erro: true);
    }
    return false;
  }

  void activeSocial(
      {required String providerIdValue, required String providerTypeValue}) {
    providerId = providerIdValue;
    providerType = providerTypeValue;
    isSocial = true;
  }
}
