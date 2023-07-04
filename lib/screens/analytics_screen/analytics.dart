import 'package:flutter/material.dart';
import 'package:projectalpha/mongodb.dart';
import 'package:projectalpha/screens/analytics_screen/sub_analytic_pages/generated_report.dart';
import 'package:projectalpha/screens/analytics_screen/sub_analytic_pages/historical_analysis.dart';
import 'package:projectalpha/screens/analytics_screen/sub_analytic_pages/recent_analysis.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../audio_manager.dart';
import '../../constants.dart';
import '../../provider/language_provider.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  var myRequest;

  String language = '';
  bool speak = false;
  bool audioPlayed = false;

  // @override
  // void initState() {
  //   super.initState();
  //   loadData();
  //   // if (speak) {
  //   //   AudioManager.playAudio('audio/${language}/AnalyticsScreen.wav');
  //   // }
  // }

  @override
  void dispose() {
    AudioManager.stopAudio();
    super.dispose();
  }

  Future<void> loadData() async {
    try {
      Map<String, dynamic>? plantData =
          await MongoDatabase.getPlantDiseaseData();
      Map<String, dynamic>? weatherData = await MongoDatabase.getWeatherData();
      if (plantData != null && weatherData != null) {
        myRequest =
            'For my agric IoT app, generate a comprehensive report per the data I gathered from the farm. The data might include the following. Plant, detected plant disease, weather readings and readings from the soil.  Your report should include the analysis you have made from the data provided and also possible solutions for problems identified from the data provided. For instance, you should provide a solution to the disease detected or even tell the farmer what to do in case the soil readings mean the farm is not doing well. You should also provide a weather forecast per the weather data provided. The data is as follows: Plant: ${plantData['plant']}, Detected disease name: ${plantData['name']}, Temperature: ${weatherData['temperature']}, Weather: ${weatherData['weather']}, Humidity: ${weatherData['humidity']}';
        // print(myRequest);
      } else {
        print("No data found");
      }
    } catch (e) {
      print("Error fetching data");
    }
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
  //     AudioManager.playAudio('audio/$language/AnalyticsScreen.wav');
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
      AudioManager.playAudio('audio/$language/AnalyticsScreen.wav');
      audioPlayed = true; // Set the flag to true to indicate that audio has been played
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Analytics',
          style: TextStyle(fontSize: 17.sp, color: themeColor),
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RecentAnalysis()),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(top: 3.h),
                  width: 90.w,
                  height: 21.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 4,
                        offset: Offset(4, 8), // Shadow position
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Recent Analysis',
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: themeColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const Divider(
                        thickness: 1.5,
                        color: themeColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.circle,
                              color: Colors.red,
                              size: 15,
                            ),
                            Text(
                              ' Disease Status ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.circle,
                              color: Colors.brown,
                              size: 15,
                            ),
                            Text(
                              ' Soil Nutrient ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.circle,
                              color: Colors.blue,
                              size: 15,
                            ),
                            Text(
                              ' Soil Moisture',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
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
                        builder: (context) => const HistoricalAnalysis()),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(top: 3.h),
                  width: 90.w,
                  height: 21.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 4,
                        offset: Offset(4, 8), // Shadow position
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Past Analysis',
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: themeColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const Divider(
                        thickness: 1.5,
                        color: themeColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.circle,
                              color: Colors.red,
                              size: 15,
                            ),
                            Text(
                              ' Disease Status ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.circle,
                              color: Colors.brown,
                              size: 15,
                            ),
                            Text(
                              ' Soil Nutrient ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.circle,
                              color: Colors.blue,
                              size: 15,
                            ),
                            Text(
                              ' Soil Moisture ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
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
                        builder: (context) => GeneratedReport(
                              request: myRequest,
                            )),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(top: 3.h),
                  width: 90.w,
                  height: 21.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 4,
                        offset: Offset(4, 8), // Shadow position
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          'A.I Generated Report',
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: themeColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Divider(
                        thickness: 1.5,
                        color: themeColor,
                      ),
                      Text(
                        'Get A.I generated report of your farm. This report covers deep analysis made with the data collected from your farm. With a backend support from ChatGPT, this report also comes with effective measures you can take to boost crop yield.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 10.3.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
