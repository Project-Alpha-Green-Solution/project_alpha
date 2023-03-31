import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sizer/sizer.dart';

import '../../../constants.dart';

class GeneratedReport extends StatefulWidget {
  const GeneratedReport({super.key});

  @override
  State<GeneratedReport> createState() => _GeneratedReportState();
}

class _GeneratedReportState extends State<GeneratedReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'A.I Generated Report',
          style: TextStyle(fontSize: 17.sp, color: themeColor),
        ),
      ),
    );
  }
}