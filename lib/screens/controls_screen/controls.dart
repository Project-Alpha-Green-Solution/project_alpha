import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projectalpha/screens/controls_screen/controls_page.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';

class Controls extends StatefulWidget {
  const Controls({super.key});

  @override
  State<Controls> createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {
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
  int _deviceState = 0;

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

  void _connect() async {
    if (_device == null) {
      Fluttertoast.showToast(
          msg: "No device selected",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      // Making sure the device is not connected
      if (!isConnected) {
        // Trying to connect to the device using
        // its address
        await BluetoothConnection.toAddress(_device?.address)
            .then((_connection) {
          print('Connected to the device');
          connection = _connection;

          // Updating the device connectivity
          // status to [true]
          setState(() {
            _connected = true;
          });

          // This is for tracking when the disconnecting process
          // is in progress which uses the [isDisconnecting] variable
          // defined before.
          // Whenever we make a disconnection call, this [onDone]
          // method is fired.
          connection.input?.listen(null).onDone(() {
            if (isDisconnecting) {
              print('Disconnecting locally!');
            } else {
              print('Disconnected remotely!');
            }
            if (this.mounted) {
              setState(() {});
            }
          });
        }).catchError((error) {
          print('Cannot connect, exception occurred');
          print(error);
        });
        Fluttertoast.showToast(
            msg: "Device connected",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: themeColor,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  void _disconnect() async {
    // Closing the Bluetooth connection
    await connection.close();
    Fluttertoast.showToast(
        msg: "Device disconnected",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);

    // Update the [_connected] variable
    if (!connection.isConnected) {
      setState(() {
        _connected = false;
      });
    }
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
  bool _isButtonUnavailable = true;

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

  // Define this member variable for storing
// each device from the dropdown items
  BluetoothDevice? _device;

  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devicesList.isEmpty) {
      items.add(const DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      for (var device in _devicesList) {
        items.add(DropdownMenuItem(
          value: device,
          child: Text(device.name!),
        ));
      }
    }
    return items;
  }

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
                      if (_connected) {
                        _disconnect();
                      }
                    }

                    future().then((_) {
                      setState(() {});
                    });
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5.w, top: 2.h, right: 5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Device: ',
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                DropdownButton(
                  items: _getDeviceItems(),
                  onChanged: (value) => setState(() => _device = value!),
                  value: _devicesList.isNotEmpty ? _device : null,
                ),
                ElevatedButton(
                    onPressed: _isButtonUnavailable
                        ? null
                        : _connected
                            ? _disconnect
                            : _connect,
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        backgroundColor: themeColor),
                    child: Text(
                      _connected ? 'Disconnect' : 'Connect',
                      style: const TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 3.h),
            width: 90.w,
            height: 14.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.sp), color: lightbg),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Please if you can't find your device in the list, go to your phone's settings and pair the device. Then come back to the app to proceed.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15.sp,
                    color: themeColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            width: 90.w,
            height: 6.h,
            margin: EdgeInsets.only(top: 3.h),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ControlsPage()),
                );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: themeColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    )
                    ),
                child: Text(
                  'Go to controls',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                )),
          )
        ],
      )),
    );
  }
}
