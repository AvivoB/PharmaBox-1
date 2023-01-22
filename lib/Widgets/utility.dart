
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import 'color_constants.dart';



class Utility {
  static String getTimeAsAmPm(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }


  ///this method will remove special char from any string
  ///Mainly we are using this method to remove special char from email
  ///We are using email as user unique id in firebase for chat
  static String removeSpecialCharacters(String input)
  {
    var output = "";
    String regex = r'[^\p{Alphabetic}\p{Mark}\p{Decimal_Number}\p{Connector_Punctuation}\p{Join_Control}\s]+';
    output = input.replaceAll(RegExp(regex, unicode: true),'_');
    return output;
  }

  static String convertMilliSecondsToDateFormat(double timeInMilli, {String dateFormat = "hh:mm a"}){

    var format = DateFormat(dateFormat);
    var date = DateTime.fromMillisecondsSinceEpoch(timeInMilli.toInt());
    return format.format(date);
  }
  static void showSnack(String title, String msg,
      {bool isError = false, SnackbarStatusCallback? statusCallback}) {
    Get.snackbar(title, msg,
        backgroundColor: isError
            ? ColorConstants.redButtonBackground
            : ColorConstants.appBlue,
        colorText: ColorConstants.whiteColor,
        snackbarStatus: statusCallback,
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Visibility(
          visible: false,
          child: Text(
            '',
          ),
        ),
        messageText: Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h),
          child: Text(
            msg,
            style: TextStyle(fontSize: 12.sp,color: Colors.white),
          ),
        ));
  }

  static bool isValidEmail(String email) {
    bool isValid = false;
    if (email.isNotEmpty) {
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);
      if (emailValid) {
        isValid = true;
      }
    }
    return isValid;
  }

  static String getDayFromDate(DateTime date,{bool localFromUtc = false}) {
    if (localFromUtc){
      date = date.toLocal();
    }
    return DateFormat('E').format(date);
  }

  ///This method will return a month, year, day or hour, weekday etc
  ///sent format code in 'item'
  static String getSingleItemFromDate(DateTime date, {String item = 'MMMM'}) {
    return DateFormat(item).format(date);
  }

  static DateTime parseStringDate(String dateString,
      {String format = 'yyyy-M-d',bool localFromUTC = false}) {
    if(dateString.contains('am') || dateString.contains('pm')){
      dateString = dateString.replaceFirst(' pm', ' PM').replaceFirst(' am', ' AM');
    }
    if (dateString.isEmpty) return DateTime.now();
    var date = DateFormat(format).parse(dateString,localFromUTC);
     date = date.toLocal();
  //   date = DateFormat(format).parse(DateFormat(format).format(date),localFromUTC);
    return date;
  }

  //Creating separate function only for weekly date parsing because after applying timezone utc conversion, our DateTime object changes obj.hour to 24 hours,
  static DateTime parseStringDateWeekly(String dateString,
      {String format = 'yyyy-M-d',bool localFromUTC = false}) {
    if(dateString.contains('am') || dateString.contains('pm')){
      dateString = dateString.replaceFirst(' pm', ' PM').replaceFirst(' am', ' AM');
    }
    if (dateString.isEmpty) return DateTime.now();
    var date = DateFormat(format).parse(dateString,localFromUTC);
    date = date.toLocal();
    date = DateFormat(format).parse(DateFormat(format).format(date),localFromUTC);
    return date;
  }

  static String calculateAge(String dateOfBirth){
    if (dateOfBirth.isEmpty) return "";
    String datePattern = "yyyy-MM-dd";

    DateTime birthDate = DateFormat(datePattern).parse(dateOfBirth);
    DateTime today = DateTime.now();

    int yearDiff = today.year - birthDate.year;
   // int monthDiff = today.month - birthDate.month;
   // int dayDiff = today.day - birthDate.day;

    return yearDiff.toString();
  }

  static String getAmPmTimeFromDateTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  static DateTime getFirstDayOfCurrentMonth() {
    var currentDate = DateTime.now();
    return DateTime(currentDate.year, currentDate.month, 01);
  }

  static String getAmPmTimeFromDateString(String dateString,
      {String format = 'yyyy-M-d', bool localFromUtc = true}) {
    if(dateString.isEmpty) {
      return '';
    }
    var parsedDateString = '';
    try{
      var date = DateFormat(format).parse(dateString,localFromUtc);
      if (localFromUtc){
        date = date.toLocal();
      }
      parsedDateString =  DateFormat('hh:mm a').format(date);
    } catch(ex) {
      parsedDateString = '';
    }

    return parsedDateString;
  }

  static DateTime getLocalDateTimeFromUTCString(String dateString,
      {String format = 'yyyy-M-d'}) {
    if(dateString.isEmpty) {
      return DateTime.now();
    }
    var date = DateFormat(format).parse(dateString);
    return date.toLocal();
  }

  static DateTime getDateTimeFromString(String dateString,
      {String format = 'yyyy-M-d'}) {
    if(dateString.isEmpty) {
      return DateTime.now();
    }
    var date = DateFormat(format).parse(dateString);
    return date;
  }

  static String getUTCDateTimeStringFromLocalDateString(String dateString,
      {String fromFormat = 'yyyy-M-d',String toFormat = 'yyyy-M-d'}) {
    if(dateString.isEmpty) {
      return "";
    }

    var date = DateFormat(fromFormat).parse(dateString).toUtc();
    var toFormate = DateFormat(toFormat).format(date);
    return toFormate;
  }

  static String getDateTimeStringFromString(String dateString,
      {String fromFormat = 'yyyy-M-d',String toFormat = 'yyyy-M-d'}) {
    if(dateString.isEmpty) {
      return "";
    }

    var date = DateFormat(fromFormat).parse(dateString);
    var toFormate = DateFormat(toFormat).format(date);
    return toFormate;
  }

  static String getDateInFormat(DateTime dateTime,
      {String format = 'd/M/yyyy'}) {

    return DateFormat(format).format(dateTime);
  }

  static String getTimeAndDateAsString(DateTime dateTime) {
    var time = getTimeAsAmPm(dateTime);
    final now = DateTime.now();
    if (dateTime.day == now.day &&
        dateTime.month == now.month &&
        dateTime.year == now.year) {
      return "$time\nToday";
    }
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    if (dateTime.day == yesterday.day &&
        dateTime.month == yesterday.month &&
        dateTime.year == yesterday.year) {
      return "$time\nYesterday";
    }
    var otherDate = getDateInFormat(dateTime, format: 'MM/dd/yyyy');
    return "$time\n$otherDate";
  }

  static bool parseBool(dynamic value) {
    switch (value) {
      case true:
        return true;
      case false:
        return false;
      case 'true':
        return true;
      case 'false':
        return false;
      default:
        return false;
    }
  }


  static String? getNameFromFirebaseId(String from) {
    if(from.isEmpty)
      return null;
    return from.split("_")[0];
  }


 static bool timeDiff15Min(String startTime) {
    var startDateTime = Utility.parseStringDate(startTime.toUpperCase(),
        format: 'yyyy-MM-dd hh:mm a',localFromUTC: true);
    var currentTime = DateTime.now();

    var diff = currentTime.difference(startDateTime).inMinutes;
    print("TIME :: ${startTime}    DIFFERENCE :: ${diff}");
    if (diff >= -15 && diff <= 0) {
      return true;
    } else {
      return false;
    }
  }

}
