import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../constants.dart';
import '../../../mongo_schema/schema.dart';
import '../../../mongodb.dart';

class RecentAnalysis extends StatefulWidget {
  const RecentAnalysis({Key? key}) : super(key: key);

  @override
  State<RecentAnalysis> createState() => _RecentAnalysisState();
}

class _RecentAnalysisState extends State<RecentAnalysis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightbg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Recent Analysis',
          style: TextStyle(fontSize: 17.sp, color: themeColor),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 100.w,
              height: 60.h,
              margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4,
                    offset: Offset(4, 8), // Shadow position
                  ),
                ],
              ),
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: MongoDatabase.fetchLastInsertedData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: themeColor,
                      ),
                    );
                  } else {
                    if (snapshot.hasData && snapshot.data != null) {
                      final List<Map<String, dynamic>>? data = snapshot.data;
                      final PlantDisease disease = PlantDisease.fromJson(data![0]);
                      return getRecentData(disease);
                    } else {
                      return Center(
                        child: Text(
                          'Data not found',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getRecentData(PlantDisease data) {
    return Column(
      children: [
        ListTile(
          title: Text(
            'Disease Name: ',
            style: TextStyle(
              color: themeColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            '${data.name}',
            style: TextStyle(
              color: themeColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ListTile(
          title: Text(
            'Plant Name: ',
            style: TextStyle(
              color: themeColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            '${data.plant}',
            style: TextStyle(
              color: themeColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
