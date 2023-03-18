import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';

class ControlsPage extends StatefulWidget {
  const ControlsPage({super.key});

  @override
  State<ControlsPage> createState() => _ControlsPageState();
}

class _ControlsPageState extends State<ControlsPage> {
// Initializing the Bluetooth connection state to be unknown
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  // Get the instance of the Bluetooth
  FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;

  // Track the Bluetooth connection with the remote device
  late BluetoothConnection connection;

  // To track whether the device is still connected to Bluetooth
  bool get isConnected => connection != null && connection.isConnected;

  // This member variable will be used for tracking
  // the Bluetooth device connection state
  late int _deviceState;

  @override
  void initState() {
    super.initState();

    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    _deviceState = 0; // neutral

    // If the Bluetooth of the device is not enabled,
    // then request permission to turn on Bluetooth
    // as the app starts up
    enableBluetooth();

    // Listen for further state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;

        // For retrieving the paired devices list
        getPairedDevices();
      });
    });
  }

//todo i changed this to Future<bool> from Future<void>
  Future<bool> enableBluetooth() async {
    // Retrieving the current Bluetooth state
    _bluetoothState = await FlutterBluetoothSerial.instance.state;

    // If the Bluetooth is off, then turn it on first
    // and then retrieve the devices that are paired.
    if (_bluetoothState == BluetoothState.STATE_OFF) {
      await FlutterBluetoothSerial.instance.requestEnable();
      await getPairedDevices();
      return true;
    } else {
      await getPairedDevices();
    }
    return false;
  }

// Define a new class member variable
// for storing the devices list
  List<BluetoothDevice> _devicesList = [];

  Future<void> getPairedDevices() async {
    List<BluetoothDevice> devices = [];

    // To get the list of paired devices
    try {
      devices = await _bluetooth.getBondedDevices();
    } on PlatformException {
      print("Error");
    }

    // It is an error to call [setState] unless [mounted] is true.
    if (!mounted) {
      return;
    }

    // Store the [devices] list in the [_devicesList] for accessing
    // the list outside this class
    setState(() {
      _devicesList = devices;
    });
  }

// Define a member variable to track
// when the disconnection is in progress
  bool isDisconnecting = false;
  late bool _isButtonUnavailable;

  @override
  void dispose() {
    if (isConnected) {
      isDisconnecting = true;
      connection.dispose();
      //connection = null;
    }

    super.dispose();
  }

// Define this member variable for storing
// the current device connectivity status
  bool _connected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Controls',
          style: TextStyle(fontSize: 17.sp, color: themeColor),
        ),
      ),
      body: Center(
          child: Column(
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
          Container(
            margin: EdgeInsets.only(top: 2.h),
            width: 90.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Enable Bluetooth:',
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Switch(
                  value: _bluetoothState.isEnabled,
                  activeColor: themeColor,
                  activeTrackColor: lightbg,
                  onChanged: (bool value) {
                    future() async {
                      if (value) {
                        // Enable Bluetooth
                        await FlutterBluetoothSerial.instance.requestEnable();
                      } else {
                        // Disable Bluetooth
                        await FlutterBluetoothSerial.instance.requestDisable();
                      }

                      // In order to update the devices list
                      await getPairedDevices();
                      _isButtonUnavailable = false;

                      // Disconnect from any device before
                      // turning off Bluetooth
                      // if (_connected) {
                      //   _disconnect();
                      // }
                    }

                    future().then((_) {
                      setState(() {});
                    });
                  },
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
