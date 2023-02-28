
import 'package:flutter/material.dart';
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
        title: Text('Analytics',
        style: TextStyle(
          fontSize: 17.sp,
          color: themeColor
        ),),
      ),
    );
  }
}