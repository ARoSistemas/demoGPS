import 'package:demo_bg_location/controllers/my_gps.dart';
import 'package:demo_bg_location/view/ui/background_page.dart';
import 'package:demo_bg_location/view/ui/geolocator_page.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class MyHome extends StatelessWidget {
  static String idPage = 'MyHome';
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _thisController = Provider.of<MyGps>(context);

    void requestPermission() async {
      final PermissionStatus status =
          await Permission.locationWhenInUse.request();

      if (status == PermissionStatus.permanentlyDenied) {
        openAppSettings();
      }

      _thisController.isPermissionOk =
          (status == PermissionStatus.granted) ? true : false;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Demo GPS by ARo Sistemas')),
      body: Center(
        child: Column(
          children: [
            if (!_thisController.isPermissionOk) const Spacer(),
            if (_thisController.isPermissionOk) const Spacer(),
            Visibility(
              visible: _thisController.isPermissionOk,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, BackgroundPage.idPage);
                },
                child: const Text('GPS with Background'),
              ),
            ),
            if (_thisController.isPermissionOk) const Spacer(),
            Visibility(
              visible: _thisController.isPermissionOk,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, GeolocatorPage.idPage);
                },
                child: const Text('GPS with Geolocator'),
              ),
            ),
            if (_thisController.isPermissionOk) const Spacer(),
            Visibility(
              visible: !_thisController.isPermissionOk,
              child: ElevatedButton(
                onPressed: requestPermission,
                child: const Text('Check permissions'),
              ),
            ),
            if (_thisController.isPermissionOk) const Spacer(),
            if (!_thisController.isPermissionOk) const Spacer(),
          ],
        ),
      ),
    );
  }
}
