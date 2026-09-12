import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';

class PdfConverter {
  static Future<String?> convertToImage(String pdfPath) async {
    PdfDocument doc = await PdfDocument.openFile(pdfPath);
    PdfPage page = await doc.getPage(1);

    final PdfPageImage? pageImg = await page.render(
        width: 575, height: page.height + 200, backgroundColor: "#ffffff");

    if (pageImg != null) {
      String path = (await getApplicationDocumentsDirectory()).path;
      File file = File(path +
          "/${DateTime.now().microsecondsSinceEpoch}examStatsticsPhoto.png");
      print(file.path);
      await file.writeAsBytes(pageImg.bytes);

      return file.path;
    }

    return null;
  }
}
