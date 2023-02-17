class Localisation {
  final String _ville;
  final int _codePostal;

  Localisation({required String ville, required int codePostal})
      : _ville = ville,
        _codePostal = codePostal;

  String get ville => _ville;
  int get codePostal => _codePostal;
}
