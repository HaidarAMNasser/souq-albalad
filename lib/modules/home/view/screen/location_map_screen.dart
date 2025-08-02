import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMapScreen extends StatefulWidget {
  final double latitude;
  final double longitude;

  const LocationMapScreen({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<LocationMapScreen> createState() => _LocationMapScreenState();
}

class _LocationMapScreenState extends State<LocationMapScreen> {
  LatLng? location;

  @override
  void initState() {
    super.initState();
    location = LatLng(widget.latitude, widget.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 70),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: location!, zoom: 15),
        markers: {
          Marker(
            markerId: const MarkerId('selectedLocation'),
            position: location!,
          ),
        },
      ),
    );
  }
}
