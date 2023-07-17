import 'package:flutter/material.dart';
import 'package:projectalpha/screens/settings_screen/smart_farming/animal_farming.dart';
import 'package:projectalpha/screens/settings_screen/smart_farming/starting_farming.dart';
import 'package:projectalpha/screens/settings_screen/smart_farming/vegetable_crop.dart';
import 'package:sizer/sizer.dart';

import '../../../constants.dart';
import 'introduction_farming.dart';

class EducationPlatform extends StatefulWidget {
  const EducationPlatform({super.key});

  @override
  State<EducationPlatform> createState() => _EducationPlatformState();
}

class _EducationPlatformState extends State<EducationPlatform> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          SizedBox(height: 70,),
          ListTile(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Introduction()),
                );
              },
              leading: Icon(Icons.school, size: 30.sp, color: themeColor),
              title: Text(
                'INTRODUCTION TO SMART FARMING',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.black,
                ),
              ),
              subtitle: const Text(
                'Learn about smart farming and all that it entails.',
              ),
              trailing:
                  Icon(Icons.chevron_right, size: 25.sp, color: themeColor),
            ),
            ListTile(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const VegetableCrop()),
                );
              },
              leading: Icon(Icons.school, size: 30.sp, color: themeColor),
              title: Text(
                'INTRODUCTION TO VEGETABLE CROP PRODUCTION',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.black,
                ),
              ),
              subtitle: const Text(
                'Learn about vegetable crop production',
              ),
              trailing:
                  Icon(Icons.chevron_right, size: 25.sp, color: themeColor),
            ),
            ListTile(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StartingFarming()),
                );
              },
              leading: Icon(Icons.school, size: 30.sp, color: themeColor),
              title: Text(
                'HOW TO START A FARM FROM SCRATCH',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.black,
                ),
              ),
              subtitle: const Text(
                'Starting a farm from scratch',
              ),
              trailing:
                  Icon(Icons.chevron_right, size: 25.sp, color: themeColor),
            ),
            ListTile(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AnimalFarming()),
                );
              },
              leading: Icon(Icons.school, size: 30.sp, color: themeColor),
              title: Text(
                'ANIMAL FARMING',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.black,
                ),
              ),
              subtitle: const Text(
                'Animal farming in agriculture',
              ),
              trailing:
                  Icon(Icons.chevron_right, size: 25.sp, color: themeColor),
            ),
        ],
      )),
    );
  }
}
