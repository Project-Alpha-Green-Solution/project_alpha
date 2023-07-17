import 'dart:convert';
import 'package:http/http.dart' as http;

void sendSMS() async {
  String accountSid = 'AC927cef251919a525e0f475c58ba7885a';
  String authToken = '73d3212ccf1e16c39f8fa5feb0167b67';
  String from = '+15412830191';
  String to = '+233553602142';
  String body = 'Hello, this is a test message.';
  
  String messageApi = 'https://api.twilio.com/2010-04-01/Accounts/$accountSid/Messages.json';
  String auth = base64Encode(utf8.encode('$accountSid:$authToken'));
  
  Map<String, String> headers = {
    'Authorization': 'Basic $auth',
    'Content-Type': 'application/x-www-form-urlencoded',
  };
  
  Map<String, String> requestBody = {
    'From': from,
    'To': to,
    'Body': "This is a message body that I have",
  };
  
  try {
    var response = await http.post(Uri.parse(messageApi), headers: headers, body: requestBody);
    
    if (response.statusCode == 201) {
      // Successful request
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      String sid = responseBody['sid'];
      print(sid);
    } else {
      // Error in request
      print('Request failed with status: ${response.statusCode}.');
      print(response.body);
    }
  } catch (e) {
    // Exception occurred
    print('Exception: $e');
  }
}