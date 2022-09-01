import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notify_app/src/http/sendNotification.dart';
import 'package:pushy_flutter/pushy_flutter.dart';

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

  @override
  void initState() {
    super.initState();
  }

  Future<void> pushyInitialization() async {
    // Start the Pushy service
    Pushy.listen();

    // // Enable FCM Fallback Delivery
    // Enable FCM fallback delivery
    Pushy.toggleFCM(true);

    // Set custom notification icon (Android)
    Pushy.setNotificationIcon('ic_notify');

    Pushy.toggleNotifications(true);

    try {
      // Register the device for push notifications
      String deviceToken = await Pushy.register();

      // Print token to console/logcat
      print('Device token: $deviceToken');

      // Send the token to your backend server
      // ...

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
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: ()  {
                    pushyInitialization();
                  },
                  child: const Text(
                    'init',
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
                    await sendNotification();
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
