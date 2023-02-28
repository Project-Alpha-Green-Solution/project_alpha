import 'package:flutter/material.dart';
import 'package:projectalpha/constants.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Home',
          style: TextStyle(fontSize: 17.sp, color: themeColor),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 5.h),
              height: 18.h,
              width: 85.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: themeColor,
              ),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                    height: 15.h,
                    width: 30.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                          image: AssetImage('assets/leaf-scan.gif'),
                          fit: BoxFit.fitWidth),
                      //color: Colors.white,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 7.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Scan leaf',
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.h),
              height: 18.h,
              width: 85.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: themeColor,
              ),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                    height: 15.h,
                    width: 30.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                          image: AssetImage('assets/analytics.gif'),
                          fit: BoxFit.fitWidth),
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 1.5.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Farm Ananlytics',
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.h),
              height: 18.h,
              width: 85.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: themeColor,
              ),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                    height: 15.h,
                    width: 30.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                          image: AssetImage('assets/weather.gif'),
                          fit: BoxFit.fitWidth),
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 2.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Weather Report',
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
