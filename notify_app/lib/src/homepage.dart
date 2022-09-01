import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notify_app/src/http/sendNotification.dart';
import 'package:notify_app/src/http/updateToken.dart';
import 'package:pushy_flutter/pushy_flutter.dart';

const List<Widget> toggleSwitch = <Widget>[Text('On'), Text('Off')];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

void backgroundNotificationListener(Map<String, dynamic> data) {
  // Print notification payload data
  print('Received notification: $data');

  // Notification title
  String notificationTitle = 'NotifyApp';

  // Attempt to extract the "message" property from the payload: {"message":"Hello World!"}
  String notificationText = data['message'] ?? 'Hello World!';

  // Android: Displays a system notification
  // iOS: Displays an alert dialog
  Pushy.notify(notificationTitle, notificationText, data);

  // Clear iOS app badge number
  Pushy.clearBadge();
}

class _HomePageState extends State<HomePage> {
  String _deviceToken = 'Loading...';
  List<bool> _FCMvalue = <bool>[true, false];
  List<bool> _enableNotification = <bool>[true, false];
  List<bool> _loopingNotification = <bool>[false, true];

  @override
  void initState() {
    super.initState();
    pushyInitialization();
  }

  Future<void> pushyInitialization() async {
    // Start the Pushy service
    Pushy.listen();

    // // Enable FCM Fallback Delivery
    Pushy.toggleFCM(false);

    // Set custom notification icon (Android)
    Pushy.setNotificationIcon('ic_notify');

    Pushy.toggleNotifications(true);


    try {
      // Register the device for push notifications
      String deviceToken = await Pushy.register();

      // Print token to console/logcat
      print('Device token: $deviceToken');

      // Send the token to your backend server
      await updateToken(deviceToken,"0");

      // Update UI with token
      setState(() {
        _deviceToken = deviceToken;
      });
    } on PlatformException catch (error) {
      // Print to console/logcat
      print('Error: ${error.message}');
    }

    //Set listener
    Pushy.setNotificationListener(backgroundNotificationListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(_deviceToken,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.grey[700])),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right:30,top:30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Notifications: ',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  ToggleButtons(
                    direction: Axis.horizontal,
                    onPressed: (int index) {
                      setState(() {
                        // The button that is tapped is set to true, and the others to false.
                        for (int i = 0; i < _enableNotification.length; i++) {
                          _enableNotification[i] = i == index;
                        }
                         Pushy.toggleNotifications(_enableNotification[0]);

                      });
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    selectedBorderColor: Colors.red[700],
                    selectedColor: Colors.white,
                    fillColor: Colors.red[200],
                    color: Colors.red[400],
                    constraints: const BoxConstraints(
                      minHeight: 30.0,
                      minWidth: 70.0,
                    ),
                    isSelected: _enableNotification,
                    children: toggleSwitch,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right:30,top:30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Toggle FCM Fallback: ',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  ToggleButtons(
                    direction: Axis.horizontal,
                    onPressed: (int index) {
                      setState(() {
                        // The button that is tapped is set to true, and the others to false.
                        for (int i = 0; i < _FCMvalue.length; i++) {
                          _FCMvalue[i] = i == index;
                        }
                        Pushy.toggleFCM(_FCMvalue[0]);
                      });
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    selectedBorderColor: Colors.red[700],
                    selectedColor: Colors.white,
                    fillColor: Colors.red[200],
                    color: Colors.red[400],
                    constraints: const BoxConstraints(
                      minHeight: 30.0,
                      minWidth: 70.0,
                    ),
                    isSelected: _FCMvalue,
                    children: toggleSwitch,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right:30,top:30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Loop Notifications: ',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  ToggleButtons(
                    direction: Axis.horizontal,
                    onPressed: (int index) {
                      setState(() {
                        // The button that is tapped is set to true, and the others to false.
                        for (int i = 0; i < _loopingNotification.length; i++) {
                          _loopingNotification[i] = i == index;
                        }
                        Pushy.toggleFCM(_loopingNotification[0]);
                      });
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    selectedBorderColor: Colors.red[700],
                    selectedColor: Colors.white,
                    fillColor: Colors.red[200],
                    color: Colors.red[400],
                    constraints: const BoxConstraints(
                      minHeight: 30.0,
                      minWidth: 70.0,
                    ),
                    isSelected: _loopingNotification,
                    children: toggleSwitch,
                  ),
                ],
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    Pushy.toggleNotifications(false);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () async {
                    await updateToken(_deviceToken,"0");
                  },
                  child: const Text(
                    'test API',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
