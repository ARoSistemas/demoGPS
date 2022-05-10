// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:math';

import 'package:background_location/background_location.dart';
import 'package:flutter/material.dart';

class BackgroundPage extends StatefulWidget {
  static String idPage = 'BackgroundPage';

  const BackgroundPage({Key? key}) : super(key: key);

  @override
  State<BackgroundPage> createState() => _BackgroundPageState();
}

class _BackgroundPageState extends State<BackgroundPage> {
  Location dtaLocation = Location(
    longitude: 0.0,
    latitude: 0.0,
    altitude: 0.0,
    accuracy: 0.0,
    bearing: 0.0,
    speed: 0.0,
    time: 0.0,
    isMock: false,
  );

  Timer? _timer;

  List colors = [
    Colors.black,
    Colors.amber,
    Colors.blue,
    Colors.blueGrey,
    Colors.brown,
    Colors.cyan,
    Colors.indigo,
    Colors.orange,
    Colors.pink,
    Colors.teal,
    Colors.red,
    Colors.green,
    Colors.yellow,
  ];

  Random random = Random();

  int index = 0;

  void onInitBG() async {
    await BackgroundLocation.setAndroidNotification(
      title: 'Background service is running',
      message: 'Background location in progress',
      icon: '@mipmap/ic_launcher',
    );

    await BackgroundLocation.startLocationService(distanceFilter: 0.0);
  }

  void onStop() {
    BackgroundLocation.stopLocationService();
  }

  void startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (_timer) {
      BackgroundLocation.getLocationUpdates((location) {
        setState(() {
          dtaLocation = location;
          index = random.nextInt(13);
        });

        print('''\n
      😗
        Latitude:  ${location.latitude.toString()}
        Longitude: ${location.longitude.toString()}
        Altitude: ${location.altitude.toString()}
        Accuracy: ${location.accuracy.toString()}
        Bearing:  ${location.bearing.toString()}
        Speed: ${location.speed.toString()}
        time: ${DateTime.fromMillisecondsSinceEpoch(location.time!.toInt()).toString()}
    ''');
      });
    });
  }

  @override
  void initState() {
    super.initState();

    onInitBG();

    startTimer();
  }

  @override
  void dispose() {
    print('💀 Dispose Background GPS ');

    if (_timer != null) {
      _timer!.cancel();
    }
    onStop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo Background'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${dtaLocation.latitude.toString()}, ${dtaLocation.longitude.toString()}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colors[index],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              DateTime.fromMillisecondsSinceEpoch(dtaLocation.time!.toInt())
                  .toString(),
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
