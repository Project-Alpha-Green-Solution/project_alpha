import 'package:flutter/material.dart';
import 'package:projectalpha/screens/controls_screen/send_message.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../audio_manager.dart';
import '../../constants.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../../provider/language_provider.dart';
import 'connection.dart';

class Controls extends StatefulWidget {
  Controls({super.key});

  @override
  State<Controls> createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: FutureBuilder(
          future: FlutterBluetoothSerial.instance.requestEnable(),
          builder: (BuildContext context, future) {
            if (future.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: Container(
                  height: double.infinity,
                  child: Center(
                    child: Icon(
                      Icons.bluetooth_disabled,
                      size: 200,
                      color: themeColor,
                    ),
                  ),
                ),
              );
            } else {
              return Home();
            }
          },
        ),
      );
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String language = '';
  bool speak = false;
  bool audioPlayed = false;

  // @override
  // void initState() {
  //   super.initState();
  //   // if (speak) {
  //   //   AudioManager.playAudio('audio/${language}/ControlScreen.wav');
  //   // }
  // }

  @override
  void dispose() {
    AudioManager.stopAudio();
    super.dispose();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final languageProvider = Provider.of<LanguageProvider>(context);
  //   final selectedLanguage = languageProvider.selectedLanguage;
  //   final audioTranslate = languageProvider.translateAudio;
  //   setState(() {
  //     speak = audioTranslate;
  //     language = selectedLanguage;
  //   });
  //   if (speak) {
  //     AudioManager.playAudio('audio/$language/ControlScreen.wav');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final selectedLanguage = languageProvider.selectedLanguage;
    final audioTranslate = languageProvider.translateAudio;
    speak = audioTranslate;
    language = selectedLanguage;

    // Check if the audio has not been played yet and audioTranslate is true
    if (speak) {
      AudioManager.playAudio('audio/$language/ControlScreen.wav');
      audioPlayed = true; // Set the flag to true to indicate that audio has been played
    }

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Bluetooth Connection',
          style: TextStyle(fontSize: 17.sp, color: themeColor),
        ),
      ),
      body: SelectBondedDevicePage(
        onCahtPage: (device1) {
          BluetoothDevice device = device1;
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ChatPage(
              server: device,
            );
          }));
        },
      ),
    ));
  }
}
