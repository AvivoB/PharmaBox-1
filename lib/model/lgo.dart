import 'slider_parent.dart';

class Lgo extends SliderParent {
  Lgo({required super.nom, required super.niveau});
  static List<Lgo> fromJson(List<dynamic> json) {
    if (json.isEmpty) {
      return [];
    } else {
      return json
          .map((e) => Lgo(
                niveau: e['niveau'] as double,
                nom: e['nom'] as String,
              ))
          .toList();
    }
  }
}
