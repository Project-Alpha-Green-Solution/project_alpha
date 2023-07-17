import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';

class HumidityInfo extends StatefulWidget {
  const HumidityInfo({super.key, required this.dataValue});
  final String dataValue;

  @override
  State<HumidityInfo> createState() => _HumidityInfoState();
}

class _HumidityInfoState extends State<HumidityInfo> {
  final String info = "Humidity is the amount of moisture present in the air and it plays a crucial role in the growth and development of crops for farmers. The optimal range of humidity for crops is generally between 40% to 60%.\nIf the humidity level drops below 40%, the air becomes too dry, and this can cause dehydration in plants. This can lead to wilting, reduced growth, and poor crop yield. In extreme cases, the lack of moisture can cause plants to die.\nOn the other hand, if the humidity level rises above 60%, the air becomes too humid, and this can create favorable conditions for pests, diseases, and mold to develop. Additionally, if the humidity level is too high, plants may transpire less, which can lead to reduced nutrient uptake and slower growth.\nPossible solutions can be Irrigation, Mulching, Shading etc\n";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightbg,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Humidity',
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
                        FontAwesomeIcons.droplet,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 6.w),
                      child: Text(
                        'Humidity reading: ',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 9.w),
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
