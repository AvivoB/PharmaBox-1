import 'package:pharmabox/model/slider_parent.dart';

class Langue extends SliderParent{
  Langue({required super.nom, required super.niveau});
 static List<Langue> fromJson(List<dynamic> json) {
    if (json.isEmpty) {
      return [];
    } else {
     return json.map((e) => Langue(niveau: e['niveau'] as double,
      nom: e['nom'] as String)).toList();
    }
  }
}

