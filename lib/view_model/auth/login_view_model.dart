import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/Service/Firebase/social_service/repository/social_repository.dart';
import 'package:quizzy_app/Service/Firebase/social_service/repository_implementaion_service/apple_repository_service.dart';
import 'package:quizzy_app/Service/Firebase/social_service/repository_implementaion_service/facebook_repository_service.dart';
import 'package:quizzy_app/Service/Firebase/social_service/repository_implementaion_service/google_repository_Service.dart';
import 'package:quizzy_app/Service/Firebase/social_service/repository_implementaion_service/social_repository_manger_service.dart';
import 'package:quizzy_app/Service/api/repository_implementaion_service/auth_repository_service.dart';
import 'package:quizzy_app/Service/local/auth_route_service.dart';
import 'package:quizzy_app/Service/local/auth_token_service.dart';
import 'package:quizzy_app/Service/local/cache_settings_service.dart';
import 'package:quizzy_app/Service/local/cache_user_service.dart';
import 'package:quizzy_app/Service/nottification/push_notification_service.dart';
import 'package:quizzy_app/model/auth_model.dart';
import 'package:quizzy_app/model/genral_response_mode.dart';
import 'package:quizzy_app/model/login_model.dart';
import 'package:quizzy_app/model/social_login_model.dart';
import 'package:quizzy_app/model/social_service_response_model.dart';
import 'package:quizzy_app/utils/constant.dart';
import 'package:quizzy_app/utils/dialog_helper.dart';
import 'package:quizzy_app/utils/form_validator.dart';
import 'package:quizzy_app/utils/snack_bar_helper.dart';
import 'package:quizzy_app/utils/validation.dart';
import 'package:quizzy_app/view_model/auth/register_view_model.dart';

import '../../utils/routes.dart';

class LoginViewModel extends GetxController {
  String initViewModel = "";

