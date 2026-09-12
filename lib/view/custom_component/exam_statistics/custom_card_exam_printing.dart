import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:quizzy_app/view_model/utils/theme/theme_view_model.dart';

pw.Column customStatatistcText(
    {required String numbertext, required String text, PdfColor? color}) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.end,
    children: [
      pw.Row(
        children: [
          customTextPrinting(
              text: numbertext,
              fontWeight: pw.FontWeight.bold,
              color: color,
              fontSize: 20),
          pw.SizedBox(width: 10),
          pw.Container(
            width: 12,
            height: 12,
            decoration: pw.BoxDecoration(
              shape: pw.BoxShape.circle,
              color: color,
            ),
          ),
        ],
      ),
      customTextPrinting(
        text: text,
        fontWeight: pw.FontWeight.normal,
        fontSize: 16,
      )
    ],
  );
}

pw.Text customTextPrinting(
    {required String text,
    pw.FontWeight? fontWeight,
    PdfColor? color,
    double? fontSize}) {
  return pw.Text(text,
      style: pw.TextStyle(
          fontWeight: fontWeight, fontSize: fontSize, color: color));
}

pw.Center customCardExamResultPrinting(
    {required String totalQuestions,
    required String numberWrongAnswer,
    required String numberCorrectAnswer}) {
  return pw.Center(
    child: pw.Container(
      // width: 305.w,
      // height: 250.h,
      alignment: pw.Alignment.center,
      decoration: pw.BoxDecoration(
          // boxShadow: <pw.BoxShadow>[
          //   pw.BoxShadow(
          //     spreadRadius: 0,
          //     blurRadius: 5,
          //     color: Get.find<ThemeViewMode>().isDarkMode()
          //         ? PdfColors.cyan
          //         : PdfColors.black,
          //     //  color: Colors.white30
          //   ),
          // ],
          borderRadius: pw.BorderRadius.circular(30),
          color:
              Get.find<ThemeViewMode>().isDarkMode() ? null : PdfColors.white),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
        children: [
          pw.Column(
            mainAxisSize: pw.MainAxisSize.min,
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              customStatatistcText(
                text: 'اكتمل الاختبار',
                numbertext: "100%",
                color: PdfColors.blue400,
              ),
              pw.SizedBox(height: 30),
              customStatatistcText(
                  text: 'اجابة صحيحة',
                  numbertext: numberCorrectAnswer,
                  color: PdfColors.green), // (47, 210, 28, 255)
            ],
          ),
          pw.Column(
            mainAxisSize: pw.MainAxisSize.min,
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              customStatatistcText(
                text: 'مجموع الاسئلة',
                numbertext: totalQuestions,
                color: PdfColors.blue400, // (73, 150, 191, 255),
              ),
              pw.SizedBox(height: 30),
              customStatatistcText(
                  text: 'اجابة خاطئة',
                  numbertext: numberWrongAnswer,
                  color: PdfColors.redAccent),
            ],
          )
        ],
      ),
    ),
  );
}
