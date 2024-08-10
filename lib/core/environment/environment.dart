class EnvironmentSetup {
  static void run({required Environment environment}) {
    env = environment;
  }

  static String get baseUrl => env == Environment.live ? _liveUrl : _testUrl;

  static const String _url = "https://api.openweathermap.org/";
  static late Environment env;
  static const String _liveUrl = _url;
  static const String _testUrl = _url;
}

enum Environment { live, test }
