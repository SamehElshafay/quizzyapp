import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizzy_app/Service/Firebase/social_service/repository/social_repository.dart';
import 'package:quizzy_app/model/social_service_response_model.dart';

import 'package:the_apple_sign_in/the_apple_sign_in.dart';

class AppleRepositoryService implements SocialRepository {
  @override
  Future<SocialServiceResponseModel> login() async {
    if (Platform.isAndroid) {
      print("YES IS Android");
      return Future.value(SocialServiceResponseModel(
          status: false, message: 'غير متاح تسجيل الدخول علي نظام الإندرويد'));
    }
    AuthorizationResult authorizationResult =
        await TheAppleSignIn.performRequests([
      const AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);

    switch (authorizationResult.status) {
      case AuthorizationStatus.authorized:
        print("authorized");
        try {
          AppleIdCredential? appleCredentials = authorizationResult.credential;

          OAuthProvider oAuthProvider = OAuthProvider("apple.com");
          OAuthCredential oAuthCredential = oAuthProvider.credential(
              idToken: String.fromCharCodes(appleCredentials!.identityToken!),
              accessToken:
                  String.fromCharCodes(appleCredentials.authorizationCode!));

          return SocialServiceResponseModel(
              status: true,
              providerId: appleCredentials.user,
              providertype: 'apple',
              message: 'تم تسجيل الدخول بنجاح');

          /*
Firebase Section:-
          OAuthProvider oAuthProvider = OAuthProvider("apple.com");
          OAuthCredential oAuthCredential = oAuthProvider.credential(
              idToken: String.fromCharCodes(appleCredentials!.identityToken!),
              accessToken:
                  String.fromCharCodes(appleCredentials.authorizationCode!));
          print(appleCredentials.email);
          print(appleCredentials.fullName);
          UserCredential userCredential =
              await FirebaseAuth.instance.signInWithCredential(oAuthCredential);
              if (userCredential.user != null) {
            Navigator.push(
                context, MaterialPageRoute(builder: (builder) => HomeScreen()));
          }

*/
        } catch (e) {
          print("apple auth failed $e");
        }

        break;
      case AuthorizationStatus.error:
        debugPrint("error" + authorizationResult.error.toString());
        return SocialServiceResponseModel(
            status: false,
            message: 'حدث خطأ \n ${authorizationResult.error.toString()}');

      case AuthorizationStatus.cancelled:
        print("cancelled");
        return SocialServiceResponseModel(
            status: false, message: 'حدث خطأ لقد قمت بإغلاق نافذة التسجيل');

      default:
        return SocialServiceResponseModel(
            status: false, message: 'حدث خطأ أثناء تسجيل الدخول');
        break;
    }
    return SocialServiceResponseModel(
        status: false, message: 'حدث خطأ أثناء تسجيل الدخول');
    // try {

    //   return Future.value(SocialServiceResponseModel(
    //       status: false,
    //       message: "غير متاح في نظام الإندرويد",
    //       providerId: "",
    //       providertype: ""));
    // } catch (e) {
    //   throw "غير متاح في نظام الإندرويد";
    // }
  }

  @override
  Future<bool> logout() async {
    await FirebaseAuth.instance.signOut();
    return true;
  }
}
