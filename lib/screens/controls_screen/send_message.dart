library send_messagee;

import 'dart:async';
import 'dart:convert';

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:projectalpha/screens/controls_screen/controls_page.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';
import '../../mongo_schema/schema.dart';
import '../../mongodb.dart';
import '../../sendSMS.dart';
import '../auth_screens/utils.dart';
import 'package:mongo_dart/mongo_dart.dart' as MN;

class ChatPage extends StatefulWidget {
  final BluetoothDevice? server;
  const ChatPage({
    Key? key,
    this.server,
    this.lcdMessage,
  }) : super(key: key);
  final String? lcdMessage;

  @override
  _ChatPageState createState() => _ChatPageState();
}

var hadi;

class _ChatPageState extends State<ChatPage>
    with SingleTickerProviderStateMixin {
  // TabController? _controller;

  BluetoothConnection? connection;

  final ScrollController listScrollController = ScrollController();

  bool isConnecting = true;

  bool get isConnected => connection != null && connection!.isConnected;

  bool isDisconnecting = false;
  @override
  @override
  List<Color> _colorlist = [];
  List<Color> genrateColorslist() {
    List<Color> _colorslist = [];
    for (int i = 0; i < (8 * 8); i++) {
      _colorslist.add(Colors.black);
    }
    return _colorslist;
  }

  void displayValues() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int mValue;

        try {
          // Remove leading/trailing whitespace and parse M as an integer
          mValue = int.parse(M.toString().trim());
        } catch (e) {
          // Handle parsing error, set a default value or display an error message
          mValue = 0; // Default value
          print('Error parsing M as an integer: $e');
        }

        return AlertDialog(
          title: Text('Soil Readings'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Moisture content: $M'),
              Text('Nitrogen content: $N'),
              Text('Phosphorus content: $P'),
              Text('Potassium content: $K'),
              Text(
                (mValue <= 350)
                    ? "\nYour Soil moisture is low. Press the button below to start irrigation."
                    : '\n',
                style:
                    TextStyle(color: themeColor, fontWeight: FontWeight.bold),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    sendSMS();
                    Utils.successSnackBar(
                        'THE SYSTEM WILL START IRRIGATION SOON');
                  },
                  child: Text(
                    'Start Irrigation',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void initState() {
    super.initState();

    _colorlist = genrateColorslist();

    BluetoothConnection.toAddress(widget.server!.address).then((_connection) {
      print('connected');
      connection = _connection;

      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });
    });
  }

  void dispose() {
    if (isConnected) {
      isDisconnecting = true;
      connection?.dispose();
      connection = null;
      mineController.close();
    }
    super.dispose();
  }

  bool btnColor = false;
  bool dataReceived = false;

  var M;
  var N;
  var P;
  var K;

  StreamController<String> mineController =
      StreamController<String>.broadcast();
  Stream<String> myStream() async* {
    connection?.input?.listen((Uint8List data) {
      print(ascii.decode(data));
      var myData = ascii.decode(data);
      if (myData[0] == "M") {
        M = myData.substring(1).trim();
      } else if (myData[0] == "N") {
        N = myData.substring(1).trim();
      } else if (myData[0] == "P") {
        P = myData.substring(1).trim();
      } else if (myData[0] == "K") {
        K = myData.substring(1).trim();
      }
      if (M == null || N == null || P == null || K != null) {
        dataReceived = true;
        displayValues(); // Call the method to display the values
        // M = 0;
        // N = 0;
        // P = 0;
        // K = 0;
      }

      insertSoilData(M, N, P, K);

      printValues();
      mineController.add(ascii.decode(data));
    });
  }

  void printValues() {
    print("$N, $P, $K");
  }

  Widget build(BuildContext context) {
    String denemee = "Lawson";
    TextEditingController lcdController = TextEditingController();
    mineController.addStream(myStream());

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          title: Text(
            'Controls',
            style: TextStyle(fontSize: 17.sp, color: themeColor),
          ),
        ),
        body: ControlsPage(
          sendMessage1: () => _sendMessage('1'),
          sendMessage2: () => _sendMessage('2'),
          sendMessage3: () => _sendMessage('3'),
          sendMessage4: () => _sendMessage('4'),
          sendMessage5: () => _sendMessage('A'),
          sendMessage6: () => _sendMessage('B'),
          sendMessage7: () => _sendMessage('C'),
          sendMessage8: () => _sendMessage('D'),
          sendMessage9: () => _sendMessage('E'),
        ));
  }

  btnColorChange() {
    setState(() {
      btnColor = !btnColor;
    });
  }

  _sendMessage(String text) async {
    text = text.trim();

    if (text.length > 0) {
      try {
        connection!.output.add(Uint8List.fromList(utf8.encode(text)));
        await connection!.output.allSent;
      } catch (e) {
        // Ignore error, but notify state
      }
    }
  }

  Future<void> insertSoilData(
      var moisture, var nitrogen, var phosphorus, var potassium) async {
    var _id = MN.ObjectId();
    var status = 'Last';
    var timestamp = DateTime.now();
    final data = Soil(
        id: _id,
        moisture: moisture,
        nitrogen: nitrogen,
        phosphorus: phosphorus,
        potassium: potassium,
        status: status,
        user: user.email!,
        timestamp: timestamp);

    var result = await MongoDatabase.insertSoilData(data);
  }
}
