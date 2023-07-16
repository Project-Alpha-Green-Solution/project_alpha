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
      id: json["_id"], farmerName: json["farmerName"], email: json["email"]);

  Map<String, dynamic> toJson() =>
      {"_id": id, "farmerName": farmerName, "email": email};
}

Weather weatherFromJson(String str) => Weather.fromJson(json.decode(str));
String weathertoJson(Weather data) => json.encode(data.toJson());

class Weather {
  Weather({
    required this.id,
    required this.temperature,
    required this.weather,
    required this.humidity,
    required this.windSpeed,
    required this.status,
    required this.user,
    required this.timestamp,
  });

  var id;
  var temperature;
  var weather;
  var humidity;
  var windSpeed;
  var status;
  var user;
  var timestamp;

  Weather.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        temperature = json['temperature'],
        weather = json['weather'],
        humidity = json['humidity'],
        windSpeed = json['windSpeed'],
        status = json['status'],
        user = json['user'],
        timestamp = json['timestamp'];

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'temperature': temperature,
      'weather': weather,
      'humidity': humidity,
      'windSpeed': windSpeed,
      'status': status,
      'user': user,
      'timestamp': timestamp,
    };
  }
}

Soil soilFromJson(String str) => Soil.fromJson(json.decode(str));
String soiltoJson(Soil data) => json.encode(data.toJson());

class Soil {
  Soil({
    required this.id,
    required this.moisture,
    required this.nitrogen,
    required this.phosphorus,
    required this.potassium,
    required this.status,
    required this.user,
    required this.timestamp,
  });

  ObjectId id;
  var moisture;
  var nitrogen;
  var potassium;
  var phosphorus;
  var status;
  var user;
  var timestamp;

  Soil.fromJson(Map<String, dynamic>? json)
      : id = (json != null) ? json['_id'] : ObjectId(),
        moisture = json?['moisture'],
        nitrogen = json?['nitrogen'],
        potassium = json?['potassium'],
        phosphorus = json?['phosphorus'],
        status = json?['status'],
        user = json?['user'],
        timestamp = json?['timestamp'];

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'moisture': moisture,
      'nitrogen': nitrogen,
      'potassium': potassium,
      'phosphorus': phosphorus,
      'status': status,
      'user': user,
      'timestamp': timestamp,
    };
  }
}

PlantDisease diseaseFromJson(String str) =>
    PlantDisease.fromJson(json.decode(str));
String diseasetoJson(PlantDisease data) => json.encode(data.toJson());

class PlantDisease {
  PlantDisease({
    required this.id,
    required this.name,
    required this.plant,
    required this.solution,
    required this.status,
    required this.user,
    required this.timestamp,
  });

  ObjectId id;
  var name;
  var plant;
  var solution;
  var status;
  var user;
  var timestamp;

  PlantDisease.fromJson(Map<String, dynamic>? json)
      : id = (json != null) ? json['_id'] : ObjectId(),
        name = json?['name'],
        plant = json?['plant'],
        solution = json?['solution'],
        status = json?['status'],
        user = json?['user'],
        timestamp = json?['timestamp'];

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'plant': plant,
      'solution': solution,
      'status': status,
      'user': user,
      'timestamp': timestamp,
    };
  }
}
