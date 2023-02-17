class Universite {
  String _nom;

  String get nom => _nom;

  set nom(String value) => _nom = value;

  Universite({required String nom}) : _nom = nom;
  
  Map<String, dynamic> toJson() {
    return {
      "nom": nom,
    };
  }
  static List<Universite> fromJson(List<dynamic> json) {
    if (json.isEmpty) {
      return [];
    } else {
     return json.map((e) => Universite(
      nom: e['nom'] as String)).toList();
    }
  }
}
