import 'package:flutter/material.dart';
import 'package:projectalpha/constants.dart';
import 'package:projectalpha/screens/analytics_screen/analytics.dart';
import 'package:projectalpha/screens/home_screen/disease.dart';
import 'package:projectalpha/screens/weather_screen/weather.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../audio_manager.dart';
import '../../provider/language_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String language = '';
  bool speak = false;
  bool audioPlayed = false;

  // @override
  // void initState() {
  //   super.initState();
  //   // if (speak) {
  //   //   AudioManager.playAudio('audio/${language}/HomeScreen.wav');
  //   // }
  // }

  @override
  void dispose() {
    AudioManager.stopAudio();
    super.dispose();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final languageProvider = Provider.of<LanguageProvider>(context);
  //   final selectedLanguage = languageProvider.selectedLanguage;
  //   final audioTranslate = languageProvider.translateAudio;
  //   setState(() {
  //     speak = audioTranslate;
  //     language = selectedLanguage;
  //   });
  //   if (speak) {
  //     AudioManager.playAudio('audio/$language/HomeScreen.wav');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final selectedLanguage = languageProvider.selectedLanguage;
    final audioTranslate = languageProvider.translateAudio;
    speak = audioTranslate;
    language = selectedLanguage;

    // Check if the audio has not been played yet and audioTranslate is true
    if (speak) {
      AudioManager.playAudio('audio/$language/HomeScreen.wav');
      audioPlayed = true; // Set the flag to true to indicate that audio has been played
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 253, 244, 1),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Home',
          style: TextStyle(fontSize: 17.sp, color: themeColor),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Disease()),
                );
              },
              child: Container(
                margin: EdgeInsets.only(top: 5.h),
                height: 18.h,
                width: 85.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: themeColor,
                ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                      height: 15.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            image: AssetImage('assets/leaf-scan.gif'),
                            fit: BoxFit.fitWidth),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 7.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Scan leaf',
                            style: TextStyle(
                                fontSize: 16.5.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AnalyticsPage()),
                );
              },
              child: Container(
                margin: EdgeInsets.only(top: 5.h),
                height: 18.h,
                width: 85.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: themeColor,
                ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                      height: 15.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            image: AssetImage('assets/analytics.gif'),
                            fit: BoxFit.fitWidth),
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 1.5.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Farm Analytics',
                            style: TextStyle(
                                fontSize: 16.5.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WeatherPage()),
                );
              },
              child: Container(
                margin: EdgeInsets.only(top: 5.h),
                height: 18.h,
                width: 85.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: themeColor,
                ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                      height: 15.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            image: AssetImage('assets/weather.gif'),
                            fit: BoxFit.fitWidth),
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 2.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Weather Report',
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
