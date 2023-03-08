 import 'package:equatable/equatable.dart';

class SliderParent  extends Equatable{
  String _nom;
  double _niveau;

  String get nom => _nom;

  set nom(String value) => _nom = value;

  get niveau => _niveau;

  set niveau(value) => _niveau = value;

  SliderParent({required String nom, required double niveau})
      : _nom = nom,
        _niveau = niveau;
  Map<String, dynamic> toJson() {
    return {
      "nom": _nom,
      "niveau": _niveau,
    };
  }

  static List<SliderParent> fromJson(List<Map<String, dynamic>> json) {
    if (json.isEmpty) {
      return [];
    } else {
     return json.map((e) => SliderParent(niveau: e['niveau'] as double,
      nom: e['nom'] as String)).toList();
    }
    ;
  }
  
  @override
  // TODO: implement props
  List<Object?> get props => [nom];
}
