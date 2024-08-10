import 'package:renweather/app/shared/shared.dart';

class WeatherModel {
  Coord coord;
  List<Weather> weather;
  String base;
  Main main;
  int visibility;
  Wind wind;
  Clouds clouds;
  int dt;
  Sys sys;
  int timezone;
  int id;
  String name;
  int cod;

  WeatherModel({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        coord: Coord.fromJson(json["coord"]),
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        base: json["base"],
        main: Main.fromJson(json["main"]),
        visibility: json["visibility"],
        wind: Wind.fromJson(json["wind"]),
        clouds: Clouds.fromJson(json["clouds"]),
        dt: json["dt"],
        sys: Sys.fromJson(json["sys"]),
        timezone: json["timezone"],
        id: json["id"],
        name: json["name"],
        cod: json["cod"],
      );
}

class Clouds {
  int all;

  Clouds({
    required this.all,
  });

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json["all"],
      );

  Map<String, dynamic> toJson() => {
        "all": all,
      };
}

class Coord {
  double lon;
  double lat;

  Coord({
    required this.lon,
    required this.lat,
  });

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lon: json["lon"]?.toDouble(),
        lat: json["lat"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lon": lon,
        "lat": lat,
      };
}

class Main {
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int humidity;
  int seaLevel;
  int grndLevel;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.grndLevel,
  });

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"]?.toDouble(),
        feelsLike: json["feels_like"]?.toDouble(),
        tempMin: json["temp_min"]?.toDouble(),
        tempMax: json["temp_max"]?.toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
        seaLevel: json["sea_level"],
        grndLevel: json["grnd_level"],
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "humidity": humidity,
        "sea_level": seaLevel,
        "grnd_level": grndLevel,
      };
}

class Sys {
  final String country;
  final int _sunrise;
  final int _sunset;

  Sys({
    required this.country,
    required int sunrise,
    required int sunset,
  })  : _sunrise = sunrise,
        _sunset = sunset;

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        country: json["country"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
      );

  String get sunriseTime => convertUnixTimestampToReadableTime(_sunrise);

  String get sunsetTime => convertUnixTimestampToReadableTime(_sunset);
}

class Weather {
  int id;
  String main;
  String description;
  String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };
  String get animationIcon {
    switch (description) {
      case var desc when desc.contains('clouds'):
        return "cloudy".animations;
      case var desc when desc.contains('rain'):
        return "rain".animations;
      case var desc when desc.contains('sun'):
        return "sun".animations;
      case var desc when desc.contains('snow'):
        return "snow".animations;
      case var desc when desc.contains('storm'):
        return "thunder-storm".animations;
    }
    return "";
  }
}

class Wind {
  double speed;
  int deg;

  Wind({
    required this.speed,
    required this.deg,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"]?.toDouble(),
        deg: json["deg"],
      );

  Map<String, dynamic> toJson() => {
        "speed": speed,
        "deg": deg,
      };
}
