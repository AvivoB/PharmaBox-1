import 'slider_parent.dart';

class Tendance extends SliderParent{
  Tendance({required super.nom, required super.niveau});
  static List<Tendance> fromJson(List<dynamic> json) {
    if (json.isEmpty) {
      return [];
    } else {
     return json.map((e) => Tendance(niveau: e['niveau'] as double,
      nom: e['nom'] as String)).toList();
    }
  }
}