  TextEditingController emailOrPhoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print('Init LoginView');
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    print("close LoginView");
  }

  String? validatePhoneOrEmail({String? value}) {
    return FormValidator.instance.validatePhoneOrEmail(value!.trim());
  }

  String? validatePhone({String? value}) {
    return FormValidator.instance.contactsValidator(value!.trim());
  }

  String? validatePasword({String? value}) {
    return FormValidator.instance.passwordValidator(value);
  }

  void createAccount() {
    Get.toNamed(Routes.registerView);
  }

  void forgetPassword() {
    Get.toNamed(Routes.forgetPasswordView);
  }

  ////////////////////////////////// Goal Mehtods/////////////////////////////////

  Future<AuthModel?> _loginByEmailOrPhoneService(
      {required LoginModel loginModel}) async {
    try {
      AuthModel authModel =
          await AuthRepositoryService.instance.login(loginModel: loginModel);

      if (authModel.success!) {
        await _cacheAcessToken(
            acessToken: authModel.data!.accessToken!); // Cache Acess Token
        SnackBarHelper.instance
            .showMessage(message: authModel.message!.toString());
        return authModel;
      } else {
        SnackBarHelper.instance
            .showMessage(message: authModel.message!.toString(), erro: true);
      }
    } catch (e) {
      SnackBarHelper.instance.showMessage(message: e.toString(), erro: true);
    }
    return null;
  }

  Future<void> _cacheAcessToken({required String acessToken}) async {
    await AuthTokenService.instance.add(value: acessToken); // cache acess token
  }

  void loginButton() async {
    if (loginFormKey.currentState!.validate()) {
      DialogHelper.showLoading(
          message: 'يتم التحميل .....',
          textDirection: TextDirection.rtl); // if any Erro Occur Close Dilag
      // LoginService
      bool isEmail = Validation.instance
          .isEmail(email: emailOrPhoneController.text.trim());
      // to know if the input email or phone
      print(isEmail
          ? "Email: ${emailOrPhoneController.text.trim()}"
          : "+972${emailOrPhoneController.text.trim().substring(1)}");

      AuthModel? authModel = await _loginByEmailOrPhoneService(
          loginModel: LoginModel(
              email: isEmail ? emailOrPhoneController.text.trim() : '',
              password: passwordController.text,
              phone: isEmail
                  ? ''
                  : "+972${emailOrPhoneController.text.trim().substring(1)}",
              type: isEmail ? SourceLoginType.email : SourceLoginType.phone));
      if (authModel == null) {
        DialogHelper.hideLoading();
        return; // if any erro occur skip return from this method
      }

      await CacheUserService.instance
          .updateUser(user: authModel.data!.user!); // to cache the User Object

      if (isEmail) {
        if (!authModel.data!.user!.hasVerifiedEmail!) {
          String email = emailOrPhoneController.text.trim();
          Get.offAllNamed(Routes.verifyEmailView, arguments: email);
          // to verify Email
        } else {
          await AuthRouteService.instance.logIn();
          PushNotificationService().activeNotification();
          Get.offAllNamed(Routes.bottomNavgation); // go to the home Page
        }
      } else {
        if (!authModel.data!.user!.phoneVerified!) {
          String phone =
              "+972${emailOrPhoneController.text.trim().substring(1)}";

          Get.offAllNamed(Routes.verifyPhoneView, arguments: phone);
          // to verify Email
        } else {
          await AuthRouteService.instance.logIn();
          PushNotificationService().activeNotification(); // update Device Token
          Get.offAllNamed(Routes.bottomNavgation); // go to the home Page
        }
      }
    }
  }

  void guestLoginButton() async {
    DialogHelper.showLoading(
        message: 'يتم التحميل .....', textDirection: TextDirection.rtl);

    try {
      AuthModel authModel = await AuthRepositoryService.instance.guestLogin();

      if (authModel.success!) {
        await _cacheAcessToken(acessToken: authModel.data!.accessToken!);
        await CacheUserService.instance.updateUser(user: authModel.data!.user!);
        await AuthRouteService.instance.logIn();
        await AuthRouteService.instance.setGuest(true); // Save guest flag

        PushNotificationService().activeNotification();
        Get.offAllNamed(Routes.bottomNavgation);
      } else {
        DialogHelper.hideLoading();
        SnackBarHelper.instance
            .showMessage(message: authModel.message!.toString(), erro: true);
      }
    } catch (e) {
      DialogHelper.hideLoading();
      SnackBarHelper.instance.showMessage(message: e.toString(), erro: true);
    }
  }

  void logoutButton() async {
    await AuthRouteService.instance.logout();
    await CacheUserService.instance
        .deleteUser(); // to delete user from the Cache
    // remove UserCache
  }

