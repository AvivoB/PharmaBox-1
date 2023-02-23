import 'package:flutter/material.dart';


class WorkHours {
   TimeOfDay startDate;
   TimeOfDay endDate;
  WorkHours({required this.startDate, required this.endDate});
 

  static List<WorkHours> fromJson(List<dynamic> json) {
    if (json.isEmpty) {
      return [];
    } else {
      return json.map((e) {
        List<String> splitString = e['startDate'].split(':');
        List<String> secondSplit = e['endDate'].split(':');
        return WorkHours(
            startDate: TimeOfDay(hour:int.parse(splitString[0]),minute: int.parse(splitString[1])), 
            endDate: TimeOfDay(hour:int.parse(secondSplit[0]),minute: int.parse(secondSplit[1])), );
      }).toList();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "startDate": "${startDate.hour}:${startDate.minute}",
      "endDate": "${endDate.hour}:${endDate.minute}",
    };
  }
}
