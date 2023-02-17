class PharmacyModel {
  String? email;
  String? phone;
  String? address;
  String? rer;
  String? metro;
  String? bus;
  String? tram;
  String? station;
  String? pharName;
  String? userName;
  String? des;
  String? id;
  String? pharmacistsCount;
  String? preparersCount;
  bool? nonStop;

  ///typo logie
  bool? typocc;
  bool? typocv;
  bool? typoAero;
  bool? typoGare;
  bool? typoQuartier;
  bool? typoTour;
  bool? typoRula;
  String? noPatientPerDay;

  ///missions
  bool? testCovid;
  bool? vaccination;
  bool? pMaintaince;
  bool? pbTeam;
  bool? tTerminal;

  ///comfort
  bool? breakRoom;
  bool? robot;
  bool? eLabels;
  bool? autoCm;
  bool? ac;
  bool? heating;
  bool? vigil;
  bool? workConcil;

  PharmacyModel();

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'phone': phone,
      'rer': rer,
      'metro': metro,
      'bus': bus,
      'tram': tram,
      'station': station,
      'pharName': pharName,
      'userName': userName,
      'des': des,
      'id': id,
      'address': address,
      'pharmacistsCount': pharmacistsCount,
      'preparersCount': preparersCount,
      'nonStop': nonStop,

      ///typo logie
      'typocc': typocc,
      'typocv': typocv,
      'typoAero': typoAero,
      'typoGare': typoGare,
      'typoQuartier': typoQuartier,
      'typoTour': typoTour,
      'typoRula': typoRula,
      'noPatientPerDay': noPatientPerDay,

      ///mission
      'testCovid': testCovid,
      'vaccination': vaccination,
      'pMaintaince': pMaintaince,
      'pbTeam': pbTeam,
      'tTerminal': tTerminal,

      'breakRoom': breakRoom,
      'robot': robot,
      'eLabels': eLabels,
      'autoCm': autoCm,
      'ac': ac,
      'heating': heating,
      'vigil': vigil,
      'workConcil': workConcil,
    };
  }

  PharmacyModel.fromJson(Map<dynamic, dynamic> json) {

    breakRoom = json['breakRoom'];
    robot = json['robot'];
    eLabels = json['eLabels'];
    autoCm = json['autoCm'];
    ac = json['ac'];
    heating = json['heating'];
    vigil = json['vigil'];
    workConcil = json['workConcil'];

    ///mission
    testCovid = json['testCovid'];
    vaccination = json['vaccination'];
    pMaintaince = json['pMaintaince'];
    pbTeam = json['pbTeam'];
    tTerminal = json['tTerminal'];

    email = json['email'];
    phone = json['phone'];
    rer = json['rer'];
    metro = json['metro'];
    bus = json['bus'];
    tram = json['tram'];
    station = json['station'];
    address = json['address'];
    pharName = json['pharName'];
    userName = json['userName'];
    des = json['des'];
    id = json['id'];
    pharmacistsCount = json['pharmacistsCount'];
    preparersCount = json['preparersCount'];
    nonStop = json['nonStop'];

    ///type
    typocc = json['typocc'];
    typocv = json['typocv'];
    typoAero = json['typoAero'];
    typoGare = json['typoGare'];
    typoQuartier = json['typoQuartier'];
    typoTour = json['typoTour'];
    typoRula = json['typoRula'];
    noPatientPerDay = json['noPatientPerDay'];
  }
}
