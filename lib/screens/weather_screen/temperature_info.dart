import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';

class TemperatureInfo extends StatefulWidget {
  const TemperatureInfo({super.key, required this.dataValue});
  final String dataValue;

  @override
  State<TemperatureInfo> createState() => _TemperatureInfoState();
}

class _TemperatureInfoState extends State<TemperatureInfo> {
  final String info = "Temperature is a critical factor that concerns farmers because it affects the growth and development of crops. The optimal temperature range for crop growth depends on the specific crop, but in general, most crops grow best within a temperature range of 15°C to 30°C.\nIf the temperature is too low, below 10°C, it can lead to slow or stunted growth in crops. \nIf the temperature is too high, above 35°C, it can cause heat stress in crops.\n Possible solutions can be irrigation or use of shades when temperature is high and sprinkling water on crops when temperature is low.\n";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightbg,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Temperature',
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
                        FontAwesomeIcons.temperatureHalf,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 3.w),
                      child: Text(
                        'Temperature reading: ',
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
