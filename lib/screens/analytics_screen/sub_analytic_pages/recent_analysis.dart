import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sizer/sizer.dart';

import '../../../constants.dart';

class RecentAnalysis extends StatefulWidget {
  const RecentAnalysis({super.key});

  @override
  State<RecentAnalysis> createState() => _RecentAnalysisState();
}

class _RecentAnalysisState extends State<RecentAnalysis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Recent Analysis',
          style: TextStyle(fontSize: 17.sp, color: themeColor),
        ),
      ),
    );
  }
}