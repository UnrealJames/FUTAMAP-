import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../theme/colors.dart' as futa_map_colors;
import '../../util/util.dart';
import 'package:location/location.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  late double _deviceHeight, _deviceWidth;
  int currentPageIndex = 1;

  final Completer<GoogleMapController> _mapController = Completer();
  String? _currentAddress;
  // Position? _currentPosition;
  LocationData? _locationData;
  Location location = Location();

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  var locations = {
    const Marker(
      markerId: MarkerId('SET Building'),
      position: LatLng(7.305118052707932, 5.135239469531077),
    ),
    const Marker(
      markerId: MarkerId('SEET Building'),
      position: LatLng(7.308119104394952, 5.132149552909689),
    ),
    const Marker(
      markerId: MarkerId('SAAT Building'),
      position: LatLng(7.305990571050196, 5.1397887288105),
    ),
    const Marker(
      markerId: MarkerId('Multipurpose Hall'),
      position: LatLng(7.30253389777358, 5.135620700789852),
    ),
    const Marker(
      markerId: MarkerId('SLS Building'),
      position: LatLng(7.301373405807791, 5.134965498297722),
    ),
    const Marker(
      markerId: MarkerId('GNS Building'),
      position: LatLng(7.305990571050196, 5.1397887288105),
    ),
    const Marker(
      markerId: MarkerId('New 1000 Capacity Lecture Theatre'),
      position: LatLng(7.301852322590822, 5.135322185901965),
    ),
    const Marker(
      markerId: MarkerId('Senate Building'),
      position: LatLng(7.303274061822791, 5.135747043867175),
    ),
    const Marker(
      markerId: MarkerId('SPS Building'),
      position: LatLng(7.305990571050196, 5.1397887288105),
    ),
  };

  // late GoogleMapController mapController;
  final LatLng _center = const LatLng(7.292040, 5.151219);

  // void _onMapCreated(GoogleMapController controller) {
  //   mapController = controller;
  // }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    final args = ModalRoute.of(context)!.settings.arguments as LatLng?;
    return SizedBox(
      width: _deviceWidth,
      height: _deviceHeight,
      child: _locationData == null
          ? const Center(
              child: Text(
                "Loading...",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : GoogleMap(
              onMapCreated: ((controller) =>
                  _mapController.complete(controller)),
              initialCameraPosition: CameraPosition(
                target: _locationData != null
                    ? LatLng(
                        _locationData!.latitude!, _locationData!.longitude!)
                    : _center,
                zoom: 15.0,
              ),
              markers: {
                ...locations,
                Marker(
                  markerId: const MarkerId('Current Location'),
                  position: _locationData != null
                      ? LatLng(
                          _locationData!.latitude!, _locationData!.longitude!)
                      : _center,
                ),
              },
            ),
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final googleMapController = await _mapController.future;
    return await googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: pos,
        zoom: 15.0,
      ),
    ));
  }

  // Future<void> _getCurrentPosition() async {
  //   final hasPermission = await handleLocationPermission(context);
  //   if (!hasPermission) return;
  //   await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
  //       .then((Position position) {
  //     setState(() => _currentPosition = position);
  //   }).catchError((e) {
  //     debugPrint(e);
  //   });
  // }

  Future<void> getLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    location.enableBackgroundMode(enable: true);
    location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        _locationData = currentLocation;
        _cameraToPosition(
            LatLng(currentLocation.latitude!, currentLocation.longitude!));
      });
    });
    return;
  }
}
