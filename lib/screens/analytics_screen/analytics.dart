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
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    // MongoDatabase.deleteDocuments();
    loadData();
  }

  Future<void> loadData() async {
    try {
      Map<String, dynamic>? plantData =
          await MongoDatabase.getPlantDiseaseData();
      Map<String, dynamic>? weatherData = await MongoDatabase.getWeatherData();
      Map<String, dynamic>? soilData = await MongoDatabase.getRecentSoilData();
      if (plantData != null && weatherData != null && soilData != null) {
        myRequest =
            'For my agric IoT app called AgroGuard, generate a comprehensive report per the data gathered from the farm. The data might include the following. Plant, detected plant disease, weather readings and readings from the soil.  Your report should include a short analysis you have made from the data provided and also possible solutions for problems identified from the data provided. For instance, you should provide a solution to the disease detected or even tell the farmer what to do in case the soil readings mean the farm is not doing well. You should also provide a weather forecast per the weather data provided whether it will rain or not in the next 24 hours. The data is as follows: Plant: ${plantData['plant']}, Disease: ${plantData['name']}, Temperature: ${weatherData['temperature']}, Weather: ${weatherData['weather']}, Humidity: ${weatherData['humidity']}. The soil readings are also as follows. Soil moisture(might be null): ${soilData['moisture']}, soil nitrogen content(might be null): ${soilData['nitrogen']}, soil phosphorus content(might be null): ${soilData['phosphorus']}, soil potassium content(might be null): ${soilData['potassium']}, Note that the soil nutrient content for each nutrient is mapped from 0-255 and the soil moisture comes in ranges; 1-175 means dry soil, 175-350 means little moisture, 350-525 means good moisture content, 525-700 means very wet soil, 700-876 means too wet. In order to save time, do not repeat the data gathered before producing your analysis.';
        print(myRequest);
      } else {
        print("No data found");
      }
    } catch (e) {
      print("Error fetching data");
    }
  }

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
      audioPlayed =
          true; // Set the flag to true to indicate that audio has been played
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
        actions: [
          if (speak)
            IconButton(
              icon: Icon(isPaused ? Icons.pause_sharp : Icons.play_arrow,
                  color: themeColor, size: 20),
              onPressed: () {
                setState(() {
                  isPaused = !isPaused;
                });
                if (isPaused) {
                  AudioManager.pauseAudio();
                }
                if (!isPaused) {
                  AudioManager.resumeAudio('audio/$language/HomeScreen.wav');
                }
              },
            ),
        ],
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
