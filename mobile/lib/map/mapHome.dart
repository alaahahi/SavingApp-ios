import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class mapHome extends StatefulWidget {
  @override
  _mapHomeState createState() => _mapHomeState();
}

class _mapHomeState extends State<mapHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(37.42796133580664, -122.085749655962),
            zoom: 19),),

    );
  }
}
