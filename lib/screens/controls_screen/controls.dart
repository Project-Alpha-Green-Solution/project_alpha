import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';

class ControlsPage extends StatefulWidget {
  const ControlsPage({super.key});

  @override
  State<ControlsPage> createState() => _ControlsPageState();
}

class _ControlsPageState extends State<ControlsPage> {
  bool bluetoothEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Controls',
          style: TextStyle(fontSize: 17.sp, color: themeColor),
        ),
      ),
      body: Center(
          child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 3.h),
            width: 90.w,
            height: 27.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(20)),
              border: Border.all(width: 1, color: themeColor),
              image: const DecorationImage(
                  image: AssetImage('assets/bluetooth.gif'),
                  fit: BoxFit.fitWidth),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 2.h),
            width: 90.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Enable Bluetooth:',
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      bluetoothEnabled = !bluetoothEnabled;
                    });
                  },
                  child: Icon(
                    bluetoothEnabled
                        ? Icons.toggle_on_outlined
                        : Icons.toggle_off_outlined,
                    size: 30.sp,
                    color: bluetoothEnabled ? themeColor : Colors.grey,
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
