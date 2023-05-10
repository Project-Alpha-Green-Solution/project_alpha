// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projectalpha/screens/weather_screen/temperature_info.dart';
import 'package:projectalpha/screens/weather_screen/weather.dart';
import 'package:projectalpha/screens/weather_screen/weather_info.dart';
import 'package:projectalpha/screens/weather_screen/wind_speed_info.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';
import 'humidity_info.dart';

class MainWidget extends StatelessWidget {
  final temp;
  final description;
  final currently;
  final humidity;
  final windSpeed;
  final location;

  const MainWidget(
      {super.key,
      @required this.temp,
      @required this.description,
      @required this.currently,
      @required this.humidity,
      @required this.windSpeed,
      @required this.location});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Container(
            width: 90.w,
            height: 27.h,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 216, 216, 216),
                    offset: Offset(
                      5.0,
                      5.0,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  )
                ]),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 5, 10),
                  height: 25.h,
                  width: 45.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                        image: AssetImage('assets/all-weather.gif'),
                        fit: BoxFit.fitHeight),
                    //color: Colors.white,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                      direction: Axis.vertical,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, right: 6.0),
                          child: Text(
                            '$location',
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, right: 1.0),
                          child: Text(
                            temp != null
                                ? '${temp.toInt().toString()}\u00B0'
                                : 'loading',
                            style: TextStyle(
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            )),
        Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
          child: Text(
            'Additional Info',
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: themeColor),
          ),
        ),
        SizedBox(
          width: 90.w,
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TemperatureInfo(
                            dataValue: temp.toString(),
                          )));
                },
                leading: FaIcon(
                  FontAwesomeIcons.temperatureHalf,
                  color: themeColor,
                  size: 20.sp,
                ),
                title: Text(
                  'Temperature',
                  style: TextStyle(fontSize: 16.sp),
                ),
                trailing: Text(
                  temp != null ? '${temp.toInt().toString()}\u00B0' : 'loading',
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => WeatherInfoPage(
                            dataValue: currently.toString(),
                          )));
                },
                leading: FaIcon(
                  FontAwesomeIcons.cloud,
                  color: themeColor,
                  size: 20.sp,
                ),
                title: Text(
                  'Weather',
                  style: TextStyle(fontSize: 16.sp),
                ),
                trailing: Text(
                  currently != null ? currently.toString() : 'loading',
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HumidityInfo(
                            dataValue: humidity.toString(),
                          )));
                },
                leading: FaIcon(
                  FontAwesomeIcons.droplet,
                  color: themeColor,
                  size: 20.sp,
                ),
                title: Text(
                  'Humidity',
                  style: TextStyle(fontSize: 16.sp),
                ),
                trailing: Text(
                  humidity != null ? '${humidity.toString()} %' : 'loading',
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => WindSpeedInfo(
                            dataValue: windSpeed.toString(),
                          )));
                },
                leading: FaIcon(
                  FontAwesomeIcons.wind,
                  color: themeColor,
                  size: 20.sp,
                ),
                title: Text(
                  'Wind Speed',
                  style: TextStyle(fontSize: 16.sp),
                ),
                trailing: Text(
                  windSpeed != null ? '${windSpeed.toString()} mph' : 'loading',
                  style: TextStyle(fontSize: 16.sp),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 3.h),
          width: 90.w,
          height: 7.h,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                backgroundColor: themeColor,
              ),
              onPressed: () {
                fetchWeather();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WeatherPage()));
              },
              child: Text(
                'Refresh',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal),
              )),
        ),
      ],
    ));
  }
}
