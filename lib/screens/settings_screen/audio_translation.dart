import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';
import '../../provider/language_provider.dart';

class AudioTranslation extends StatefulWidget {
  const AudioTranslation({super.key});

  @override
  State<AudioTranslation> createState() => _AudioTranslationState();
}

class _AudioTranslationState extends State<AudioTranslation> {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final translateAudio = languageProvider.translateAudio;
    final selectedLanguage = languageProvider.selectedLanguage;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Audio Translation',
          style: TextStyle(fontSize: 17.sp, color: themeColor),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            ListTile(
              title: Text(
                'Audio Translation',
                style: TextStyle(fontSize: 15.sp, color: Colors.black),
              ),
              trailing: Switch(
                  value: translateAudio,
                  onChanged: (value) => languageProvider.AudioTranslate()),
            ),
            Text('Select Language:'),
            DropdownButton<String>(
              value: selectedLanguage,
              onChanged: (newValue) {
                languageProvider.updateSelectedLanguage(newValue!);
              },
              items: [
                DropdownMenuItem(
                  value: 'English',
                  child: Text('English'),
                ),
                DropdownMenuItem(
                  value: 'Twi',
                  child: Text('Twi'),
                ),
                DropdownMenuItem(
                  value: 'Ewe',
                  child: Text('Ewe'),
                ),
                DropdownMenuItem(
                  value: 'Frafra',
                  child: Text('Frafra'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
