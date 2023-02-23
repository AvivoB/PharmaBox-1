class Specialisation {
  String _nom;

  String get nom => _nom;

  set nom(String value) => _nom = value;
  Map<String, dynamic> toJson() {
    return {
      "nom": nom,
    };
  }
  static List<Specialisation> fromJson(List<dynamic> json) {
    if (json.isEmpty) {
      return [];
    } else {
     return json.map((e) => Specialisation(
      nom: e['nom'] as String)).toList();
    }
  }
  Specialisation({required String nom}) : _nom = nom;
}
