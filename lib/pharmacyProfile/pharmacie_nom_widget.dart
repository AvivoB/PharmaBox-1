import 'package:flutter/material.dart';
import 'package:pharmabox/pharmacyProfile/textfield.dart';
import 'package:google_maps_webservice/places.dart';

class PharmacieNom extends StatefulWidget {
  final TextEditingController pharmacyName;
  const PharmacieNom({Key? key, required this.pharmacyName}) : super(key: key);

  @override
  State<PharmacieNom> createState() => _PharmacieNomState();
}

class _PharmacieNomState extends State<PharmacieNom> {
  final places =
      GoogleMapsPlaces(apiKey: 'AIzaSyA_cdEvBvs-uWSOpXmBC7SzdVnTTmOZJns');
  PlacesAutocompleteResponse? response;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomPharmacyTextField(
          label: 'Nom pharmacie',
          readOnly: false,
          onSaved: (val) {
            response = null;
            setState(() {});
          },
          prefixIcon: const Icon(Icons.local_hospital),
          onRealChanged: (val) async {
            response = await places.autocomplete(val, types: ['pharmacy']);
            setState(() {});
          },
          controller: widget.pharmacyName,
        ),
        response != null
            ? Container(
                height: 200,
                padding: const EdgeInsets.all(10),
                margin: EdgeInsets.only(
                    top: 10, bottom: MediaQuery.of(context).viewInsets.bottom),
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
                        widget.pharmacyName.text =
                            prediction.structuredFormatting!.mainText;
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
