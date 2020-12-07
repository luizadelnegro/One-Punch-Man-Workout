import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:one_punch_man_workout/pages/widget.dart';

import 'dart:async';
import 'dart:math';

class BluetoothApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Theme.of(context).primaryColor,
      home: StreamBuilder<BluetoothState>(
          stream: FlutterBlue.instance.state,
          initialData: BluetoothState.unknown,
          builder: (c, snapshot) {
            final state = snapshot.data;
            if (state == BluetoothState.on) {
              return FindDevicesScreen();
            }
            return BluetoothOffScreen(state: state);
          }),
    );
  }
}

class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({Key key, this.state}) : super(key: key);

  final BluetoothState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.bluetooth_disabled,
              size: 200.0,
              color: Theme.of(context).backgroundColor,
            ),
            Text(
              'Bluetooth Adapter is ${state != null ? state.toString().substring(15) : 'not available'}.',
              style: Theme.of(context)
                  .primaryTextTheme
                  .subhead
                  .copyWith(color: Theme.of(context).backgroundColor,
            ),
          ],
        ),
      ),
    );
  }
}

class FindDevicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Devices'),
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            FlutterBlue.instance.startScan(timeout: Duration(seconds: 4)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              StreamBuilder<List<BluetoothDevice>>(
                stream: Stream.periodic(Duration(seconds: 2))
                    .asyncMap((_) => FlutterBlue.instance.connectedDevices),
                initialData: [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data
                      .map((d) => ListTile(
                            title: Text(d.name),
                            subtitle: Text(d.id.toString()),
                            trailing: StreamBuilder<BluetoothDeviceState>(
                              stream: d.state,
                              initialData: BluetoothDeviceState.disconnected,
                              builder: (c, snapshot) {
                                if (snapshot.data ==
                                    BluetoothDeviceState.connected) {
                                  return RaisedButton(
                                    child: Text('OPEN'),
                                    onPressed: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DeviceScreen(device: d))),
                                  );
                                }
                                return Text(snapshot.data.toString());
                              },
                            ),
                          ))
                      .toList(),
                ),
              ),
              StreamBuilder<List<ScanResult>>(
                stream: FlutterBlue.instance.scanResults,
                initialData: [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data
                      .map(
                        (r) => ScanResultTile(
                          result: r,
                          onTap: () => Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            r.device.connect();
                            return DeviceScreen(device: r.device);
                          })),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: FlutterBlue.instance.isScanning,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data) {
            return FloatingActionButton(
              child: Icon(Icons.stop),
              onPressed: () => FlutterBlue.instance.stopScan(),
              backgroundColor: Colors.red,
            );
          } else {
            return FloatingActionButton(
                child: Icon(Icons.search),
                onPressed: () => FlutterBlue.instance
                    .startScan(timeout: Duration(seconds: 4)));
          }
        },
      ),
    );
  }
}

class DeviceScreen extends StatelessWidget {
  const DeviceScreen({Key key, this.device}) : super(key: key);

  final BluetoothDevice device;

  List<int> _getRandomBytes() {
    final math = Random();
    return [
      math.nextInt(255),
      math.nextInt(255),
      math.nextInt(255),
      math.nextInt(255)
    ];
  }

