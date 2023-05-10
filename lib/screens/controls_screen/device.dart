import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:projectalpha/constants.dart';
import 'package:sizer/sizer.dart';

class BluetoothDeviceListEntry extends StatelessWidget {
  const BluetoothDeviceListEntry({Key? key,required this.onTap,required this.device  }) : super(key: key);
  final VoidCallback onTap;
  final BluetoothDevice? device;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
              margin: EdgeInsets.only(top: 3.h),
              width: 90.w,
              height: 27.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(20)),
                border: Border.all(width: 1, color: themeColor),
                image: const DecorationImage(
                    image: AssetImage('assets/bluetooth.gif'),
                    fit: BoxFit.fitWidth),
              ),
            ),
        ListTile(
          onTap: onTap,
          leading: Icon(Icons.devices, color: themeColor,),
          title: Text(device!.name ?? "Unkwown Device"),
          subtitle: Text(device!.address.toString()),
          trailing: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: themeColor
            ),
            child: Text('Connect',style: TextStyle(color: Colors.white),),
          ),

        ),
      ],
    );
  }
}