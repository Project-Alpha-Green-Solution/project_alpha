import 'package:flutter/material.dart';
import 'package:projectalpha/screens/analytics_screen/sub_analytic_pages/generated_report.dart';
import 'package:projectalpha/screens/analytics_screen/sub_analytic_pages/historical_analysis.dart';
import 'package:projectalpha/screens/analytics_screen/sub_analytic_pages/recent_analysis.dart';
import 'package:projectalpha/screens/analytics_screen/sub_analytic_pages/visual_report.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  MaterialPageRoute(builder: (context) => const RecentAnalysis()),
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
                            fontSize: 17.sp,
                            color: themeColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const Divider(
                        thickness: 1.5,
                        color: themeColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.circle, color: Colors.red, size: 15,),
                            Text(
                          ' Disease Status: ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'None',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.black,),
                        ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.circle, color: Colors.brown, size: 15,),
                            Text(
                          ' Soil Nutrient: ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Healthy',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.black,),
                        ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.circle, color: Colors.blue, size: 15,),
                            Text(
                          ' Soil Moisture: ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Normal',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.black,),
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
                  MaterialPageRoute(builder: (context) => const HistoricalAnalysis()),
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
                        'Historical Analysis',
                        style: TextStyle(
                            fontSize: 17.sp,
                            color: themeColor,
                            fontWeight: FontWeight.bold
                            ),
                      ),
                      const Divider(
                        thickness: 1.5,
                        color: themeColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.circle, color: Colors.red, size: 15,),
                            Text(
                          ' Disease Status ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.black,
                              ),
                        ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.circle, color: Colors.brown, size: 15,),
                            Text(
                          ' Soil Nutrient ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.black,
                              ),
                        ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.circle, color: Colors.blue, size: 15,),
                            Text(
                          ' Soil Moisture ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.black,
                              ),
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
                  MaterialPageRoute(builder: (context) => const GeneratedReport()),
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
                        'A.I Generated Report',
                        style: TextStyle(
                            fontSize: 17.sp,
                            color: themeColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const Divider(
                        thickness: 1.5,
                        color: themeColor,
                      ),
                      Text(
                        'Get A.I generated report of your farm. This report covers deep analysis made with the data collected from your farm. With a backend support from ChatGPT, this report also comes with effective measures you can take to boost crop yield.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12.5.sp,
                            color: Colors.black,),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const VisualAnalysis()),
                );
              },
                child: Container(
                  margin: EdgeInsets.only(top: 3.h, bottom: 3.h),
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
                        'Visual Analysis',
                        style: TextStyle(
                            fontSize: 17.sp,
                            color: themeColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const Divider(
                        thickness: 1.5,
                        color: themeColor,
                      ),
                      Container(
                          margin: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                          height: 11.h,
                          width: 40.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                                image: AssetImage('assets/analytic_data.gif'),
                                fit: BoxFit.fitWidth),
                            color: Colors.white,
                          ),
                        ),
                    ],
                  ),
                ),
              )],
          ),
        ),
      ),
    );
  }
}
