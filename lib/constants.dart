import 'package:flutter/material.dart';

const themeColor = Color.fromRGBO(15, 157, 88, 1);
const lightbg = Color.fromRGBO(219, 252, 228, 1);

class Palette {
  static const MaterialColor themeColor = MaterialColor(
    0xffffff, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Colors.white,
      100: Colors.white,
      200: Colors.white,
      300: Colors.white,
      400: Colors.white,
      500: Colors.white,
      600: Colors.white,
      700: Colors.white,
      800: Colors.white,
      900: Colors.white,
    },
  );
}

const MONGO_URL =
    "mongodb+srv://eyarko:%40password123@lawsonscluster.l1vqepq.mongodb.net/agroguard";

const COLLECTION_NAME = "agroguard";

const SOIL_COLLECTION = "soilData";

const WEATHER_COLLECTION = "weatherData";

const DISEASE_COLLECTION = "diseaseData";
