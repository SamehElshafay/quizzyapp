import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  Future<XFile?> pickFromCamera() async {
    try {
      return await ImagePicker().pickImage(source: ImageSource.camera);
    } catch (e, s) {
      debugPrint(s.toString());
      throw s.toString();
    }
  }

  Future<XFile?> pickFromgGallery() async {
    try {
      return await ImagePicker().pickImage(source: ImageSource.gallery);
    } catch (e, s) {
      debugPrint(s.toString());
      throw s.toString();
    }
  }
}
