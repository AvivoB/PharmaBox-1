import 'package:get/get_connect/connect.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'package:sizer/sizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

import '../Widgets/color_constants.dart';
import '../Widgets/utility.dart';


class BaseController extends GetxController {
  void showLoader() {
    Get.defaultDialog(
        title: 'Please wait...',
        barrierDismissible: false,
        backgroundColor: ColorConstants.appBlue,
        titleStyle: const TextStyle(color: Colors.white),
        //content: const CircularProgressIndicator.adaptive(backgroundColor: Colors.black,));
        content: const CupertinoActivityIndicator());
  }

  void hideLoader() {
    Get.back();
  }

  showSnackBar(String title, String message) {
    Utility.showSnack(title, message);
  }
}
