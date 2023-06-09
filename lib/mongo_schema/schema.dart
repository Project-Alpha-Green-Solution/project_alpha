import 'package:mongo_dart/mongo_dart.dart';
import 'dart:convert';

Farmer farmerFromJson(String str) => Farmer.fromJson(json.decode(str));
String farmertoJson(Farmer data) => json.encode(data.toJson());

class Farmer {
  Farmer({
    required this.id,
    required this.farmerName,
    required this.email,
  });

  ObjectId id;
  var farmerName;
  var email;

  factory Farmer.fromJson(Map<String, dynamic> json) => Farmer(
      id: json["_id"],
      farmerName: json["farmerName"],
      email: json["email"]);

  Map<String, dynamic> toJson() =>
      {"_id": id, "farmerName": farmerName, "email": email};
}

Weather weatherFromJson(String str) => Weather.fromJson(json.decode(str));
String weathertoJson(Weather data) => json.encode(data.toJson());

class Weather {
  Weather(
      {required this.id,
      required this.temperature,
      required this.weather,
      required this.humidity,
      required this.windSpeed});

  var id;
  var temperature;
  var weather;
  var humidity;
  var windSpeed;

  Weather.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        temperature = json['temperature'],
        weather = json['weather'],
        humidity = json['humidity'],
        windSpeed = json['windSpeed'];

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'temperature': temperature,
      'weather': weather,
      'humidity': humidity,
      'windSpeed': windSpeed,
    };
  }
}

Soil soilFromJson(String str) => Soil.fromJson(json.decode(str));
String soiltoJson(Soil data) => json.encode(data.toJson());

class Soil {
  Soil({required this.id, required this.moisture, required this.nutrient});

  ObjectId id;
  var moisture;
  var nutrient;

  Soil.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        moisture = json['moisture'],
        nutrient = json['nutrient'];

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'moisture': moisture,
      'nutrient': nutrient,
    };
  }
}

Disease diseaseFromJson(String str) => Disease.fromJson(json.decode(str));
String diseasetoJson(Disease data) => json.encode(data.toJson());

class Disease {
  Disease({required this.id, required this.name});

  ObjectId id;
  var name;

  Disease.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        name = json['name'];

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}
