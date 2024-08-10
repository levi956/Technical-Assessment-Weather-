extension AssetPathsExtensions on String {
  String get icon => 'assets/icons/$this.svg';
  String get json => 'assets/$this.json';
  String get animations => 'assets/animations/$this.json';
  String get jpg => 'assets/images/$this.jpg';
  String get png => 'assets/images/$this.png';
}
