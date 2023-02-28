import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text('Profile',
        style: TextStyle(
          fontSize: 17.sp,
          color: themeColor
        ),),
      ),
    );
  }
}