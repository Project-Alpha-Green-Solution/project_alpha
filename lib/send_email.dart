import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mongo_dart/mongo_dart.dart';

import 'constants.dart';

Future sendEmail(String disease, String crop, String solution) async {
  const serviceId = 'service_0f2yzj7';
  const templateId = 'template_n8m48d8';
  const userId = 'Xf0VzqOadUdRo5zmA';
  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

  // Connect to MongoDB
  final db = await Db.create(MONGO_URL);
  await db.open();

  // Fetch all users from the collection
  final collection = db.collection(COLLECTION_NAME);
  final users = await collection.find().toList();

  // Iterate over each user and send an email
  for (var user in users) {
    final email = user['email'];
    final name = user['farmerName'];

    final response = await http.post(url,
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'to_email': email,
            'from_name': 'AgroGuard',
            'to_name': name,
            'reply_to': 'agroguard@gmail.com',
            'subject': 'Plant Disease Outbreak Alert!!!',
            'message':
                '\nOur system has detected a possible plant disease outbreak.\n \nDisease name: $disease\n \nTargeted Plant: $crop \nPrecautions and Solution: $solution\n \nPlease apply serious measures to avoid this possible disease outbreak. \n AgroGuard',
          }
        }));

    print(response.body);
  }

  // Close the database connection
  await db.close();
}
