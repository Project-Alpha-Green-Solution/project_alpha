import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  String _selectedLanguage = 'English';
  bool _translateText = false;
  bool _translateAudio = false;

  String get selectedLanguage => _selectedLanguage;
  bool get translateText => _translateText;
  bool get translateAudio => _translateAudio;

  void updateSelectedLanguage(String language) {
    _selectedLanguage = language;
    notifyListeners();
  }

  void AudioTranslate() {
    _translateAudio = !translateAudio;
    notifyListeners();
  }

  void TextTranslate() {
    _translateText = !translateText;
    notifyListeners();
  }
}
