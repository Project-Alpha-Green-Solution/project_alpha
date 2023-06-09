import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:projectalpha/bottomNav.dart';
import 'package:projectalpha/screens/auth_screens/auth_page.dart';
import 'package:projectalpha/screens/auth_screens/login_page.dart';
import 'package:projectalpha/screens/auth_screens/utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'constants.dart';
import 'mongodb.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  print("Handling a background message: ${message.messageId}");
  // final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  // _fcm.subscribeToTopic("susya");
}

final navigatorKey = GlobalKey<NavigatorState>();
 
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await MongoDatabase.connect();
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

runApp(const MyApp());

// runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => DiseaseService()),
//       ],
//       child: const MyApp(),
//     ),
//   );

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        scaffoldMessengerKey: Utils.messengerKey,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Project Alpha',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const MyHomePage(),
      );
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(
              child: Text('Something went wrong',
                  style: TextStyle(color: Colors.red, fontSize: 20)));
        } else if (snapshot.hasData) {
          return const BottomNav();
        } else {
          return const AuthPage();
        }
      },
    ));
  }
}



// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Sizer(builder: (context, orientation, deviceType) {
//       return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Project Alpha',
//         theme: ThemeData(
//           primarySwatch: Palette.themeColor, // use themeColor here
//           // other theme properties
//         ),
//         // home: const BottomNav(),
//         home: Scaffold(
//         body: StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return const Center(
//               child: Text('Something went wrong',
//                   style: TextStyle(color: Colors.red, fontSize: 20)));
//         } else if (snapshot.hasData) {
//           return const BottomNav();
//         } else {
//           return const LoginPage(); 
//         }
//       },
//     ))
//       );
//     });
//   }
// }
