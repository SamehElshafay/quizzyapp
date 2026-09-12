import 'package:flutter/material.dart';
import 'package:quizzy_app/model/academic_year_model.dart';
import 'package:quizzy_app/utils/constant.dart';
import 'dart:math' as math;

import 'package:quizzy_app/utils/constant/exam_costant.dart';

class GeneralUtils {
  static GeneralUtils? _instance;
  static GeneralUtils get instance => _instance ??= GeneralUtils._();

  GeneralUtils._();

  String convertLoginEnumTypeToString(SourceLoginType sourceLoginType) {
    if (SourceLoginType.email == sourceLoginType) {
      return "email";
    } else {
      return "phone";
    }
  }

  Color generateColor() =>
      Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  String getGroupValueName({required int groupValue}) {
    return groupValue == 1 ? "قطاع غزة" : "الضفة الغربية";
  }

  Color convertColorToDark(Color color, [double amount = .1]) {
    var hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
        .toColor();
  }

  int? getAcademicYearById(
      {required List<AcademicYearModel> academicYearList,
      required String value}) {
    for (int i = 0; i < academicYearList.length; i++) {
      if (academicYearList[i].name == value) {
        return academicYearList[i].id!;
      }
    }

    return null;
  }

  List<String> convertAcdemicYearToListOfString(
      {required List<AcademicYearModel> academicYearList}) {
    return academicYearList.map((e) => e.name!).toList();
  }

  String convertSocialMediaEnumToString(SocialMediaType socialMediaType) {
    if (SocialMediaType.apple == socialMediaType) {
      return "apple";
    } else if (SocialMediaType.google == socialMediaType) {
      return "google";
    } else {
      return "facebook";
    }
  }

  SocialMediaType convertSocialMediaStringToEnum(String socialMediaType) {
    if ("apple" == socialMediaType) {
      return SocialMediaType.apple;
    } else if ("google" == socialMediaType) {
      return SocialMediaType.google;
    } else {
      return SocialMediaType.facebook;
    }
  }

  String convertLevelToArabic({required String value}) {
    if (value == ExamConstatnt.difficultLevel) {
      return "صعب";
    } else if (value == ExamConstatnt.mediumLevel) {
      return "متوسط";
    } else {
      return "سهل";
    }
  }
}
