import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sizer/sizer.dart';

import '../../../constants.dart';
import 'package:http/http.dart' as http;

import '../../../openai_response_model.dart';

class GeneratedReport extends StatefulWidget {
  const GeneratedReport({Key? key, required this.request}) : super(key: key);
  final String request;

  @override
  State<GeneratedReport> createState() => _GeneratedReportState();
}

class _GeneratedReportState extends State<GeneratedReport> {
  var responseTxt = '';
  late ResponseModel? _responseModel;

  @override
  void initState() {
    super.initState();
    completionFun();
  }

  completionFun() async {
  setState(() => responseTxt = 'Loading...');

  final response = await http.post(
    Uri.parse('https://api.openai.com/v1/completions'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${dotenv.env['API_KEY']}'
    },
    body: jsonEncode(
      {
        "model": "text-davinci-003",
        "prompt": widget.request,
        "max_tokens": 250,
        "temperature": 0,
        "top_p": 1,
        "n": 100,
      },
    ),
  );

  // print(response.body); // Print the response body

  setState(() {
  if (response.body != null) {
    _responseModel = ResponseModel.fromJson(jsonDecode(response.body));
    responseTxt = _responseModel!.choices[0].text;
    print(responseTxt);
  }
});

}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'A.I Generated Report',
          style: TextStyle(fontSize: 17.sp, color: themeColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.topCenter,
            child: Text(
              responseTxt,
              key: Key(responseTxt),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
