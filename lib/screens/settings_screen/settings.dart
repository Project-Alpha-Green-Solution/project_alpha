import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectalpha/mongo_schema/schema.dart';
import 'package:projectalpha/mongodb.dart';
import 'package:projectalpha/screens/settings_screen/robot_manual.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Settings',
          style: TextStyle(fontSize: 17.sp, color: themeColor),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.person, size: 30.sp, color: themeColor),
              title: FutureBuilder<Map<String, dynamic>?>(
                future: MongoDatabase.getFarmerName(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Text('Loading...'),
                    );
                  } else {
                    if (snapshot.hasData && snapshot.data != null) {
                      final farmerData = snapshot.data!;
                      final farmer = Farmer.fromJson(farmerData);
                      return displayFarmerName(farmer);
                    } else {
                      return Text(
                        'Error. Username not found',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.black,
                        ),
                      );
                    }
                  }
                },
              ),
              subtitle: const Text(
                'Farm Owner',
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings, size: 30.sp, color: themeColor),
              title: Text(
                'AgroGuard',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.black,
                ),
              ),
              subtitle: const Text(
                'Manufactured by Alpha Prodigies',
              ),
            ),
            ListTile(
              leading: Icon(Icons.android, size: 30.sp, color: themeColor),
              title: Text(
                '1.0.0',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.black,
                ),
              ),
              subtitle: const Text(
                'Version',
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ManualPage()),
                );
              },
              leading: Icon(Icons.menu_sharp, size: 30.sp, color: themeColor),
              title: Text(
                'Robot Manual',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.black,
                ),
              ),
              subtitle: const Text(
                'How to use robot.',
              ),
              trailing:
                  Icon(Icons.chevron_right, size: 25.sp, color: themeColor),
            ),
            ListTile(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              leading: Icon(Icons.logout, size: 30.sp, color: themeColor),
              title: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget displayFarmerName(Farmer data) {
    return Text(
      '${data.farmerName}',
      style: TextStyle(
        fontSize: 15.sp,
        color: Colors.black,
      ),
    );
  }
}
