class CityLocationModel {
  String city;
  String lat;
  String long;
  String country;

  CityLocationModel({
    required this.city,
    required this.country,
    required this.lat,
    required this.long,
  });

  factory CityLocationModel.fromJson(Map<String, dynamic> json) {
    return CityLocationModel(
      city: json['city'],
      lat: json['lat'],
      long: json['lng'],
      country: json['country'],
    );
  }
}
