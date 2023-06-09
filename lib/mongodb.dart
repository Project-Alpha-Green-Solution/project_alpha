import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:projectalpha/constants.dart';
import 'package:mongo_dart/mongo_dart.dart';

import 'mongo_schema/schema.dart';

final user = FirebaseAuth.instance.currentUser!;

class MongoDatabase {
  static var db, collection;
  static connect() async {
    db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    collection = db.collection(COLLECTION_NAME);
    print("Database connected successfully");
  }

  //Get farmer's name from database
static Future<Map<String, dynamic>?> getFarmerName() async {
  final data = await collection.findOne(where.eq('email', user.email!));
  return data;
}



  static Future<String?> fetchFarmerNameByEmail() async {
  final query = where.eq('email', user.email);

  final Map<String, dynamic>? result =
      await collection.findOne(query, fields: {'farmerName': 1, '_id': 0});

  await db.close();

  if (result != null) {
    return result['farmerName'] as String?;
  }

  return null;
}


  //update weather data
static Future<void> updateWeatherData(Weather data) async {
  final query = where.eq('_id', 'weatherID');
  final update = modify
    ..set('temperature', data.temperature)
    ..set('weather', data.weather)
    ..set('humidity', data.humidity)
    ..set('windSpeed', data.windSpeed);

  final response = await collection.update(query, update);
  inspect(response);
}


  //Insert farmer's details into the database
  static Future<String> insertFarmerData(Farmer data) async {
    try {
      var result = await collection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Farmer data inserted successfully";
      } else {
        return "Error, couldn't insert farmer data.";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  static Future<String> insertWeatherData(Weather data) async {
    try {
      var result = await collection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Weather data inserted successfully";
      } else {
        return "Error, couldn't insert weather data.";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
