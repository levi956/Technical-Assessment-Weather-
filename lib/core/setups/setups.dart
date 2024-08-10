import 'package:flutter/material.dart';
import 'package:renweather/app/shared/shared.dart';
import 'package:renweather/core/core.dart';

// Initializes the major actors for application functionality
class Setups {
  static Future<void> run() async {
    // Binding the flutter layer widget binding
    WidgetsFlutterBinding.ensureInitialized();

    // Device cache with shared_preferences
    await Preferences.initalize();

    // Sets the device orientation (targeting portrait mode)
    SetDeviceOrientation.setPortraitModeOnly();

    // Sets up the development environmnet (illustrating dev or live)
    EnvironmentSetup.run(environment: Environment.live);
  }
}
