import 'package:souq_al_balad/global/components/app_loader.dart';
import 'package:souq_al_balad/global/components/button_app.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:souq_al_balad/modules/home/bloc/home_bloc.dart';
import 'package:souq_al_balad/modules/home/bloc/home_events.dart';
import 'package:souq_al_balad/modules/home/bloc/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_place/google_place.dart'; // ADD THIS

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  GoogleMapController? _mapController;
  double _radius = 0.5;
  LatLng? _center;
  CircleId circleId = const CircleId("search_circle");

  final TextEditingController _searchController = TextEditingController();
  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  bool showSuggestions = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    googlePlace = GooglePlace("AIzaSyBv3gGSsXTKeRF7CQsEnfyKpjqhd1BELmM");
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.always &&
          permission != LocationPermission.whileInUse)
        return;
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _center = LatLng(position.latitude, position.longitude);
    });

    if (_mapController != null) {
      _mapController!.animateCamera(CameraUpdate.newLatLngZoom(_center!, 14));
    }
  }

  void autoCompleteSearch(String value) async {
    if (value.isNotEmpty) {
      var result = await googlePlace.autocomplete.get(value);
      if (result != null && result.predictions != null) {
        setState(() {
          predictions = result.predictions!;
          showSuggestions = true;
        });
      }
    } else {
      setState(() {
        predictions = [];
        showSuggestions = false;
      });
    }
  }

  void selectPrediction(AutocompletePrediction p) async {
    if (p.placeId == null) return;

    final details = await googlePlace.details.get(p.placeId!);
    if (details != null &&
        details.result != null &&
        details.result!.geometry != null &&
        details.result!.geometry!.location != null) {
      final lat = details.result!.geometry!.location!.lat!;
      final lng = details.result!.geometry!.location!.lng!;
      setState(() {
        _center = LatLng(lat, lng);
        _searchController.text = p.description!;
        showSuggestions = false;
      });
      _mapController?.animateCamera(CameraUpdate.newLatLngZoom(_center!, 15));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(),
      child:
          _center == null
              ? Scaffold(body: Center(child: AppLoader(size: 30)))
              : Scaffold(
                appBar: AppBar(),
                body: SafeArea(
                  child: Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: _center!,
                          zoom: 15,
                        ),
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        zoomControlsEnabled: false,
                        onMapCreated: (controller) {
                          _mapController = controller;
                          _mapController!.animateCamera(
                            CameraUpdate.newLatLngZoom(_center!, 15),
                          );
                        },
                        onTap: (position) {
                          setState(() {
                            _center = position;
                          });
                        },
                        circles: {
                          Circle(
                            circleId: circleId,
                            center: _center!,
                            radius: _radius * 1000,
                            fillColor: Theme.of(
                              context,
                            ).colorScheme.secondary.withOpacity(0.5),
                            strokeColor:
                                Theme.of(context).colorScheme.secondary,
                            strokeWidth: 1,
                          ),
                        },
                        markers: {
                          Marker(
                            markerId: const MarkerId("center_marker"),
                            position: _center!,
                            infoWindow: const InfoWindow(),
                          ),
                        },
                      ),
                      Positioned(
                        top: 30,
                        left: 25,
                        right: 25,
                        child: Column(
                          children: [
                            Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(10),
                              child: TextField(
                                controller: _searchController,
                                onChanged: autoCompleteSearch,
                                decoration: InputDecoration(
                                  hintText: AppLocalization.of(
                                    context,
                                  ).translate("search"),
                                  hintStyle: Theme.of(
                                    context,
                                  ).textTheme.bodyLarge!.copyWith(
                                    color: AppColors.darkBackground,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: AppColors.darkBackground,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.all(12),
                                ),
                                onSubmitted: (_) {
                                  FocusScope.of(context).unfocus();
                                },
                              ),
                            ),
                            if (showSuggestions &&
                                _searchController.text.isNotEmpty)
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: predictions.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(
                                        predictions[index].description ?? "",
                                      ),
                                      onTap:
                                          () => selectPrediction(
                                            predictions[index],
                                          ),
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 30,
                        left: 25,
                        right: 25,
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLocalization.of(
                                          context,
                                        ).translate("search_area"),
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.titleMedium,
                                      ),
                                      Text(
                                        " ${_radius.toStringAsFixed(1)} ${AppLocalization.of(context).translate("kilo_meter")} 📍 ${AppLocalization.of(context).translate("diameter")} ",
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                  Slider(
                                    value: _radius,
                                    inactiveColor: AppColors.grey300,
                                    min: 0.5,
                                    max: 100.0,
                                    onChanged:
                                        (value) =>
                                            setState(() => _radius = value),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                            BlocBuilder<HomeBloc, HomeState>(
                              builder: (context, state) {
                                return CustomButton(
                                  text: AppLocalization.of(
                                    context,
                                  ).translate("search"),
                                  onPressed: () {
                                    BlocProvider.of<HomeBloc>(context).add(
                                      GetProductsByLocationEvent(
                                        500,
                                        36.218760,
                                        33.525022,
                                        // todo enable them later
                                        // (_radius * 1000).toInt(),
                                        // _center!.longitude,
                                        // _center!.latitude,
                                        context,
                                      ),
                                    );
                                  },
                                  isLoading:
                                      state.productsByLocationState ==
                                      StateEnum.loading,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
