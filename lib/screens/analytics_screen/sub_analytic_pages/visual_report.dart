import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sizer/sizer.dart';

import '../../../constants.dart';

class VisualAnalysis extends StatefulWidget {
  const VisualAnalysis({super.key});

  @override
  State<VisualAnalysis> createState() => _VisualAnalysisState();
}

class _VisualAnalysisState extends State<VisualAnalysis> {
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
    );
  }
}