import 'package:pharmabox/model/lgo.dart';
import 'package:pharmabox/model/localisation.dart';
import 'package:pharmabox/model/telephone.dart';
import 'package:pharmabox/model/tenance.dart';

class Pharmacie {
  final String nom;
  List<String> titulaires;
  final List<String> images;
  final String presentation;
  final bool maitre;
  final bool nonStop;
  final String email;
  final Telephone telephone;
  final String prefEmail;
  final Localisation localisation;
  final String rer;
  final String metro;
  final String bus;
  final String tramway;
  final String gareAccess;
  final String parking;
  final bool centreCommercial;
  final bool centreVille;
  final bool aeroport;
  final bool gareTyp;
  final bool quartier;
  final bool touristique;
  final bool rurale;
  final int nbPatients;

  final bool testCovid;
  final bool vaccination;
  final bool entretien;
  final bool preparation;
  final bool borneTelemedcine;

  final List<Lgo> lgos;
  final bool breakRoom;
  final bool robot;
  final bool electronicLabels;
  final bool automatic;
  final bool airCond;
  final bool heating;
  final bool vigile;
  final List<Tendance> tendances;
  final int nbPharmaciens;
  final int nbPreparateurs;
  dynamic toJson() {
    return {
      "nom": nom,
      "email": email,
      "bus": bus,
      "prefEmail": prefEmail,
      "telephone": telephone.numeroTelephone,
      "code-postal": localisation.codePostal,
      "ville": localisation.ville,
      "presentation": presentation,
      "images": images,
      "maitre": maitre,
      "rer": rer,
      "non-stop": nonStop,
      "metro": metro,
      "tramway": tramway,
      "gare": gareAccess,
      "parking": parking,
      "centre-commercial": centreCommercial,
      "centre-ville": centreVille,
      "aeroport": aeroport,
      "gareTyp": gareTyp,
      "quartier": quartier,
      "titulaires": titulaires,
      "touristique": touristique,
      "rurale": rurale,
      "nombre-patients": nbPatients,
      "test-covid": testCovid,
      "vaccination": vaccination,
      "entretien": entretien,
      "preparation": preparation,
      "borne": borneTelemedcine,
      "lgos": lgos.map((e) => e.toJson()).toList(),
      "break": breakRoom,
      "robot": robot,
      "electronic": electronicLabels,
      "automatic": automatic,
      "air": airCond,
      "heating": heating,
      "vigile": vigile,
      "tendances": tendances.map((e) => e.toJson()).toList(),
      "nombre-pharmaciens": nbPharmaciens,
      "nombre-preparateurs": nbPreparateurs,
    };
  }

  static Pharmacie fromJson(dynamic json) {
    List<dynamic> lgosJson = json['lgos'];
    List<String> images = [];
    List<String> titulaires = [];
    if (json.containsKey("images")) {
      print("kaynin");
      List<dynamic> imagesJson = json['images'];
      images = imagesJson.map((e) => e.toString()).toList();
    }
    if (json.containsKey("titulaires")) {
      List<dynamic> titulairesJson = json['titulaires'];
      titulaires =
          titulairesJson.map((e) => e.toString()).toList();
    }
      print(images[0]);

    List<Lgo> lgos = Lgo.fromJson(lgosJson);
    List<dynamic> tendancesJson = json['tendances'];
    List<Tendance> tendances = Tendance.fromJson(tendancesJson);
    ////
    return Pharmacie(
      nom: json.containsKey("nom") ? json['nom'] ?? "" : "",
      email: json.containsKey("email") ? json["email"] ?? "" : "",
      aeroport: json.containsKey("aeroport") ? json["aeroport"] ?? "" : "",
      airCond: json.containsKey("air") ? json["air"] ?? "" : "",
      automatic: json.containsKey("automatic") ? json["automatic"] ?? "" : "",
      borneTelemedcine: json["borne"] ?? "",
      breakRoom: json["break"] ?? "",
      bus: json.containsKey("bus") ? json["bus"] ?? "" : "",
      nonStop: json["non-stop"] ?? "",
      centreCommercial: json["centre-commercial"],
      centreVille: json["centre-ville"],
      electronicLabels: json["electronic"],
      entretien: json["entretien"],
      gareAccess: json["gare"],
      gareTyp: json["gareTyp"],
      heating: json["heating"],
      images: images,
      maitre: json["maitre"],
      metro: json["metro"],
      nbPatients: json["nombre-patients"],
      nbPharmaciens: json["nombre-pharmaciens"],
      nbPreparateurs: json["nombre-preparateurs"],
      parking: json["parking"],
      prefEmail: json["prefEmail"],
      preparation: json["preparation"],
      quartier: json["quartier"],
      rer: json["rer"],
      robot: json["robot"],
      rurale: json["rurale"],
      telephone: Telephone(numeroTelephone: json["telephone"], visible: false),
      testCovid: json["test-covid"],
      titulaires: titulaires,
      touristique: json["touristique"],
      tramway: json["tramway"],
      vaccination: json["vaccination"],
      vigile: json["vigile"],
      lgos: lgos,
      tendances: tendances,
      presentation: json["presentation"] as String,
      localisation: Localisation(
          codePostal: json['code-postal'] as int,
          ville: json['ville'] as String),
    );
  }

  Pharmacie({
    required this.nom,
    required this.titulaires,
    required this.images,
    required this.presentation,
    required this.maitre,
    required this.email,
    required this.telephone,
    required this.prefEmail,
    required this.localisation,
    required this.rer,
    required this.metro,
    required this.nonStop,
    required this.bus,
    required this.tramway,
    required this.gareAccess,
    required this.parking,
    required this.centreCommercial,
    required this.centreVille,
    required this.aeroport,
    required this.gareTyp,
    required this.quartier,
    required this.touristique,
    required this.rurale,
    required this.nbPatients,
    required this.testCovid,
    required this.vaccination,
    required this.entretien,
    required this.preparation,
    required this.borneTelemedcine,
    required this.lgos,
    required this.breakRoom,
    required this.robot,
    required this.electronicLabels,
    required this.automatic,
    required this.airCond,
    required this.heating,
    required this.vigile,
    required this.tendances,
    required this.nbPharmaciens,
    required this.nbPreparateurs,
  });
}
