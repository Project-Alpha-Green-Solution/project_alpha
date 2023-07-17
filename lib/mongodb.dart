import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:projectalpha/constants.dart';
import 'package:mongo_dart/mongo_dart.dart';

import 'mongo_schema/schema.dart';

final user = FirebaseAuth.instance.currentUser!;

class MongoDatabase {
  static var db, collection, collection1, collection2, collection3;
  static connect() async {
    db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    collection = db.collection(COLLECTION_NAME);
    collection1 = db.collection(SOIL_COLLECTION);
    collection2 = db.collection(DISEASE_COLLECTION);
    collection3 = db.collection(WEATHER_COLLECTION);
    print("Database connected successfully");
  }

  //Get farmer's name from database
  static Future<Map<String, dynamic>?> getFarmerName() async {
    final data = await collection.findOne(where.eq('email', user.email!));
    return data;
  }

  static Future<void> deleteDocuments() async {
    // Define your query to select the documents to delete
    final query = where.eq('plant', 'Tomato');

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
    final updateResult = await collection3.updateMany(
      where.eq('weather', {'\$exists': true}),
      modify.set('status', 'notLast'),
    );

    if (updateResult.isSuccess) {
      final insertResult = await collection3.insertOne(data.toJson());
      if (insertResult.isSuccess) {
        return "Weather data inserted successfully";
      } else {
        return "Error, couldn't insert weather data.";
      }
    } else {
      return "Error, couldn't update existing documents.";
    }
  } catch (e) {
    print(e.toString());
    return e.toString();
  }
}


  //function to insert soil data
  static Future<String> insertSoilData(Soil data) async {
  try {
    final updateResult = await collection1.updateMany(
      where.eq('moisture', {'\$exists': true}),
      modify.set('status', 'notLast'),
    );

    if (updateResult.isSuccess) {
      final insertResult = await collection1.insertOne(data.toJson());
      if (insertResult.isSuccess) {
        return "Soil data inserted successfully";
      } else {
        return "Error, couldn't insert soil data.";
      }
    } else {
      return "Error, couldn't update existing documents.";
    }
  } catch (e) {
    print(e.toString());
    return e.toString();
  }
}

  //function to insert diasease data
  static Future<String> insertDiseaseData(PlantDisease data) async {
  try {
    final updateResult = await collection2.updateMany(
      where.eq('plant', {'\$exists': true}),
      modify.set('status', 'notLast'),
    );

    if (updateResult.isSuccess) {
      final insertResult = await collection2.insertOne(data.toJson());
      if (insertResult.isSuccess) {
        return "Disease data inserted successfully";
      } else {
        return "Error, couldn't insert disease data.";
      }
    } else {
      return "Error, couldn't update existing documents.";
    }
  } catch (e) {
    print(e.toString());
    return e.toString();
  }
}

//todo: not working
// Function to fetch data from MongoDB
  static Future<List<Map<String, dynamic>>> fetchLastInsertedData() async {
    final cursor = collection2.find(
      where.eq('user', user.email!), // Add the where clause here
      sort: {r'$natural': -1},
      limit: 1,
      fields: {'name': 1, 'plant': 1, 'solution': 1},
    );

    final result = await cursor.toList();
    return result;
  }


//function to fetch recent disease
  static Future<Map<String, dynamic>?> getPlantDiseaseData() async {
  final data = await collection2.findOne(
    where
      .eq('user', user.email!)
      .eq('status', 'Last'),
  );
  return data;
}

//function to fetch recent soil data
  static Future<Map<String, dynamic>?> getRecentSoilData() async {
  final data = await collection1.findOne(
    where
      .eq('user', user.email!)
      .eq('status', 'Last'),
  );
  return data;
}


//function to fetch recent weather
  static Future<Map<String, dynamic>?> getWeatherData() async {
    final data = await collection3.findOne(
      where.eq('user', user.email!).eq('status', 'Last'),
    );
    return data;
  }

//todo: not working
//funciton to fetch past diseases
  static Future<Map<String, dynamic>?> getPlantDiseases() async {
    final List<Map<String, dynamic>> data = await collection2.find(
      where.eq('name', {'\$exists': true}).eq('user', user.email as String),
    );
  }
}
