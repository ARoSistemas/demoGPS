import 'package:flutter/cupertino.dart';

class MyGps with ChangeNotifier {
  MyGps() {
    // this constructor
  }

  // is permission Ok.
  bool _isPermissionOk = false;
  bool get isPermissionOk => _isPermissionOk;
  set isPermissionOk(bool value) {
    _isPermissionOk = value;
    notifyListeners();
  }

  // Position GPS
  String _thisGPS = '0, 0';
  String get thisGPS => _thisGPS;
  set thisGPS(String value) {
    _thisGPS = value;
    notifyListeners();
  }
}
