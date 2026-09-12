import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/view/custom_component/utlis/custom_multi_select_drop_down.dart';

class MultiSelectDropDownViewModel extends GetxController {
  List<String> _selectedItem = [];
  final List<String> _allItem = [
    "سؤال اختياري",
    "سؤال اختيار من متعدد",
    "سؤال صح وخطأ",
    "سؤال مقالي قصير",
    "سؤال مقالي طويل",
    "سؤال المقارنة",
  ];

  List<String> get allItem => _allItem;
  List<String> get selectedItem => _selectedItem;
  void itemChange(String value, bool isSelected) {
    if (isSelected) {
      _selectedItem.add(value);
    } else {
      _selectedItem.remove(value);
    }

    update();
    update(['updateWrapTypeOfQuestion']);
  }

  void removeElementFromWrap(String value) {
    _selectedItem.remove(value);
    update(['updateWrapTypeOfQuestion']);
  }

  void cancel() {
    _selectedItem = [];
    Get.back();
    update(['updateWrapTypeOfQuestion']);
  }

  void submit() {
    Get.back();
    update(['updateWrapTypeOfQuestion']);
  }

  void showMultiSelect(BuildContext context) async {
    // _selectedItem = [];
    // update();
    final List<String>? restults = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomMultiSelectDropDown(item: allItem);
        });

    if (restults != null) {
      _selectedItem = restults;
      update();
    }
  }

  List<String> getEnglishSelectedQuestion() {
    List<String> _listSelectEnglishQuestion = [];
/*
    "سؤال اختياري",
    "سؤال اختيار من متعدد",
    "سؤال صح وخطأ",
    "سؤال مقالي قصير",
    "سؤال مقالي طويل",
    "سؤال المقارنة",
*/ // single_choice,multiple_choice,true_false,short_answer,long_answer,compare
    for (var element in _selectedItem) {
      String message = '';
      switch (element) {
        case "سؤال اختياري":
          message = 'single_choice';
          break;
        case "سؤال اختيار من متعدد":
          message = 'multiple_choice';
          break;
        case "سؤال صح وخطأ":
          message = 'true_false';
          break;
        case "سؤال مقالي قصير":
          message = 'short_answer';
          break;
        case "سؤال مقالي طويل":
          message = "long_answer";
          break;
        case "سؤال المقارنة":
          message = "compare";
          break;
      }
      _listSelectEnglishQuestion.add(message);
    }
/*
[single_choice,multiple_choice,true_false,short_answer,long_answer,compare]
*/
    return _listSelectEnglishQuestion;
  }
}
