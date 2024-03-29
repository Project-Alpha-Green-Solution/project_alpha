import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';
import '../../sendSMS.dart';
import '../auth_screens/utils.dart';

class ControlsPage extends StatefulWidget {
  const ControlsPage(
      {Key? key,
      required this.sendMessage1,
      required this.sendMessage2,
      required this.sendMessage3,
      required this.sendMessage4,
      required this.sendMessage5,
      required this.sendMessage6,
      required this.sendMessage7,
      required this.sendMessage8,
      required this.sendMessage9})
      : super(key: key);

  final Function sendMessage1;
  final Function sendMessage2;
  final Function sendMessage3;
  final Function sendMessage4;
  final Function sendMessage5;
  final Function sendMessage6;
  final Function sendMessage7;
  final Function sendMessage8;
  final Function sendMessage9;

  @override
  State<ControlsPage> createState() => _ControlsPageState();
}

class _ControlsPageState extends State<ControlsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 5.h,
            ),
            Stack(children: [
              Container(
                width: 225,
                height: 225,
                margin: EdgeInsets.fromLTRB(10, 10, 10, 35),
                decoration: BoxDecoration(
                  color: lightbg,
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4,
                      offset: Offset(4, 8), // Shadow position
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 27.w,
                top: 1.h,
                child: GestureDetector(
                  onTap: () {
                    widget.sendMessage1();
                  },
                  child: Container(
                    width: 14.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: themeColor,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          offset: Offset(4, 8), // Shadow position
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.arrow_upward_rounded,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 27.w,
                top: 9.5.h,
                child: GestureDetector(
                  onTap: () {
                    widget.sendMessage9();
                  },
                  child: Container(
                    width: 14.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: themeColor,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          offset: Offset(4, 8), // Shadow position
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.stop,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 9.5.h,
                left: 9.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                    widget.sendMessage4();
                  },
                      child: Container(
                        width: 14.w,
                        height: 14.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: themeColor,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 4,
                              offset: Offset(4, 8), // Shadow position
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.chevron_left_rounded,
                          color: Colors.white,
                          size: 25.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 22.w,
                    ),
                    GestureDetector(
                      onTap: () {
                    widget.sendMessage2();
                  },
                      child: Container(
                        width: 14.w,
                        height: 14.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: themeColor,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 4,
                              offset: Offset(4, 8), // Shadow position
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.white,
                          size: 25.sp,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                left: 27.w,
                top: 18.h,
                child: GestureDetector(
                  onTap: () {
                    widget.sendMessage3();
                  },
                  child: Container(
                    width: 14.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: themeColor,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          offset: Offset(4, 8), // Shadow position
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.arrow_downward_rounded,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                ),
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    widget.sendMessage5();
                    sendSMS();
                    Utils.successSnackBar(
                          'THE SYSTEM WILL START IRRIGATION SOON');
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 3.h),
                    width: 43.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                      color: themeColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          offset: Offset(4, 8), // Shadow position
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.pest_control,
                          color: lightbg,
                          size: 25.sp,
                        ),
                        Text(
                          "Spray Crops",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.sendMessage6();
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 3.h),
                    width: 43.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                      color: themeColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          offset: Offset(4, 8), // Shadow position
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          color: lightbg,
                          size: 25.sp,
                        ),
                        Text(
                          "Capture Images",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    widget.sendMessage7();
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 3.h),
                    width: 43.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                      color: themeColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          offset: Offset(4, 8), // Shadow position
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.health_and_safety,
                          color: lightbg,
                          size: 25.sp,
                        ),
                        Text(
                          "Check Soil Health",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.sendMessage8();
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 3.h),
                    width: 43.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                      color: themeColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          offset: Offset(4, 8), // Shadow position
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.navigation_rounded,
                          color: lightbg,
                          size: 25.sp,
                        ),
                        Text(
                          "Auto Pilot",
                          style: TextStyle(
                              fontSize: 13.5.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
