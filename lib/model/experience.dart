class Experience {
  String _nomPharmacie;
  int _anneeDebut;
  int _anneeFin;
  String get nomPharmacie => _nomPharmacie;

  set nomPharmacie(String value) => _nomPharmacie = value;

  get anneeDebut => _anneeDebut;

  set anneeDebut(value) => _anneeDebut = value;

  get anneeFin => _anneeFin;

  set anneeFin(value) => _anneeFin = value;

  Experience(
      {required String nomPharmacie,
      required int anneeDebut,
      required int anneeFin})
      : _nomPharmacie = nomPharmacie,
        _anneeDebut = anneeDebut,
        _anneeFin = anneeFin;
  Map<String, dynamic> toJson() {
    return {
      "nom-pharmacie": _nomPharmacie,
      "annee-debut": _anneeDebut,
      "anne-fin": _anneeFin,
    };
  }

  static List<Experience> fromJson(List<dynamic> json) {
    if (json.isEmpty) {
      return [];
    } else {
      return json
          .map((e) => Experience(
              anneeDebut: e['annee-debut'] as int,
              anneeFin: e['annee-fin'] as int,
              nomPharmacie: e['nom-pharmacie'] as String))
          .toList();
    }
  }
}