  List<Widget> _buildServiceTiles(List<BluetoothService> services) {
    return services
        .map(
          (s) => ServiceTile(
            service: s,
            characteristicTiles: s.characteristics
                .map(
                  (c) => CharacteristicTile(
                    characteristic: c,
                    onReadPressed: () => c.read(),
                    onWritePressed: () async {
                      await c.write(_getRandomBytes(), withoutResponse: true);
                      await c.read();
                    },
                    onNotificationPressed: () async {
                      await c.setNotifyValue(!c.isNotifying);
                      await c.read();
                    },
                    descriptorTiles: c.descriptors
                        .map(
                          (d) => DescriptorTile(
                            descriptor: d,
                            onReadPressed: () => d.read(),
                            onWritePressed: () => d.write(_getRandomBytes()),
                          ),
                        )
                        .toList(),
                  ),
                )
                .toList(),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(device.name),
        actions: <Widget>[
          StreamBuilder<BluetoothDeviceState>(
            stream: device.state,
            initialData: BluetoothDeviceState.connecting,
            builder: (c, snapshot) {
              VoidCallback onPressed;
              String text;
              switch (snapshot.data) {
                case BluetoothDeviceState.connected:
                  onPressed = () => device.disconnect();
                  text = 'DISCONNECT';
                  break;
                case BluetoothDeviceState.disconnected:
                  onPressed = () => device.connect();
                  text = 'CONNECT';
                  break;
                default:
                  onPressed = null;
                  text = snapshot.data.toString().substring(21).toUpperCase();
                  break;
              }
              return FlatButton(
                  onPressed: onPressed,
                  child: Text(
                    text,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .button
                        .copyWith(color: Colors.white),
                  ));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder<BluetoothDeviceState>(
              stream: device.state,
              initialData: BluetoothDeviceState.connecting,
              builder: (c, snapshot) => ListTile(
                leading: (snapshot.data == BluetoothDeviceState.connected)
                    ? Icon(Icons.bluetooth_connected)
                    : Icon(Icons.bluetooth_disabled),
                title: Text(
                    'Device is ${snapshot.data.toString().split('.')[1]}.'),
                subtitle: Text('${device.id}'),
                trailing: StreamBuilder<bool>(
                  stream: device.isDiscoveringServices,
                  initialData: false,
                  builder: (c, snapshot) => IndexedStack(
                    index: snapshot.data ? 1 : 0,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () => device.discoverServices(),
                      ),
                      IconButton(
                        icon: SizedBox(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.grey),
                          ),
                          width: 18.0,
                          height: 18.0,
                        ),
                        onPressed: null,
                      )
                    ],
                  ),
                ),
              ),
            ),
            StreamBuilder<int>(
              stream: device.mtu,
              initialData: 0,
              builder: (c, snapshot) => ListTile(
                title: Text('MTU Size'),
                subtitle: Text('${snapshot.data} bytes'),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => device.requestMtu(223),
                ),
              ),
            ),
            StreamBuilder<List<BluetoothService>>(
              stream: device.services,
              initialData: [],
              builder: (c, snapshot) {
                return Column(
                  children: _buildServiceTiles(snapshot.data),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// class _BluetoothAppState extends State<BluetoothApp> {
//   //initialize
//   FlutterBlue flutterBlue = FlutterBlue.instance;

// // Start scanning
//   flutterBlue.startScan(timeout: Duration(seconds: 4));

// // Listen to scan results
// var subscription = flutterBlue.scanResults.listen((results) {
//     // do something with scan results
//     for (ScanResult r in results) {
//         print('${r.device.name} found! rssi: ${r.rssi}');
//     }
// });

// // Stop scanning
// flutterBlue.stopScan();
// // /////////////////////////////

// //   // Initializing a global key, as it would help us in showing a SnackBar later
// //   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

// //   // Get the instance of the bluetooth
// //   FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;

// //   // Define some variables, which will be required later
// //   List<BluetoothDevice> _devicesList = [];
// //   BluetoothDevice _device;
// //   bool _connected = false;
// //   bool _pressed = false;

// //   @override
// //   void initState() {
// //     super.initState();
// //     bluetoothConnectionState();
// //   }

// //   // We are using async callback for using await
// //   Future<void> bluetoothConnectionState() async {
// //     List<BluetoothDevice> devices = [];

// //     // To get the list of paired devices
// //     try {
// //       devices = await bluetooth.getBondedDevices();
// //     } on PlatformException {
// //       print("Error");
// //     }

// //     // For knowing when bluetooth is connected and when disconnected
// //     bluetooth.onStateChanged().listen((state) {
// //       switch (state) {
// //         case FlutterBluetoothSerial.CONNECTED:
// //           setState(() {
// //             _connected = true;
// //             _pressed = false;
// //           });

// //           break;

// //         case FlutterBluetoothSerial.DISCONNECTED:
// //           setState(() {
// //             _connected = false;
// //             _pressed = false;
// //           });
// //           break;

// //         default:
// //           print(state);
// //           break;
// //       }
// //     });

// //     // It is an error to call [setState] unless [mounted] is true.
// //     if (!mounted) {
// //       return;
// //     }

// //     // Store the [devices] list in the [_devicesList] for accessing
// //     // the list outside this class
// //     setState(() {
// //       _devicesList = devices;
// //     });
// //   }
// // /////////////////////////////////////

// //   // Create the List of devices to be shown in Dropdown Menu
// //   List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
// //     List<DropdownMenuItem<BluetoothDevice>> items = [];
// //     if (_devicesList.isEmpty) {
// //       items.add(DropdownMenuItem(
// //         child: Text('NONE'),
// //       ));
// //     } else {
// //       _devicesList.forEach((device) {
// //         items.add(DropdownMenuItem(
// //           child: Text(device.name),
// //           value: device,
// //         ));
// //       });
// //     }
// //     return items;
// //   }

// //   // Method to connect to bluetooth
// //   void _connect() {
// //     if (_device == null) {
// //       show('No device selected');
// //     } else {
// //       bluetooth.isConnected.then((isConnected) {
// //         if (!isConnected) {
// //           bluetooth
// //               .connect(_device)
// //               .timeout(Duration(seconds: 60))
// //               .catchError((error) {
// //             setState(() => _pressed = false);
// //           });
// //           setState(() => _pressed = true);
// //         }
// //       });
// //     }
// //   }

// //   // Method to disconnect bluetooth
// //   void _disconnect() {
// //     bluetooth.disconnect();
// //     setState(() => _pressed = true);
// //   }

// //   // Method to show a Snackbar,
// //   // taking message as the text
// //   Future show(
// //     String message, {
// //     Duration duration: const Duration(seconds: 3),
// //   }) async {
// //     await new Future.delayed(new Duration(milliseconds: 100));
// //     _scaffoldKey.currentState.showSnackBar(
// //       new SnackBar(
// //         content: new Text(
// //           message,
// //         ),
// //         duration: duration,
// //       ),
// //     );
// //   }

// //   // Method to send message,
// //   // for turning the bletooth device on
// //   void _sendOnMessageToBluetooth() {
// //     bluetooth.isConnected.then((isConnected) {
// //       if (isConnected) {
// //         bluetooth.write("1");
// //         show('Device Turned On');
// //       }
// //     });
// //   }

// //   // Method to send message,
// //   // for turning the bletooth device off
// //   void _sendOffMessageToBluetooth() {
// //     bluetooth.isConnected.then((isConnected) {
// //       if (isConnected) {
// //         bluetooth.write("0");
// //         show('Device Turned Off');
// //       }
// //     });
// //   }
// // /////////////////////////////////////////////////

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //         key: _scaffoldKey,
// //         appBar: AppBar(
// //           title: Text("Flutter Bluetooth"),
// //           backgroundColor: Colors.deepPurple,
// //         ),
// //         body: Container(
// //           // Defining a Column containing FOUR main Widgets wrapped with some padding:
// //           // 1. Text
// //           // 2. Row
// //           // 3. Card
// //           // 4. Text (wrapped with "Expanded" and "Padding")
// //           child: Column(
// //             mainAxisSize: MainAxisSize.max,
// //             children: <Widget>[
// //               Padding(
// //                 padding: const EdgeInsets.only(top: 8.0),
// //                 child: Text(
// //                   "PAIRED DEVICES",
// //                   style: TextStyle(fontSize: 24, color: Colors.blue),
// //                   textAlign: TextAlign.center,
// //                 ),
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.all(8.0),
// //                 // Defining a Row containing THREE main Widgets:
// //                 // 1. Text
// //                 // 2. DropdownButton
// //                 // 3. RaisedButton
// //                 child: Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: <Widget>[
// //                     Text(
// //                       'Device:',
// //                       style: TextStyle(
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     ),
// //                     DropdownButton(
// //                       // To be implemented : _getDeviceItems()
// //                       items: _getDeviceItems(),
// //                       onChanged: (value) => setState(() => _device = value),
// //                       value: _device,
// //                     ),
// //                     RaisedButton(
// //                       onPressed:
// //                           // To be implemented : _disconnect and _connect
// //                           _pressed
// //                               ? null
// //                               : _connected
// //                                   ? _disconnect
// //                                   : _connect,
// //                       child: Text(_connected ? 'Disconnect' : 'Connect'),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.all(16.0),
// //                 child: Card(
// //                   elevation: 4,
// //                   child: Padding(
// //                     padding: const EdgeInsets.all(8.0),
// //                     // Defining a Row containing THREE main Widgets:
// //                     // 1. Text (wrapped with "Expanded")
// //                     // 2. FlatButton
// //                     // 3. FlatButton
// //                     child: Row(
// //                       children: <Widget>[
// //                         Expanded(
// //                           child: Text(
// //                             "DEVICE 1",
// //                             style: TextStyle(
// //                               fontSize: 20,
// //                               color: Colors.green,
// //                             ),
// //                           ),
// //                         ),
// //                         FlatButton(
// //                           onPressed:
// //                               // To be implemented : _sendOnMessageToBluetooth()
// //                               _connected ? _sendOnMessageToBluetooth : null,
// //                           child: Text("ON"),
// //                         ),
// //                         FlatButton(
// //                           onPressed:
// //                               // To be implemented : _sendOffMessageToBluetooth()
// //                               _connected ? _sendOffMessageToBluetooth : null,
// //                           child: Text("OFF"),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               Expanded(
// //                 child: Padding(
// //                   padding: const EdgeInsets.all(20),
// //                   child: Center(
// //                     child: Text(
// //                       "NOTE: If you cannot find the device in the list, "
// //                       "please turn on bluetooth and pair the device by "
// //                       "going to the bluetooth settings",
// //                       style: TextStyle(
// //                           fontSize: 15,
// //                           fontWeight: FontWeight.bold,
// //                           color: Colors.red),
// //                     ),
// //                   ),
// //                 ),
// //               )
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// }
