import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:pharmabox/base/base_controller.dart';
import 'package:pharmabox/local/my_hive.dart';
import 'package:pharmabox/model/user_model.dart';
import '../model/job_model.dart';
import '../model/pharmacy_model.dart';

class PharmacyController extends BaseController {
  void getAndSaveUser() async {
    var userID = FirebaseAuth.instance.currentUser?.uid;

    if (userID == null) {
      showSnackBar('alert', 'please_login_first'.tr);
      return;
    }

    showLoader();

    DatabaseReference reference =
        FirebaseDatabase.instance.reference().child('users').child(userID);

    var snapshot = await reference.get();
    hideLoader();

    if (snapshot.exists) {
      Map<dynamic, dynamic> userMap = snapshot.value as Map<dynamic, dynamic>;
      var userModel = UserModel.fromJson(userMap);
      MyHive.saveUser(userModel);
    } else {
      showSnackBar('alert', 'User not found in DB');
    }
  }

  void createOrUpdatePharmacy(PharmacyModel model, String? updateId) async {
    var userID = FirebaseAuth.instance.currentUser?.uid;

    if (userID == null) {
      showSnackBar('alert', 'please_login_first'.tr);
      return;
    }

    showLoader();

    DatabaseReference reference =
        FirebaseDatabase.instance.reference().child('pharmacy').child(userID);

    String pharmaKey = '';

    if (updateId == null) {
      pharmaKey = reference.push().key ??
          DateTime.now().millisecondsSinceEpoch.toString();
    } else {
      pharmaKey = updateId;
    }

    model.id = pharmaKey;

    Map<String, dynamic> pharmacy = model.toMap();
    await reference.child(pharmaKey).set(pharmacy);

    hideLoader();

    if (updateId == null) {
      showSnackBar('alert', 'pharmacy_registered_successfully'.tr);
    } else {
      showSnackBar('alert', 'pharmacy_updated_successfully'.tr);
    }
  }

  void addJob(JobModel job) async {
    var userID = FirebaseAuth.instance.currentUser?.uid;

    if (userID == null) {
      showSnackBar('alert', 'please_login_first'.tr);
      return;
    }

    showLoader();

    DatabaseReference reference =
    FirebaseDatabase.instance.reference().child('users').child('jobs').child(userID);

    String pharmaKey = reference.push().key ??
        DateTime.now().millisecondsSinceEpoch.toString();

    Map<String, dynamic> pharmacy = job.toMap();
    await reference.child(pharmaKey).set(pharmacy);

    hideLoader();

    showSnackBar('alert', 'Job added successfully');
  }

  void getMyPharmacy(Function(PharmacyModel?) pharmacy) async {
    var userID = FirebaseAuth.instance.currentUser?.uid;

    if (userID == null) {
      showSnackBar('alert', 'please_login_first'.tr);
      return;
    }

    showLoader();

    DatabaseReference reference =
        FirebaseDatabase.instance.reference().child('pharmacy').child(userID);

    var snapshot = await reference.get();
    hideLoader();

    if (snapshot.exists) {
      var pharList = <PharmacyModel>[];

      Map<dynamic, dynamic> userMap = snapshot.value as Map<dynamic, dynamic>;

      for (var entry in userMap.entries) {
        Map<dynamic, dynamic> pharMap = entry.value;
        PharmacyModel pharmacyModel = PharmacyModel.fromJson(pharMap);
        pharList.add(pharmacyModel);
      }

      if (pharList.isNotEmpty) {
        pharmacy.call(pharList.first);
      } else {
        pharmacy.call(null);
      }
    }

    ///not exist
    else {
      pharmacy.call(null);
    }
  }
}
