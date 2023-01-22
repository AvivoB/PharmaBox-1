
import 'package:hive/hive.dart';

import '../model/user_model.dart';

class MyHive {
  static late Box _ins;
  static const String _userData = 'userData';


  Box get ins => _ins;

  static init() async {
       Hive
        ..registerAdapter(UserModelAdapter());
    _ins = await Hive.openBox('APP');
  }


  //Save User data
  static saveUser(UserModel? user) {
    _ins.put(_userData, user);
  }

//Get user
  static UserModel? getUser() {
    return _ins.get(_userData, defaultValue: null);
  }

  static logout(){
    saveUser(null);
  }
}
