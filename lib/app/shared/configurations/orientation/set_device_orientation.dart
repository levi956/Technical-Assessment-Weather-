import 'package:flutter/services.dart';

class SetDeviceOrientation {
  static final _potraitOrientations = [
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ];

  static Future<void> setPortraitModeOnly() async {
    await SystemChrome.setPreferredOrientations(_potraitOrientations);
  }
}
