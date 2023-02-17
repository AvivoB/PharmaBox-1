import 'dart:async';
import 'dart:math';

import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:pharmabox/Widgets/color_constants.dart';
import 'package:pharmabox/constants.dart';
import 'package:sizer/sizer.dart';

import '../Widgets/space_values.dart';

const kGoogleApiKey = 'AIzaSyA_cdEvBvs-uWSOpXmBC7SzdVnTTmOZJns';

class AutoCompleteSearch extends StatelessWidget {
  var searchedItem = <AutocompletePrediction>[].obs;

  final places = FlutterGooglePlacesSdk(kGoogleApiKey);

  final List<PlaceField> _placeFields = [
    PlaceField.Location,
    PlaceField.Name,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spaces.y2,
            Center(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(208, 209, 222, 1),
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                width: 85.w,
                child: TextFormField(
                  onChanged: (val) async {
                    final predictions =
                        await places.findAutocompletePredictions(val);
                    print('Result: $predictions');
                    searchedItem.clear();
                    searchedItem.addAll(predictions.predictions);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Search here',
                    border: InputBorder.none,
                    icon: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.search,
                        size: 25,
                        color: Color.fromRGBO(208, 209, 222, 1),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Spaces.y2,
            Expanded(child: Obx(() {
              return ListView.builder(
                  itemCount: searchedItem.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        var res = await places
                            .fetchPlace(searchedItem[index].placeId,fields: _placeFields);
                        Get.back(result: res.place);
                      },
                      child: Container(
                        decoration:
                            BoxDecoration(color: ColorConstants.grayLevel15),
                        margin: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 0.5.h),
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 0.5.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(searchedItem[index].primaryText),
                            Text(
                              searchedItem[index].secondaryText,
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 10.sp),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }))
          ],
        ),
      ),
    );
  }
}
