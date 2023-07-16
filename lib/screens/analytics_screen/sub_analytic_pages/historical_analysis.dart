import 'package:flutter/material.dart';
import 'package:projectalpha/mongodb.dart';
import 'package:sizer/sizer.dart';
import 'package:slide_switcher/slide_switcher.dart';

import '../../../constants.dart';
import '../../../mongo_schema/schema.dart';

class HistoricalAnalysis extends StatefulWidget {
  const HistoricalAnalysis({Key? key}) : super(key: key);

  @override
  State<HistoricalAnalysis> createState() => _HistoricalAnalysisState();
}

class _HistoricalAnalysisState extends State<HistoricalAnalysis> {
  List<Map<String, dynamic>> _dataList = []; // List to store fetched data
  int switcherIndex1 = 0;

  @override
  void initState() {
    super.initState();
    MongoDatabase.getPlantDiseases();
    // fetchData(); // Fetch data when the widget is initialized
  }

  Future<void> fetchData() async {
    // Your database fetching logic here
    final data = await MongoDatabase.getPlantDiseases();
    setState(() {
      _dataList = data as List<Map<String, dynamic>>;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Past Analysis',
          style: TextStyle(fontSize: 17.sp, color: themeColor),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SlideSwitcher(
              children: [
                Text(
                  'Plant Disease Data',
                  style: TextStyle(
                    color: themeColor,
                  ),
                ),
                Text(
                  'Soil Data',
                  style: TextStyle(
                    color: themeColor,
                  ),
                ),
              ],
              containerColor: lightbg,
              onSelect: (index) => setState(() => switcherIndex1 = index),
              containerHeight: 40,
              containerWight: 350,
            ),
            const SizedBox(height: 20),
            if (switcherIndex1 == 0) ...[
              Center(
                child: _dataList.isNotEmpty
                    ? ListView.builder(
                        itemCount: _dataList.length,
                        itemBuilder: (context, index) {
                          final item = _dataList[index];
                          final diseaseName = PlantDisease.fromJson(
                              item as Map<String, dynamic>);
                          return getPastData(diseaseName);
                        },
                      )
                    : CircularProgressIndicator(), // Show a loading indicator if data is being fetched
              ),
            ] else ...[
              Center(
                child: _dataList.isNotEmpty
                    ? ListView.builder(
                        itemCount: _dataList.length,
                        itemBuilder: (context, index) {
                          final item = _dataList[index];
                          final diseaseName = PlantDisease.fromJson(
                              item as Map<String, dynamic>);
                          return getPastData(diseaseName);
                        },
                      )
                    : CircularProgressIndicator(), // Show a loading indicator if data is being fetched
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget getPastData(PlantDisease data) {
    return Container(
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
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                const Icon(
                  Icons.circle,
                  color: Colors.red,
                  size: 15,
                ),
                Text(
                  ' Disease: ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '${data.name}',
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
                  ' Soil Nutrient:  ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  ' Healthy',
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
                  ' Soil Moisture: ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  ' 50% ',
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
    );
  }
}
