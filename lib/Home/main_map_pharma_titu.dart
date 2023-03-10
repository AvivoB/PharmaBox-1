import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places/flutter_google_places.dart' as fp;
import 'package:google_maps_webservice/places.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart'
    as place;

import '../bloc/mainmap_bloc.dart';
import '../bloc/navigation_bloc.dart';
import '../pharmacyProfile/textfield.dart';
import '../utils/map_utils.dart';

class MainMapPharmaTitu extends StatefulWidget {
  final TextEditingController localisationController;
  maps.GoogleMapController? mapController;
  MainMapPharmaTitu(
      {Key? key,
      required this.localisationController,
      required this.mapController})
      : super(key: key);

  @override
  State<MainMapPharmaTitu> createState() => _MainMapPharmaTituState();
}

class _MainMapPharmaTituState extends State<MainMapPharmaTitu> {
  final places =
      GoogleMapsPlaces(apiKey: 'AIzaSyA_cdEvBvs-uWSOpXmBC7SzdVnTTmOZJns');
  PlacesAutocompleteResponse? response;
 

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationBloc, NavigationState>(
      listener: (context, state) {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            TextField(
              readOnly: false,
              onChanged: (val) async {
                response = await places.autocomplete(val);
                setState(() {});
              },
              decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
              onSubmitted: (val) async {
                
                var local = await MapUtils.getLocationFromAddress(
                    widget.localisationController.text);
                widget.mapController!.animateCamera(
                    maps.CameraUpdate.newLatLngZoom(
                        maps.LatLng(local.lat, local.lng), 12));
              },
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
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }
}
