import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:reminder/model/app_constants.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'
    hide LatLng, Marker, Location;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:reminder/controller/PlacesResponse.dart';

import 'NavBar.dart';

class LocationViewer extends StatefulWidget {
  LocationViewer({Key? key}) : super(key: key);

  @override
  _LocationViewerState createState() {
    return _LocationViewerState();
  }
}

class _LocationViewerState extends State<LocationViewer> {
  @override
  late MapController mapController;
  var _positionMessage = '';
  var _descriptionMessage = '';
  LatLng origin = LatLng(43.9373, -78.89);
  List<LatLng> pharmas = [];
  double currentZoom = 15;

  void initState() {
    super.initState();
    mapController = MapController();

    Geolocator.isLocationServiceEnabled().then((value) => null);
    Geolocator.requestPermission().then((value) => null);
    Geolocator.checkPermission().then((LocationPermission permission) {
      print("Check Location Permission: $permission");
    });

    Geolocator.getPositionStream(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.best),
    ).listen(_updateLocationStream);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    int count = 0;

    return Scaffold(
        appBar: navBar(
            context, "View Pharmacies", "Medications list pulled from Firebase."),
        body: Stack(children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
                minZoom: 12, maxZoom: 18, zoom: currentZoom, center: origin),
            layers: [
              TileLayerOptions(
                urlTemplate: AppConstants.mapBoxStyleID,
              ),
              MarkerLayerOptions(
                markers: [
                  for (int i = 0; i < pharmas.length; i++)
                    Marker(
                        height: 80,
                        width: 80,
                        point: pharmas[i],
                        builder: (context) {
                          return Container(
                            child: IconButton(
                              onPressed: () {
                                setState(() {});
                              },
                              icon: Icon(Icons.location_on, color: Colors.red),
                              iconSize: 45,
                            ),
                          );
                        }),
                  Marker(
                      height: 80,
                      width: 80,
                      point: origin,
                      builder: (context) {
                        return Container(
                            child: IconButton(
                                onPressed: () {
                                  final snack = SnackBar(
                                      content: Text(_descriptionMessage.length
                                          .toString()),
                                      action: SnackBarAction(
                                        label: 'Close',
                                        onPressed: () {},
                                      ));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snack);
                                  setState(() {});
                                },
                                icon: Icon(Icons.circle, color: Colors.blue),
                                iconSize: 20));
                      })
                ],
              ),
            ],
          ),
        ]));
  }

  _updateLocationStream(Position userLocation) async {
    _positionMessage = userLocation.latitude.toString() +
        ',' +
        userLocation.longitude.toString();
    origin = LatLng(userLocation.latitude, userLocation.longitude);
    mapController.move(
        LatLng(userLocation.latitude, userLocation.longitude), currentZoom);
    _getPharma();
    final List<Placemark> places = await placemarkFromCoordinates(
        userLocation.latitude, userLocation.longitude);
    setState(() {
      _descriptionMessage = '${[places[0]]}';
    });
  }

  _getPharma() async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' +
            origin.latitude.toString() +
            ',' +
            origin.longitude.toString() +
            '&radius=' +
            pow((currentZoom * 10), 2).toString() +
            '&type=pharmacy&key=' +
            AppConstants.googleToken);
    print(url);
    var response = await http.post(url);

    PlacesResponse placeResponse =
        PlacesResponse.fromJson(jsonDecode(response.body));

    for (int i = 0; i < placeResponse.results!.length; i++) {
      if (placeResponse.results![i].types!.contains("pharmacy") == true) {
        pharmas.add(LatLng(placeResponse.results![i].geometry!.location!.lat!,
            placeResponse!.results![i].geometry!.location!.lng!));
      }
    }
    setState(() {});
  }

  void _zoomOut() {
    if (currentZoom > 12) {
      currentZoom -= 1;
      mapController.move(origin, currentZoom);
      _getPharma();
    }
  }

  void _zoomIn() {
    if (currentZoom < 18) {
      currentZoom += 1;
      mapController.move(origin, currentZoom);
      _getPharma();
    }
  }
}
