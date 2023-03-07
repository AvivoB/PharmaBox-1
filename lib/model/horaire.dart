import 'dart:convert';
//possible values: '','cross','check
// ignore_for_file: public_member_api_docs, sort_constructors_first
class Horaire {
   String matinee;
   String apresMidi;
   String soiree;
   String nuit;
  Horaire({
    required this.matinee,
    required this.apresMidi,
    required this.soiree,
    required this.nuit,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'matinee': matinee,
      'apresMidi': apresMidi,
      'soiree': soiree,
      'nuit': nuit,
    };
  }

  factory Horaire.fromMap(Map<String, dynamic> map) {
    return Horaire(
      matinee: map['matinee'] as String,
      apresMidi: map['apresMidi'] as String,
      soiree: map['soiree'] as String,
      nuit: map['nuit'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Horaire.fromJson(String source) => Horaire.fromMap(json.decode(source) as Map<String, dynamic>);
}
