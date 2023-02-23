import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late TextEditingController _searchController;
  GoogleMapsPlaces _places =
      GoogleMapsPlaces(apiKey: 'AIzaSyD2iAVuME8f_hACkixmDwAWb-VSxz1lCwU');

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  void _onSearchTextChanged(String value) async{
    // Use the flutter_google_places package to get autocomplete suggestions
    // for the search term and update the search controller's text with the
    // selected suggestion
  await  PlacesAutocomplete.show(
      context: context,
      apiKey: 'AIzaSyD2iAVuME8f_hACkixmDwAWb-VSxz1lCwU',
      language: 'en',
      mode: Mode.overlay,
      components: [Component(Component.country, "us")],
      //types: ['(cities)'],
      hint: 'Search',
      startText: value,
     
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search...',
          ),
          
          onChanged: _onSearchTextChanged,
        ),
      ),
    );
  }
}
