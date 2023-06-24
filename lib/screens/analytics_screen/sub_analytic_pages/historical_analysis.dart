import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sizer/sizer.dart';

import '../../../constants.dart';

class HistoricalAnalysis extends StatefulWidget {
  const HistoricalAnalysis({super.key});

  @override
  State<HistoricalAnalysis> createState() => _HistoricalAnalysisState();
}

class _HistoricalAnalysisState extends State<HistoricalAnalysis> {
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
    );
  }
}