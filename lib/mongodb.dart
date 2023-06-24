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

  static Future<void> deleteDocuments() async {
    // Define your query to select the documents to delete
    final query = where.eq('weather', 'Clouds');

    // Perform the delete operation
    final result = await collection.deleteMany(query);

    print('Deleted ${result.deletedCount} documents.');

    await db.close();
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

  static Future<String> insertDiseaseData(PlantDisease data) async {
    try {
      var result = await collection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Disease data inserted successfully";
      } else {
        return "Error, couldn't insert disease data.";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

// Function to fetch data from MongoDB
static Future<List<Map<String, dynamic>>> fetchLastInsertedData() async {
  final cursor = collection.find(
    where.eq('email', user.email!), // Add the where clause here
    sort: {r'$natural': -1},
    limit: 1,
    fields: {'name': 1, 'plant': 1, 'solution': 1},
  );

  final result = await cursor.toList();
  return result;
}

}

