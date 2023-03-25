import 'package:flutter/material.dart';
import 'package:pharmabox/model/lgo.dart';
import 'package:pharmabox/model/localisation.dart';
import 'package:pharmabox/model/telephone.dart';
import 'package:pharmabox/model/work_hours.dart';

import '../tendance.dart';

class Pharmacie {
  final String nom;
  List<String> titulaires;
  final List<String> images;
  final List<WorkHours> workHours;
  final String presentation;
  final bool maitre;
  final String groupementName;
  final String groupementImage;
  final String lgoName;
  final String lgoImage;
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
  final String typologie;
  final String nbPatients;

  final bool testCovid;
  final bool vaccination;
  final bool entretien;
  final bool preparation;
  final bool borneTelemedcine;

  final bool breakRoom;
  final bool robot;
  final bool electronicLabels;
  final bool monnaie;
  final bool climat;
  final bool chauffage;
  final bool vigil;
  final bool workConcil;
  final List<Tendance> tendances;

  final int nbPharmaciens;
  final int nbPreparateurs;
  final int nbRayonnistes;
  final int nbConseillers;
  final int nbApprentis;
  final int nbEtudiants;
  final int nbEtudiants6;
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
      "work_hours": workHours.map((e) => e.toJson()).toList(),
      "images": images,
      "maitre": maitre,
      "rer": rer,
      "non-stop": nonStop,
      "metro": metro,
      "tramway": tramway,
      "gare": gareAccess,
      "parking": parking,
      "typologie": typologie,
      "nombre-patients": nbPatients,
      "test-covid": testCovid,
      "vaccination": vaccination,
      "entretien": entretien,
      "preparation": preparation,
      "borne": borneTelemedcine,
      "break": breakRoom,
      "robot": robot,
      "electronic": electronicLabels,
      "monnaie": monnaie,
      "climat": climat,
      "chauffage":chauffage,
      "vigil":vigil,
      "workConcil":workConcil,
      "groupement-image": groupementImage,
      "groupement-name": groupementName,
      "lgo-name": lgoName,
      "lgo-image": lgoImage,
      "titulaires": titulaires,
      "tendances": tendances.map((e) => e.toJson()).toList(),
      "nombre-pharmaciens": nbPharmaciens,
      "nombre-preparateurs": nbPreparateurs,
      "nombre-rayonnistes": nbRayonnistes,
      "nombre-conseillers": nbConseillers,
      "nombre-apprentis": nbApprentis,
      "nombre-etudiants": nbEtudiants,
      "nombre-etudiants6": nbEtudiants6
    };
  }

  static Pharmacie fromJson(dynamic json) {
    List<dynamic> workHoursJson = json['work_hours'];
    List<String> images = [];
    List<String> titulaires = [];
    if (json.containsKey("images")) {
      List<dynamic> imagesJson = json['images'];
      images = imagesJson.map((e) => e.toString()).toList();
    }
    if (json.containsKey("titulaires")) {
      List<dynamic> titulairesJson = json['titulaires'];
      titulaires = titulairesJson.map((e) => e.toString()).toList();
    }
    List<WorkHours> workHours = WorkHours.fromJson(workHoursJson);
    List<dynamic> tendancesJson = json['tendances'];
    List<Tendance> tendances = Tendance.fromJson(tendancesJson);
    ////
    return Pharmacie(
      workHours: workHours,
      groupementImage: json["groupement-image"],
      groupementName: json["groupement-name"],
      lgoName: json['lgo-name'],
      lgoImage: json['lgo-image'],
      nom: json.containsKey("nom") ? json['nom'] ?? "" : "",
      email: json.containsKey("email") ? json["email"] ?? "" : "",
      borneTelemedcine: json["borne"] ?? "",
      breakRoom: json["break"] ?? "",
      bus: json.containsKey("bus") ? json["bus"] ?? "" : "",
      nonStop: json["non-stop"] ?? "",
      electronicLabels: json["electronic"],
      monnaie:json['monnaie'],
      climat:json['climat'],
      chauffage:json['chauffage'],
      vigil:json['vigil'],
      workConcil:json['workConcil'],
      entretien: json["entretien"],
      gareAccess: json["gare"],
      images: images,
      maitre: json["maitre"],
      typologie: json["typologie"],
      metro: json["metro"],
      nbPatients: json["nombre-patients"],
      nbPharmaciens: json["nombre-pharmaciens"],
      nbPreparateurs: json["nombre-preparateurs"],
      nbRayonnistes: json['nombre-rayonnistes'],
      nbApprentis: json['nombre-apprentis'],
      nbConseillers: json['nombre-conseillers'],
      nbEtudiants6: json['nombre-etudiants6'],
      nbEtudiants: json['nombre-etudiants'],
      parking: json["parking"],
      prefEmail: json["prefEmail"],
      preparation: json["preparation"],
      rer: json["rer"],
      robot: json["robot"],
      telephone: Telephone(numeroTelephone: json["telephone"], visible: false),
      testCovid: json["test-covid"],
      titulaires: titulaires,
      tramway: json["tramway"],
      vaccination: json["vaccination"],
      tendances: tendances,
      presentation: json["presentation"] as String,
      localisation: Localisation(
          codePostal: json['code-postal'] as int,
          ville: json['ville'] as String),
    );
  }

  Pharmacie( {
    required this.nom,
    required this.groupementImage,
    required this.groupementName,
    required this.lgoImage,
    required this.lgoName,
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
    required this.workHours,
    required this.gareAccess,
    required this.parking,
    required this.typologie,
    required this.nbPatients,
    required this.testCovid,
    required this.vaccination,
    required this.entretien,
    required this.preparation,
    required this.borneTelemedcine,
    required this.breakRoom,
    required this.robot,
    required this.electronicLabels,
 
 required this.monnaie,
 required  this.climat,
 required this.chauffage,
  required this.vigil,required this.workConcil,
    required this.tendances,
    required this.nbPharmaciens,
    required this.nbPreparateurs,
    required this.nbRayonnistes,
    required this.nbConseillers,
    required this.nbApprentis,
    required this.nbEtudiants,
    required this.nbEtudiants6,
  });
}
