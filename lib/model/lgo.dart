import 'slider_parent.dart';

class Lgo extends SliderParent {
  final String image;
  Lgo({required super.nom, required super.niveau, required this.image});
  static List<Lgo> fromJson(List<dynamic> json) {
    if (json.isEmpty) {
      return [];
    } else {
      return json
          .map((e) => Lgo(
                niveau: e['niveau'] as double,
                nom: e['nom'] as String,
                image: e['image'] as String,
              ))
          .toList();
    }
  }
}
