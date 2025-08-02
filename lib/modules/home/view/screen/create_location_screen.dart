import 'package:souq_al_balad/global/components/app_loader.dart';
import 'package:souq_al_balad/global/components/button_app.dart';
import 'package:souq_al_balad/global/components/show_toast_app.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocode/geocode.dart' as locator;

class CreateLocationScreen extends StatefulWidget {
  const CreateLocationScreen({super.key});

  @override
  State<CreateLocationScreen> createState() => _CreateLocationScreenState();
}

class _CreateLocationScreenState extends State<CreateLocationScreen> {
  GoogleMapController? _mapController;
  LatLng? _selectedLocation;
  String locationTitle = "";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.always &&
          permission != LocationPermission.whileInUse) {
        return;
      }
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _selectedLocation = LatLng(position.latitude, position.longitude);
    });

    // Optional: move camera to current location
    _mapController?.animateCamera(CameraUpdate.newLatLng(_selectedLocation!));
  }

  Future<String> getLocationTitle(double? lat, double? lang) async {
    try {
      isLoading = true;
      setState(() {});

      if (lat == null || lang == null) return "";

      locator.GeoCode geoCode = locator.GeoCode();
      locator.Address address = await geoCode.reverseGeocoding(
        latitude: lat,
        longitude: lang,
      );

      final combined = "${address.streetAddress}, ${address.region}";

      if (combined.contains("Throttled!") || combined.trim().isEmpty) {
        locationTitle = "";
        if (mounted) {
          showToastApp(
            text: AppLocalization.of(context).translate("location_not_found"),
          );
        }
      } else {
        locationTitle = combined;
      }
    } catch (e) {
      print('Error: $e');
      if (mounted) {
        showToastApp(
          text: AppLocalization.of(context).translate("location_not_found"),
        );
      }
    } finally {
      isLoading = false;
      setState(() {});
    }

    return locationTitle;
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedLocation == null) {
      return Scaffold(body: Center(child: AppLoader(size: 30.w)));
    }
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
            onMapCreated: (controller) => _mapController = controller,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                _selectedLocation!.latitude,
                _selectedLocation!.longitude,
              ),
              zoom: 15,
            ),
            onTap: (position) {
              setState(() {
                _selectedLocation = position;
              });
            },
            markers: {
              Marker(
                markerId: const MarkerId("selected"),
                position: _selectedLocation!,
                infoWindow: const InfoWindow(),
              ),
            },
          ),
          if (_selectedLocation != null)
            Positioned(
              bottom: 30.h,
              left: 20.w,
              right: 20.w,
              child:
                  !isLoading
                      ? CustomButton(
                        text: AppLocalization.of(
                          context,
                        ).translate("pick_location"),
                        onPressed: () {
                          getLocationTitle(
                            _selectedLocation!.latitude,
                            _selectedLocation!.longitude,
                          ).then((value) {
                            if (locationTitle != "") {
                              // todo pass the locationTitle to previous page
                            }
                          });
                        },
                      )
                      : const Center(child: AppLoader(size: 30)),
            ),
        ],
      ),
    );
  }
}
