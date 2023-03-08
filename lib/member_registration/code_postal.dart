import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places/flutter_google_places.dart' as fp;
import 'package:google_maps_webservice/places.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart'
    as place;

import '../general/widgets/custom_registration_textfield.dart';
import '../pharmacyProfile/textfield.dart';
import '../utils/map_utils.dart';

class CodePostalWidget extends StatefulWidget {
  final TextEditingController localisationController;
  final TextEditingController villeController;
  CodePostalWidget({
    Key? key,
    required this.localisationController,
    required this.villeController,
  }) : super(key: key);

  @override
  State<CodePostalWidget> createState() => _CodePostalWidgetState();
}

class _CodePostalWidgetState extends State<CodePostalWidget> {
  final places =
      GoogleMapsPlaces(apiKey: 'AIzaSyA_cdEvBvs-uWSOpXmBC7SzdVnTTmOZJns');
  PlacesAutocompleteResponse? response;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          CustomPharmacyTextField(
            label: 'Code postal',
            onRealChanged: (val) async {
              response = await places.autocomplete(
                val,
                types: ['postal_code'],
              );
              setState(() {});
            },
            prefixIcon: const Icon(
              Icons.location_on_outlined,
            ),
            textInputType: TextInputType.number,
            controller: widget.localisationController,
          ),
          response != null
              ? Container(
                  height: 200,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(
                    top: 10,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: const Border(
                          bottom: BorderSide(color: Colors.grey, width: 1),
                          left: BorderSide(color: Colors.grey, width: 1),
                          top: BorderSide(color: Colors.grey, width: 1),
                          right: BorderSide(color: Colors.grey, width: 1))),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        response != null ? response!.predictions.length : 0,
                    itemBuilder: (context, index) {
                      final prediction = response != null
                          ? response!.predictions[index]
                          : Prediction(description: "hi");
                      return ListTile(
                        leading: Icon(
                          Icons.location_on,
                          color: Theme.of(context).primaryColor,
                        ),
                        title: Text(prediction.description!),
                        onTap: () async {
                          widget.localisationController.text =
                              prediction.structuredFormatting!.mainText;
                          PlacesDetailsResponse? villeResponse = await places
                              .getDetailsByPlaceId(prediction.placeId!);

                          for (final component
                              in villeResponse.result.addressComponents) {
                            if (component.types.contains('locality')) {
                              widget.villeController.text = component.longName;
                            }
                          }
                          villeResponse = null;
                          response = null;
                          setState(() {});
                        },
                      );
                    },
                  ),
                )
              : const SizedBox(),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}
