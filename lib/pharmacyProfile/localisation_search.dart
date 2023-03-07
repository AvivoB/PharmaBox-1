import 'package:flutter/material.dart';
import 'package:pharmabox/pharmacyProfile/textfield.dart';
import 'package:google_maps_webservice/places.dart';

class LocalisationSearch extends StatefulWidget {
  final TextEditingController localisationController;
  const LocalisationSearch({Key? key, required this.localisationController})
      : super(key: key);

  @override
  State<LocalisationSearch> createState() => _LocalisationSearchState();
}

class _LocalisationSearchState extends State<LocalisationSearch> {
  final places =
      GoogleMapsPlaces(apiKey: 'AIzaSyA_cdEvBvs-uWSOpXmBC7SzdVnTTmOZJns');
  PlacesAutocompleteResponse? response;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomPharmacyTextField(
          label: 'Localisation',
          readOnly: false,
          onSaved: (val) {
            response = null;
            setState(() {});
          },
          prefixIcon: Icon(Icons.location_on),
          onRealChanged: (val) async {
            response = await places.autocomplete(val);
            setState(() {});
          },
          controller: widget.localisationController,
        ),
        response != null
            ? Container(
                height: 200,
                padding: const EdgeInsets.all(10),
                margin: EdgeInsets.only(
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
                      onTap: () {
                        widget.localisationController.text =
                            prediction.description!;
                        response = null;
                        setState(() {});
                      },
                    );
                  },
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
