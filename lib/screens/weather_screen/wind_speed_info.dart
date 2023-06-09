import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';

class WindSpeedInfo extends StatefulWidget {
  const WindSpeedInfo({super.key, required this.dataValue});
  final String dataValue;

  @override
  State<WindSpeedInfo> createState() => _WindSpeedInfoState();
}

class _WindSpeedInfoState extends State<WindSpeedInfo> {
  final String info = "Wind speed is an important factor that farmers must consider when managing their crops. By monitoring wind conditions and taking appropriate measures, such as staking or providing shelter, farmers can reduce the risk of crop damage and optimize their yields.\nWind speeds of up to 5 - 10 mph are generally considered safe for most crops. On the other hand, wind speed above 20 mph can have negative impacts on plant growth\n";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightbg,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Wind Speed',
          style: TextStyle(fontSize: 17.sp, color: themeColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 3.h),
                width: 90.w,
                height: 10.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15), color: themeColor),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 3.w),
                      child: FaIcon(
                        FontAwesomeIcons.wind,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 3.w),
                      child: Text(
                        'Wind speed reading: ',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 3.5.w),
                      child: Text(
                        widget.dataValue,
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 3.h),
                width: 90.w,
                child: Text(
                  info,
                  style: TextStyle(fontSize: 13.5.sp, color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
