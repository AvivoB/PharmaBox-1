class Competence {
  String _nom;
  bool _enabled;
  String _asset;

  String get nom => _nom;
  String get asset => _asset;
  set asset(String asset) => _asset = asset;
  set nom(String value) => _nom = value;

 bool get enabled => _enabled;

  set enabled(value) => _enabled = value;

  Competence(
      {required String nom, required bool enabled, required String asset})
      : _nom = nom,
        _enabled = enabled,
        _asset = asset;
  static List<Competence> fromJson(dynamic json) {
    if (json.isEmpty) {
      return [];
    } else {
      return [
        Competence(
            nom: "Test COVID",
            enabled: json["test 2"]!,
            asset: "assets/icons/covid.png"),
        Competence(
            nom: "Vaccination",
            enabled: json["test 3"]!,
            asset: "assets/icons/Vaccination.png"),
        Competence(
            nom: "Gestion du tiers payant",
            enabled: json["test 4"]!,
            asset: "assets/icons/recherches (1).png"),
        Competence(
            nom: "Gestion des labos",
            enabled: json["test Covid"]!,
            asset: "assets/icons/TesttubeIcon.png"),
      ];
    }
  }
}
