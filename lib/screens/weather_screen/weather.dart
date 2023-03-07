// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projectalpha/screens/weather_screen/humidity_info.dart';
import 'package:projectalpha/screens/weather_screen/temperature_info.dart';
import 'package:projectalpha/screens/weather_screen/weather_info.dart';
import 'package:projectalpha/screens/weather_screen/wind_speed_info.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../constants.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;
  var lat = '';
  var lon = '';

  var url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?lat=4.904500&lon=-1.768530&units=metric&appid=71b0c0d7621562e2ab11c753477bc756");

  Future getWeather() async {
    http.Response response = await http.get(url);
    var results = jsonDecode(response.body);
    setState(() {
      temp = results['main']['temp'];
      description = results['weather'][0]['description'];
      currently = results['weather'][0]['main'];
      humidity = results['main']['humidity'];
      windSpeed = results['wind']['speed'];
    });
  }

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            'Weather',
            style: TextStyle(fontSize: 17.sp, color: themeColor),
          ),
        ),
        body: Center(
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
                      margin: const EdgeInsets.fromLTRB(15, 10, 10, 10),
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
                              padding:
                                  const EdgeInsets.only(top: 8.0, right: 6.0),
                              child: Text(
                                'Takoradi',
                                style: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, right: 6.0),
                              child: Text(
                                temp != null
                                    ? '$temp\u00B0'
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
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                    color: themeColor),
              ),
            ),
            SizedBox(
              width: 90.w,
              child: Column(
                children: [
                  ListTile(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => TemperatureInfo(dataValue: temp.toString(),)));
                    },
                    leading: FaIcon(
                      FontAwesomeIcons.temperatureHalf,
                      color: themeColor,
                      size: 20.sp,
                    ),
                    title: Text(
                      'Temperature',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    trailing: Text(
                      temp != null ? '$temp\u00B0' : 'loading',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => WeatherInfo(dataValue: currently.toString(),)));
                    },
                    leading: FaIcon(
                      FontAwesomeIcons.cloud,
                      color: themeColor,
                      size: 20.sp,
                    ),
                    title: Text(
                      'Weather',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    trailing: Text(
                      currently != null ? currently.toString() : 'loading',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HumidityInfo(dataValue: humidity.toString(),)));
                    },
                    leading: FaIcon(
                      FontAwesomeIcons.droplet,
                      color: themeColor,
                      size: 20.sp,
                    ),
                    title: Text(
                      'Humidity',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    trailing: Text(
                      humidity != null ? humidity.toString() : 'loading',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => WindSpeedInfo(dataValue: windSpeed.toString(),)));
                    },
                    leading: FaIcon(
                      FontAwesomeIcons.wind,
                      color: themeColor,
                      size: 20.sp,
                    ),
                    title: Text(
                      'Wind Speed',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    trailing: Text(
                      windSpeed != null ? windSpeed.toString() : 'loading',
                      style: TextStyle(fontSize: 18.sp),
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
                    getWeather();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const WeatherPage()));
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
        )));
  }
}
