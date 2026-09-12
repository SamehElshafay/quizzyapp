import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/utils/constant.dart';
import 'package:quizzy_app/utils/general_utils.dart';
import 'package:quizzy_app/utils/validation.dart';
import 'package:quizzy_app/view/custom_component/custom_text.dart';

class SnackBarHelper {
  SnackBarHelper._();
  static SnackBarHelper? _instance;

  static SnackBarHelper get instance => _instance ??= SnackBarHelper._();

  showMessage(
      {required String message,
      int milliseconds = 2000,
      bool erro = false,
      bool showByGetx = false,
      bool isEnglish = true}) {
    if (showByGetx) {
      // By Getx
      Get.showSnackbar(GetSnackBar(
        snackPosition: SnackPosition.TOP,
        duration: Duration(milliseconds: milliseconds),
        backgroundColor: erro ? Colors.deepOrange : Colors.deepPurple,
        borderRadius: 14,
        messageText: CustomText(
          text: message,
          color: Colors.white,
          textDirection: Validation.instance.isEnglishText(text: message)
              ? TextDirection.ltr
              : TextDirection.rtl,
        ),
      ));
    } else {
      ScaffoldMessenger.of(navigatorKey.currentState!.context)
          .showSnackBar(SnackBar(
        elevation: 0.0,
        backgroundColor: erro ? Colors.deepOrange : Colors.deepPurple,

        //behavior: SnackBarBehavior.floating,

        content: Text(
          message,
          textDirection: Validation.instance.isEnglishText(text: message)
              ? TextDirection.ltr
              : TextDirection.rtl,
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(milliseconds: milliseconds),

        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
        ),
        //backgroundColor: Colors.redAccent,
        // action: SnackBarAction(
        //   textColor: Color(0xFFFAF2FB),
        //   label: 'OK',
        //   onPressed: () {},
        // ),
      ));
    }

/*

By Default:-

    ScaffoldMessenger.of(navigatorKey.currentState!.context)
        .showSnackBar(SnackBar(
      elevation: 0.0,
      backgroundColor: erro ? Colors.deepOrange : Colors.deepPurple,
      //behavior: SnackBarBehavior.floating,

      content: Text(
        message,
        textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
      ),
      duration: Duration(milliseconds: milliseconds),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
      ),
      //backgroundColor: Colors.redAccent,
      // action: SnackBarAction(
      //   textColor: Color(0xFFFAF2FB),
      //   label: 'OK',
      //   onPressed: () {},
      // ),
    ));*/
  }
}
