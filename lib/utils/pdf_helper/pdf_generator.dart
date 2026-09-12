import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import 'package:pdfx/pdfx.dart' as pdfx;
import 'package:quizzy_app/model/exam_attempt_model.dart';
import 'package:quizzy_app/utils/app_images.dart';
import 'package:quizzy_app/utils/pdf_helper/pdf_converter_to_image.dart';

import 'package:quizzy_app/view/custom_component/exam_statistics/custom_card_exam_printing.dart';
import 'dart:io';

import 'package:quizzy_app/view_model/exam/manage_exam_view_model.dart';
import 'package:quizzy_app/view_model/utils/theme/theme_view_model.dart';

class PdfGenerator {
  static late Font arFont;

  //////////////////// Image ////////////////////
  static late Uint8List? logobytes;
  static late Uint8List? textImagebytes;

  //////////////////// Image ////////////////////
  ///
  static void initLoadAssetImage() async {
    ByteData _bytes = await rootBundle.load(Assets.imagesLogoImage);
    logobytes = (_bytes).buffer.asUint8List();
    ByteData _bytesText = await rootBundle.load(Assets.imagesLogoText);
    textImagebytes = (_bytesText).buffer.asUint8List();
  }

  static init() async {
    arFont =
        pw.Font.ttf((await rootBundle.load("assets/fonts/Cairo-Regular.ttf")));
    initLoadAssetImage();
  }

  static Future<String> createPdf(
      {required String studentName,
      required String subjectName,
      required ExamAttemptModel examAttemptStatisticsInofrmation,
      bool convertImage = false}) async {
    String path = (await getTemporaryDirectory()).path;
    File file = File(
        path + "/${DateTime.now().microsecondsSinceEpoch}examStatsticsPdf.pdf");

    pw.Document pdf = pw.Document();
    pdf.addPage(_createPage(
        studentName: studentName,
        subjectName: subjectName,
        examAttemptStatisticsInofrmation: examAttemptStatisticsInofrmation));

    Uint8List bytes = await pdf.save();
    await file.writeAsBytes(bytes);
    //  createImg(file.path);
    print(file.path);
    // await pdfx.PdfDocument.openFile(file.path);
    if (!convertImage) {
      await OpenFile.open(file.path);
    }

    return file.path;
  }

/*
                    CustomCardExamResult(
                      numberCorrectAnswer: controller
                          .examAttemptStatisticsInofrmation.numberCorrectAnswer
                          .toString(),
                      numberWrongAnswer: controller
                          .examAttemptStatisticsInofrmation.numberWrongAnswer
                          .toString(),
                      totalQuestions: controller
                          .examAttemptStatisticsInofrmation.totalQuestions
                          .toString(),
                    ),

*/

  static pw.Page _createPage(
      {required ExamAttemptModel examAttemptStatisticsInofrmation,
      required String studentName,
      required String subjectName}) {
    return pw.Page(
        textDirection: pw.TextDirection.rtl,
        theme: pw.ThemeData.withFont(
          base: arFont,
        ),
        pageFormat: PdfPageFormat.standard,
        build: (pw.Context context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
                textImagebytes != null
                    ? pw.Image(pw.MemoryImage(textImagebytes!))
                    : pw.Container(),
                logobytes != null
                    ? pw.Image(pw.MemoryImage(logobytes!))
                    : pw.Container(),
              ]),
              pw.SizedBox(height: 30),
              pw.Padding(
                  child: customCardExamResultPrinting(
                      totalQuestions: examAttemptStatisticsInofrmation
                          .totalQuestions
                          .toString(),
                      numberCorrectAnswer: examAttemptStatisticsInofrmation
                          .numberCorrectAnswer
                          .toString(),
                      numberWrongAnswer: examAttemptStatisticsInofrmation
                          .numberWrongAnswer
                          .toString()),
                  padding: pw.EdgeInsets.only(left: 70)),
              pw.SizedBox(height: 50),
              pw.Text(
                  "تنص منصة Quizzy علي أن الطالب $studentName قد حصل علي هذه الدرجة في مادة  $subjectName",
                  style: pw.TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  )),
              pw.SizedBox(height: 30),
              pw.Text(
                  "يُعتمد هذا بتاريخ اليوم الموافق : ${DateFormat.yMMMMEEEEd().format(DateTime.now())}",
                  style: pw.TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: PdfColors.red)),
            ],
          );

          // return pw.CustomCardExamResult(
          //   numberCorrectAnswer: '',
          //   numberWrongAnswer: '',
          //   totalQuestions: '',
          // );
        });
  }

  static Future<String?> createImg({
    required ExamAttemptModel examAttemptStatisticsInofrmation,
    required String studentName,
    required String subjectName,
  }) async {
    String path = await createPdf(
        studentName: studentName,
        subjectName: subjectName,
        examAttemptStatisticsInofrmation: examAttemptStatisticsInofrmation,
        convertImage: true);
    return await PdfConverter.convertToImage(path);
  }
}
