import 'package:equatable/equatable.dart';
import 'package:pharmabox/model/lgo.dart';
import 'package:pharmabox/model/localisation.dart';
import 'package:pharmabox/model/models.dart';

import '../competence.dart';
import '../experience.dart';
import '../langue.dart';
import '../telephone.dart';
import '../universite.dart';

class NonTitulaire extends Equatable {
  String _nom;
  String _prenom;
  String _email;
  String? _presentation;
  Telephone _telephone;
  String _poste;
  String photoUrl;
  List<Specialisation> specialisations;
  List<Competence> _competences;
  List<Langue> _langues;
  Localisation _localisation;
  List<Universite> _universites;
  List<Experience> _experiences;
  List<Lgo> _lgos;
  bool _droitOffres;
  bool _accepterConditions;
  String _dateNaissance;
  String get nom => _nom;

  set nom(value) => _nom = value;
  String get dateNaissance => _dateNaissance;
  String get prenom => _prenom;

  set prenom(value) => _prenom = value;

  String get email => _email;

  set email(value) => _email = value;

  Telephone get telephone => _telephone;

  set telephone(value) => _telephone = value;

  String get poste => _poste;

  set poste(value) => _poste = value;

  List<Competence> get competences => _competences;

  set competences(value) => _competences = value;

  List<Langue> get langues => _langues;

  set langues(value) => _langues = value;

  List<Universite> get universites => _universites;

  set universites(value) => _universites = value;

  List<Experience> get experiences => _experiences;

  set experiences(value) => _experiences = value;
  Localisation get localisation => _localisation;

  bool get droitOffres => _droitOffres;
  List<Lgo> get lgos => _lgos;
  set droitOffres(value) => _droitOffres = value;

  bool get accepterConditions => _accepterConditions;

  set accepterConditions(value) => _accepterConditions = value;
  NonTitulaire({
    required String nom,
    required String prenom,
    required String email,
    required Telephone telephone,
    required this.specialisations,
    required String poste,
    required bool droitOffres,
    required this.photoUrl,
    required String dateNaissance,
    required List<Lgo> lgos,
    required Localisation localisation,
    required bool accepterConditions,
  })  : _nom = nom,
        _prenom = prenom,
        _email = email,
        _telephone = telephone,
        _poste = poste,
        _lgos = lgos,
        _droitOffres = droitOffres,
        _localisation = localisation,
        _accepterConditions = accepterConditions,
        _dateNaissance = dateNaissance,
        _experiences = [],
        _universites = [],
        _langues = [],
        _competences = [];
  NonTitulaire.creation({
    required String nom,
    required this.photoUrl,
    required this.specialisations,
    required String prenom,
    required String email,
    required Telephone telephone,
    required String poste,
    required List<Experience> experiences,
    required List<Lgo> lgos,
    required List<Universite> universites,
    String? presentation,
    required String naissance,
    required List<Langue> langues,
    required Localisation localisation,
    required List<Competence> competences,
    required bool droitOffres,
    required bool accepterConditions,
  })  : _nom = nom,
        _prenom = prenom,
        _email = email,
        _dateNaissance = naissance,
        _presentation = presentation,
        _telephone = telephone,
        _poste = poste,
        _lgos = lgos,
        _droitOffres = droitOffres,
        _localisation = localisation,
        _accepterConditions = accepterConditions,
        _experiences = experiences,
        _universites = universites,
        _langues = langues,
        _competences = competences;
  dynamic toJson() {
    return {
      "nom": _nom,
      "prenom": prenom,
      "poste": poste,
      "email": email,
      "specialisations": specialisations.map((e) => e.toJson()).toList(),
      "photo": photoUrl,
      "date-naissance": _dateNaissance,
      "telephone": _telephone.numeroTelephone,
      "code-postal": _localisation.codePostal,
      "ville": _localisation.ville,
      "presentation": _presentation,
      "universites": _universites.map((e) => e.toJson()).toList(),
      "langues": _langues.map((e) => e.toJson()).toList(),
      "experiences": _experiences.map((e) => e.toJson()).toList(),
      "lgos": _lgos.map((e) => e.toJson()).toList(),
      "competences": {
        "test Covid": _competences[0].enabled,
        "test 2": _competences[1].enabled,
        "test 3": _competences[2].enabled,
        "test 4": _competences[3].enabled,
      },
      "droit_offres": _droitOffres,
      "accepte_conditions": _accepterConditions,
    };
  }

  static NonTitulaire fromJson(Map<String, dynamic> json) {
    List<dynamic> lgosJson = json['lgos'];
    List<dynamic> specialisationJson = json["specialisations"];
    List<Specialisation> specialisations =
        Specialisation.fromJson(specialisationJson);
    List<Lgo> lgos = Lgo.fromJson(lgosJson);
    ////
    List<dynamic> languesJson = json['langues'];
    List<Langue> langues = Langue.fromJson(languesJson);
    /////
    List<dynamic> experiencesJson = json['experiences'];
    List<Experience> experiences = Experience.fromJson(experiencesJson);
    /////
    List<dynamic> universitesJson = json['universites'];
    List<Universite> universites = Universite.fromJson(universitesJson);
    ///////
    Map<String, dynamic> competencesJson = json['competences'];
    List<Competence> competences = Competence.fromJson(competencesJson);
    return NonTitulaire.creation(
        nom: json['nom'] as String,
        specialisations: specialisations,
        photoUrl: json.containsKey("photo") ? json["photo"] ?? "" : "",
        prenom: json['prenom'] as String,
        email: json['email'] as String,
        telephone:
            Telephone(numeroTelephone: json['telephone'], visible: false),
        poste: json['poste'] as String,
        droitOffres: json['droit_offres'] as bool,
        lgos: lgos,
        langues: langues,
        experiences: experiences,
        universites: universites,
        presentation: json["presentation"] as String,
        naissance: json['date-naissance'] as String,
        competences: competences,
        localisation: Localisation(
            codePostal: json['code-postal'] as int,
            ville: json['ville'] as String),
        accepterConditions: json['accepte_conditions'] as bool);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [email];
}
