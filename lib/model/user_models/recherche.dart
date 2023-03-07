import 'dart:convert';

import '../horaire.dart';

class Recherche {
  String nom;
  String userId;
  bool state;
  String poste;

  String localisation;
  int rayon;
  String duree;
  List<String> contrat;
  String temps;
  double salaireNet;
  List<Horaire> horaires;
  List<Horaire> horairesImpaires;
  bool debut;
  bool salaireEnsemble;
  bool emploisDuTemps;

  bool creche;
  bool frais;
  bool logement;
  bool semainePaire;

  bool rer;
  bool metro;
  bool bus;
  bool tramway;
  bool gareAccess;
  bool parking;
  String date;
  bool robot;
  bool electronicLabels;
  bool salleDePause;
  bool vigile;

  bool testCovid;
  bool vaccination;
  bool entretien;
  Recherche({
    this.nom = '',
    required this.state,
    required this.poste,
    this.userId = '',
    required this.localisation,
    required this.rayon,
    required this.duree,
    required this.contrat,
    required this.temps,
    required this.salaireNet,
    required this.horaires,
    required this.horairesImpaires,
    required this.debut,
    required this.salaireEnsemble,
    required this.emploisDuTemps,
    required this.creche,
    required this.frais,
    required this.logement,
    required this.semainePaire,
    required this.rer,
    required this.metro,
    required this.bus,
    required this.tramway,
    required this.gareAccess,
    required this.parking,
    required this.date,
    required this.robot,
    required this.electronicLabels,
    required this.salleDePause,
    required this.vigile,
    required this.testCovid,
    required this.vaccination,
    required this.entretien,
  });

  toMap() {
    return {
      'nom': nom,
      'state': state,
      'poste': poste,
      'userId': userId,
      'localisation': localisation,
      'rayon': rayon,
      'duree': duree,
      'contrat': contrat,
      'temps': temps,
      'salaireNet': salaireNet,
      'horaires': horaires.map((x) => x.toMap()).toList(),
      'horairesImpaires': horairesImpaires.map((x) => x.toMap()).toList(),
      'debut': debut,
      'salaireEnsemble': salaireEnsemble,
      'emploisDuTemps': emploisDuTemps,
      'creche': creche,
      'frais': frais,
      'logement': logement,
      'semainePaire': semainePaire,
      'rer': rer,
      'metro': metro,
      'bus': bus,
      'tramway': tramway,
      'gareAccess': gareAccess,
      'parking': parking,
      'date': date,
      'robot': robot,
      'electronicLabels': electronicLabels,
      'salleDePause': salleDePause,
      'vigile': vigile,
      'testCovid': testCovid,
      'vaccination': vaccination,
      'entretien': entretien,
    };
  }

  factory Recherche.fromMap(Map<String, dynamic> map) {
    final List<dynamic> contratJson = map['contrat'];
    List<dynamic> horrairesJson = map['horaires'];
    List<dynamic> pairesJson = map['horairesImpaires'];
    List<String> contrats = [];
    List<Horaire> horaires = [];
    List<Horaire> horairesImp = [];
    horaires = horrairesJson.map((e) => Horaire.fromMap(e)).toList();
    horairesImp = pairesJson.map((e) => Horaire.fromMap(e)).toList();

    contrats = contratJson.map((e) => e.toString()).toList();

    return Recherche(
      nom: map['nom'] as String,
      state: map['state'] as bool,
      poste: map['poste'] as String,
      userId : map['userId'] as String,
      localisation: map['localisation'] as String,
      rayon: map['rayon'] as int,
      duree: map['duree'] as String,
      contrat: contrats,
      temps: map['temps'] as String,
      salaireNet: map['salaireNet'] as double,
      horaires: horaires,
      horairesImpaires: horairesImp,
      debut: map['debut'] as bool,
      salaireEnsemble: map['salaireEnsemble'] as bool,
      emploisDuTemps: map['emploisDuTemps'] as bool,
      creche: map['creche'] as bool,
      frais: map['frais'] as bool,
      logement: map['logement'] as bool,
      semainePaire: map['semainePaire'] as bool,
      rer: map['rer'] as bool,
      metro: map['metro'] as bool,
      bus: map['bus'] as bool,
      tramway: map['tramway'] as bool,
      gareAccess: map['gareAccess'] as bool,
      parking: map['parking'] as bool,
      date: map['date'] as String,
      robot: map['robot'] as bool,
      electronicLabels: map['electronicLabels'] as bool,
      salleDePause: map['salleDePause'] as bool,
      vigile: map['vigile'] as bool,
      testCovid: map['testCovid'] as bool,
      vaccination: map['vaccination'] as bool,
      entretien: map['entretien'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Recherche.fromJson(String source) =>
      Recherche.fromMap(json.decode(source) as Map<String, dynamic>);
}
