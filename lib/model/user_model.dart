
import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {

  @HiveField(0)
  String? id;

  @HiveField(1)
  String? fname;

  @HiveField(2)
  String? type;

  @HiveField(3)
  String? email;

  @HiveField(4)
  String? dob;

  @HiveField(5)
  String? phone;

  @HiveField(6)
  String? postalCode;

  @HiveField(7)
  String? ville;

  @HiveField(8)
  String? presentation;

  @HiveField(9)
  String? lname;


  UserModel();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fname': fname,
      'lname': lname,
      'type': type,
      'email': email,
      'dob': dob,
      'phone': phone,
      'postalCode': postalCode,
      'ville': ville,
      'presentation': presentation,
    };
  }

  UserModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    fname = json['fname'];
    lname = json['lname'];
    type = json['type'];
    email = json['email'];
    dob = json['dob'];
    phone = json['phone'];
    postalCode = json['postalCode'];
    ville = json['ville'];
    presentation = json['presentation'];
  }
}
