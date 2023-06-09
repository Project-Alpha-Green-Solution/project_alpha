// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:flutter/material.dart';

class Utils {
 static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String? text) {
    if (text == null) return;

    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.red,
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static successSnackBar(String? text) {
    if (text == null) return;

    final snackBar = SnackBar(
      content: Text(text, style: TextStyle(color: Colors.grey[800]),),
      backgroundColor: Colors.white,
      duration: Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      elevation: 3,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.only(top: 20),
      dismissDirection: DismissDirection.up,
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

}
