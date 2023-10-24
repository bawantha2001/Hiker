import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  static const LatLng _pGooglePlex = LatLng(37.4223, -122.0848);

  // static const CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14.4746,
  // );

  // static const CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(7.8731, 80.7718),
          zoom: 20,
        ),
        markers: {
          const Marker(
            markerId: MarkerId("Temple Of the Tooth"),
            position: LatLng(7.293627, 80.641350),
            icon: BitmapDescriptor.defaultMarker,
          ),
          const Marker(
            markerId: MarkerId("Sigiriya"),
            position: LatLng(7.956944, 80.759720),
            icon: BitmapDescriptor.defaultMarker,
          ),
          const Marker(
            markerId: MarkerId("Watadageya"),
            position: LatLng(8.1561, 80.9962),
            icon: BitmapDescriptor.defaultMarker,
          )
        },
      ),
    );
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}
