import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places/flutter_google_places.dart' as fp;
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart'
    as place;
import 'package:pharmabox/bloc/pharmacierecherche_bloc.dart' as phar;
import 'package:pharmabox/mainpages/explorer.dart';
import 'package:pharmabox/pharmaJob/non_titu/non_titu_bottomsheet.dart';

import '../bloc/mainmap_bloc.dart';
import '../bloc/membres_bloc.dart' as mem;
import '../bloc/navigation_bloc.dart';
import '../bloc/offres_bloc.dart' as off;
import '../pharmaJob/bottomsheet.dart';
import '../pharmacyProfile/textfield.dart';
import '../utils/map_utils.dart';

class MainMap extends StatefulWidget {
  final TextEditingController localisationController;
  maps.GoogleMapController? mapController;
  Function(place.LatLng) animateController;
  MainMap(
      {Key? key,
      required this.localisationController,
      required this.animateController,
      required this.mapController})
      : super(key: key);

  @override
  State<MainMap> createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> {
  late Function(String) onSubmitted;

  void explorerSubmit(String address) {
    BlocProvider.of<MainmapBloc>(context)
        .add(GetLibreResults(address: address));
  }

  void nonTituSubmit(String address) {
    BlocProvider.of<MainmapBloc>(context).add(GetLibreOffres(address: address));
  }

  void tituSubmit(String address) {
    BlocProvider.of<MainmapBloc>(context)
        .add(GetLibreMembres(address: address));
  }

  void navigationInit(String address) {
    print("dkhelt");

    BlocProvider.of<MainmapBloc>(context).add(GetMarkersOnAddress(
      address: address,
    ));
  }

  @override
  void initState() {
    super.initState();
    onSubmitted = explorerSubmit;
  }

  final places =
      GoogleMapsPlaces(apiKey: 'AIzaSyA_cdEvBvs-uWSOpXmBC7SzdVnTTmOZJns');
  PlacesAutocompleteResponse? response;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return BlocConsumer<NavigationBloc, NavigationState>(
      listener: (context, state) {
        if (state is PharmaJobTituState) {
          onSubmitted = tituSubmit;
        } else if (state is PharmaJobNonTituState) {
          onSubmitted = nonTituSubmit;
        } else {
          onSubmitted = explorerSubmit;
        }
      },
      builder: (context, state) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Container(
              height: height * 0.1,
              color: Colors.transparent,
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromRGBO(208, 209, 222, 1),
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        width: width * 0.9,
                        child: Row(
                          children: [
                            SizedBox(
                              width: width * 0.8,
                              child: TextField(
                                readOnly: false,
                                onChanged: (val) async {
                                  response = await places
                                      .autocomplete(val, types: ["(regions)"]);
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  hintText: state is NavigationInitial
                                      ? 'Recherche par région, nom ou pharmacie'
                                      : "Rechercher",
                                  border: InputBorder.none,
                                  icon: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.search,
                                      size: 25,
                                      color: Color.fromRGBO(208, 209, 222, 1),
                                    ),
                                  ),
                                ),
                                onSubmitted: (val) async {
                                  LatLng? local =
                                      await MapUtils.getLocationFromAddress(
                                          val);
                                  print(local);
                                  if (local != null) {
                                    widget.animateController(local);
                                    navigationInit(val);
                                  } else {
                                    onSubmitted(val);
                                  }
                                  response = null;
                                },
                                controller: widget.localisationController,
                              ),
                            ),
                            BlocBuilder<NavigationBloc, NavigationState>(
                              builder: (context, state) {
                                if (state is ExplorerState ||
                                    state is NavigationInitial) {
                                  return const SizedBox();
                                }
                                if (state is PharmaJobNonTituState) {
                                  return GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(25.0),
                                          ),
                                        ),
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (context) =>
                                            const NonTituSheet(),
                                      );
                                    },
                                    child: Image(
                                      height: height * 0.04,
                                      image: const AssetImage(
                                        'assets/icons/filter.png',
                                      ),
                                    ),
                                  );
                                } else {
                                  return GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(25.0),
                                          ),
                                        ),
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (context) =>
                                            const FiltersBottomSheet(),
                                      );
                                    },
                                    child: Image(
                                      height: height * 0.04,
                                      image: const AssetImage(
                                        'assets/icons/filter.png',
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            BlocBuilder<NavigationBloc, NavigationState>(
              builder: (context, state) {
                if (state is NavigationInitial) {
                  return response != null && response!.predictions.isNotEmpty
                      ? Container(
                          height: 200,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(
                            top: 10,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: const Border(
                                  bottom:
                                      BorderSide(color: Colors.grey, width: 1),
                                  left:
                                      BorderSide(color: Colors.grey, width: 1),
                                  top: BorderSide(color: Colors.grey, width: 1),
                                  right: BorderSide(
                                      color: Colors.grey, width: 1))),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: response != null
                                ? response!.predictions.length
                                : 0,
                            itemBuilder: (context, index) {
                              final prediction = response != null
                                  ? response!.predictions[index]
                                  : Prediction(description: "hi");
                              return ListTile(
                                leading: Icon(
                                  Icons.location_on,
                                  color: Theme.of(context).primaryColor,
                                ),
                                title: Text(
                                    prediction.structuredFormatting!.mainText),
                                onTap: () {
                                  widget.localisationController.text =
                                      prediction.structuredFormatting!.mainText;
                                  response = null;
                                  setState(() {});
                                },
                              );
                            },
                          ))
                      : const SizedBox();
                } else {
                  return const SizedBox();
                }
              },
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }
}
