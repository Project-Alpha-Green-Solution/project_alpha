// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:projectalpha/screens/weather_screen/main_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../constants.dart';

var lat = 0.00;
var lon = 0.00;

Future<WeatherInfo> fetchWeather() async {
  final apiKey = "71b0c0d7621562e2ab11c753477bc756";
  final requestUrl =
      "http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=$apiKey";

  //final response = await http.get(Uri.parse(requestUrl));
  final response = await http.get(Uri.parse(requestUrl));

  if (response.statusCode == 200) {
    return WeatherInfo.fromJson(jsonDecode(json.encode(response.body)));
  } else {
    throw Exception("Error loading request URL info");
  }
}

class WeatherInfo {
  final temp;
  final description;
  final currently;
  final humidity;
  final windSpeed;

  WeatherInfo(
      {@required this.temp,
      @required this.description,
      @required this.currently,
      @required this.humidity,
      @required this.windSpeed});

  factory WeatherInfo.fromJson(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return WeatherInfo(
        temp: json['main']['temp'],
        description: json['weather'][0]['description'],
        currently: json['weather'][0]['main'],
        humidity: json['main']['humidity'],
        windSpeed: json['wind']['speed']);
  }
}

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

  Position? _currentPosition;
  String? _currentAddress;

  late Future<WeatherInfo> futureWeather;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      lat = _currentPosition!.latitude;
      lon = _currentPosition!.longitude;
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = '${place.locality}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
    _getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            'Weather',
            style: TextStyle(fontSize: 17.sp, color: themeColor),
          ),
        ),
        body: FutureBuilder<WeatherInfo>(
          future: futureWeather,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MainWidget(
                temp: snapshot.data?.temp,
                description: snapshot.data?.description,
                currently: snapshot.data?.currently,
                humidity: snapshot.data?.humidity,
                windSpeed: snapshot.data?.windSpeed,
                location: _currentAddress,
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
            return const Center(
              child: CircularProgressIndicator(color: themeColor),
            );
          },
        ));
  }
}