///////////////////////////////////// Social Logain Logic /////////////////////////////////////////////
  Future<AuthModel?> _loginBySocialService(
      {required SocialLoginModel socialLoginModel}) async {
    try {
      AuthModel authModel = await AuthRepositoryService.instance
          .socialLogin(socialLoginModel: socialLoginModel);

      if (authModel.success!) {
        await _cacheAcessToken(
            acessToken: authModel.data!.accessToken!); // Cache Acess Token

        print('*' * 50);
        print("Acess Toke ${authModel.data!.accessToken}");
        print('*' * 50);
        return authModel;
      } else {
        DialogHelper.hideLoading(); // if any Erro Occur Close Dilag
        SnackBarHelper.instance
            .showMessage(message: authModel.message!.toString(), erro: true);
      }
    } catch (e) {
      SnackBarHelper.instance.showMessage(message: e.toString(), erro: true);
    }
    return null;
  }

  SocialRepository _getObjectTypeOfSocailLoin(
      {required SocialMediaType socialMediaType}) {
    if (socialMediaType == SocialMediaType.apple) {
      return AppleRepositoryService();
    } else if (socialMediaType == SocialMediaType.google) {
      return GoogleRepositoryService();
    } else {
      // remove a Google and add   return FacebookRepositoryService();
      return FacebookRepositoryService();
    }
  }

  Future<void> handelScoialAccountRouteProcess(
      {required String providerId, required String providerType}) async {
    try {
      GeneralResponseModel generalResponseModel =
          await AuthRepositoryService.instance.checkUser(
              value:
                  providerId); // Check if the providerId ID Exist in the DataBase  or not
      print(generalResponseModel.success);
      print(providerId);
      print(providerType);
      print('-' * 80);
      if (generalResponseModel.success!) {
        AuthModel? autModel = await _loginBySocialService(
            socialLoginModel: SocialLoginModel(
                providerId: providerId,
                providerType:
                    providerType)); // call Social Service , cache Token

        if (autModel == null) {
          DialogHelper.hideLoading(); // if any Erro Occur Close Dilag
          return;
        } // if any erro occur in social Service
        DialogHelper.hideLoading(); // close Daialog
        await CacheUserService.instance
            .updateUser(user: autModel.data!.user!); // to cache the User Object
        // check Veify Phone or Not
        if (!autModel.data!.user!.phoneVerified!) {
          print(autModel.data!.user!.phone);
          Get.offAllNamed(Routes.verifyPhoneView,
              arguments: autModel.data!.user!.phone);
        } else {
          await AuthRouteService.instance.logIn();
          PushNotificationService().activeNotification(); // update Device Token
          Get.offAllNamed(Routes.bottomNavgation);
        }
      } else {
        DialogHelper.hideLoading(); // close Dialog
        // the Fist Login must SignUp by Collecting Some of information
        Get.put(RegisterViewModel()); // Load  Controller

        Get.find<RegisterViewModel>().activeSocial(
            providerIdValue: providerId,
            providerTypeValue:
                providerType); // to mark the Register View to Collect Social Inforamtion only  , pass ProviderId , providerType
        Get.toNamed(Routes.registerView);
      }
    } catch (e) {
      DialogHelper.hideLoading(); // if any Erro Occur Close Dilag
      SnackBarHelper.instance
          .showMessage(message: "Some Erro Occur Please Try again");
    }
  }

  Future<void> socialLoginButton(
      {required SocialMediaType socialMediaType}) async {
    SocialRepository socialRepository = _getObjectTypeOfSocailLoin(
        socialMediaType: socialMediaType); // to get the object
    DialogHelper.showLoading(
        message: 'يتم التحميل .....', textDirection: TextDirection.rtl);
    SocialServiceResponseModel socialServiceResponseModel =
        await SocialRepositoryMangerService()
            .login(socialRepository); // apply Polymarphism

    if (socialServiceResponseModel.status) {
      // SnackBarHelper.instance
      //     .showMessage(message: socialServiceResponseModel.message!);
      // checkUser
      await handelScoialAccountRouteProcess(
          providerId: socialServiceResponseModel.providerId!,
          providerType: socialServiceResponseModel
              .providertype!); // to show where the Next Route
    } else {
      SnackBarHelper.instance.showMessage(
          message: socialServiceResponseModel.message!, erro: true);
      DialogHelper.hideLoading(); // if any Erro Occur Close Dilag
    }

    /*
      How to Think The Logic:
          know the Object of socialMediaType to pass it to socialRepoitoryServiceManger
         1-  do ploymarphism and get the Provide Id of the Socail Type
         2- checkUser ? if exist  ,checkVerifyPhone or not ? go to Home Page : 
           if not exist got ot SignUpView , call Socail Login Service , then cache Token 
           then Verify Phone Number 
      */
  }

  Future<void> registerInformationOfSocial(
      {required SocialLoginModel socialLoginModel}) async {
    try {
      AuthModel? autModel =
          await _loginBySocialService(socialLoginModel: socialLoginModel);
      DialogHelper.hideLoading();
      if (autModel == null) return; // if any erro Occur

      CacheUserService.instance
          .updateUser(user: autModel.data!.user!); // to Cache User
      // // check Veify Phone or Not

      if (!autModel.data!.user!.phoneVerified!) {
        Get.offAllNamed(Routes.verifyPhoneView,
            arguments: autModel.data!.user!.phone);
      } else {
        Get.offAllNamed(Routes.bottomNavgation);
      }
    } catch (e) {
      DialogHelper.hideLoading();
      SnackBarHelper.instance.showMessage(message: e.toString(), erro: true);
    }
  }

  void contactUsRoute() {
    Get.toNamed(Routes.contactUs);
  }

  bool showThirdParty() {
    return CacheSettingsService.instance
                .getSettings()
                .settingsData!
                .showLoginThirdParty ==
            "1"
        ? true
        : false;
  }
}
