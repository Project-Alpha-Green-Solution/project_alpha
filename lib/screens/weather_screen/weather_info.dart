import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';

class WeatherInfoPage extends StatefulWidget {
  const WeatherInfoPage({super.key, required this.dataValue});
  final String dataValue;

  @override
  State<WeatherInfoPage> createState() => _WeatherInfoPageState();
}

class _WeatherInfoPageState extends State<WeatherInfoPage> {
  final String info = "Weather conditions are essential to farmers because they have a direct impact on the growth, development, and yield of crops\nSunny weather: Sunny weather provides the necessary sunlight for photosynthesis and growth in plants, but it can also lead to heat stress and dehydration in crops.\nRainy weather: Rainy weather can provide much-needed moisture for crops, but excessive rainfall can lead to flooding and waterlogged soils, which can damage or kill crops.\nWindy weather: Windy weather can help to reduce humidity levels and prevent the growth of fungal diseases in crops, but strong winds can also damage or uproot crops.\nCloudy weather can reduce evaporation and slow down drying, conserving moisture in the soil and preventing dehydration in plants. However, it can also reduce sunlight, slowing down photosynthesis and delaying ripening in certain crops.\n";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightbg,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Weather',
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
                        FontAwesomeIcons.cloud,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 3.w),
                      child: Text(
                        'Current Weather: ',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.w),
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
                  style: TextStyle(fontSize: 17.sp, color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
