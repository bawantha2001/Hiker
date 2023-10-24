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
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(6.9271, 79.8612),
          zoom: 10,
        ),
        markers: {
          const Marker(
            markerId: MarkerId("Temple Of the Tooth"),
            position: LatLng(7.293627, 80.641350),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(
              title: 'Temple Of the Tooth',
              snippet: 'Central Province'
            ),
          ),
          const Marker(
            markerId: MarkerId("Sigiriya"),
            position: LatLng(7.956944, 80.759720),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(
              title: 'Sigiriya',
              snippet: 'Central Province'
            ),
          ),
          const Marker(
            markerId: MarkerId("Watadageya"),
            position: LatLng(8.1561, 80.9962),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(
              title: 'Watadageya',
              snippet: 'North Central',
            ),
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
class  extends StatelessWidget {
  const ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

