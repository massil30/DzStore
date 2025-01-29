import 'package:flutter/material.dart';

class Translate with ChangeNotifier {
  bool isEn = true;
  Map<String, String> textArab = {
    "language": "العربية",
    "settings": "الاعدادات",
    "hello": "salam"
  };
  Map<String, String> textEnglish = {
    "language": "English",
    "settings": "Settings",
    "hello": "hi"
  };
  changeLan(bool lan) {
    isEn = lan;
    notifyListeners();
  }

  getTexts(text) {
    if (isEn == true) {
      return textEnglish[text];
    } else {
      return textArab[text];
    }
  }
}
