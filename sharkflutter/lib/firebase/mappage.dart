import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

//todo: map drive https://pub.dev/packages/location#-example-tab-

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.4219983, -122.084),
    zoom: 14.4746,
  );

  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  LocationData _location;

  String _error;



  @override
  initState()  {

   /*   _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
      return;
      }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.DENIED) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.GRANTED) {
      return;
      }

      _locationData = await location.getLocation();
      location.onLocationChanged().listen((LocationData currentLocation) {
        // Use current location
        //_kLake. =  LatLng(43.263781,79.979689);
      });
    }
*/
  // ll();

  }

  void ll() async
  {
    location.onLocationChanged().handleError((err) {
      setState(() {
        _error = err.code;
      });
    }).listen((LocationData currentLocation) {
      setState(() {
        _error = null;

        _location = currentLocation;
        _kLake = CameraPosition(
           // bearing: 192.8334901395799,
            target: LatLng(_location.latitude,_location.longitude),
            //tilt: 59.440717697143555,
            zoom: 12);
      });
    });
  }

  static  CameraPosition _kLake = CameraPosition(
     // bearing: 192.8334901395799,
      target: LatLng(43.263781,79.979689),
      tilt: 59.440717697143555,
      zoom: 12);

  @override
  Widget build(BuildContext context) {
    ll();
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kLake,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;

    await ll();

    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}