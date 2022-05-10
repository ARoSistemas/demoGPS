import 'package:demo_bg_location/view/ui/background_page.dart';
import 'package:demo_bg_location/view/ui/geolocator_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import 'package:demo_bg_location/controllers/my_gps.dart';
import 'package:demo_bg_location/view/ui/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.5;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyGps()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'arosistemas.com',
        routes: {
          MyHome.idPage: (_) => const MyHome(),
          BackgroundPage.idPage: (_) => const BackgroundPage(),
          GeolocatorPage.idPage: (_) => const GeolocatorPage(),
        },
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: const MyHome(),
      ),
    );
  }
}
