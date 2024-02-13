import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:futamap/util/consts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import '../../theme/colors.dart' as futa_map_colors;
import '../../data/model/location.dart' as futa_map_location;

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});
  static const routeName = '/mapNavigationArguments';

  @override
  State<StatefulWidget> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  late double _deviceHeight, _deviceWidth;

  final _db = FirebaseFirestore.instance;
  final List<Marker> _locations = [];

  final Completer<GoogleMapController> _mapController = Completer();

  StreamSubscription<LocationData>? _locationSubscription;
  LocationData? _locationData;
  Location location = Location();
  GeoPoint? destination;

  final Map<PolylineId, Polyline> _polyLines = {};

  @override
  void initState() {
    super.initState();
    // FirebaseAuth.instance.signOut();
    getLocations();
    getLocation().then((_) => {
          if (destination != null)
            {
              getPolyLinePoints(
                      LatLng(destination!.latitude, destination!.longitude))
                  .then(
                (value) => generatePolyLineFromPoints(value),
              )
            }
        });
  }

  final LatLng _center = const LatLng(7.292040, 5.151219);

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    destination = ModalRoute.of(context)!.settings.arguments as GeoPoint?;
    debugPrint("Destination: $destination");
    return Scaffold(
      backgroundColor: futa_map_colors.Colors.surface,
      body: SizedBox(
        width: _deviceWidth,
        height: _deviceHeight,
        child: _locationData == null
            ? const Center(
                child: Text(
                  "Loading...",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
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
                  ..._locations,
                  Marker(
                    markerId: const MarkerId('Current Location'),
                    position: _locationData != null
                        ? LatLng(
                            _locationData!.latitude!, _locationData!.longitude!)
                        : _center,
                  ),
                  if (destination != null)
                    Marker(
                      markerId: const MarkerId('Destination'),
                      position:
                          LatLng(destination!.latitude, destination!.longitude),
                    ),
                },
                polylines: Set<Polyline>.of(_polyLines.values),
              ),
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
    _locationSubscription =
        location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        _locationData = currentLocation;
        // if (destination != null) {
        //   _cameraToPosition(
        //       LatLng(currentLocation.latitude!, currentLocation.longitude!));
        // }
      });
    });
    return;
  }

  Future<List<LatLng>> getPolyLinePoints(LatLng destination) async {
    final List<LatLng> polylineCoordinates = [];

    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      GOOGLE_MAPS_API_KEY,
      PointLatLng(_locationData?.latitude ?? _center.latitude,
          _locationData?.longitude ?? _center.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.walking,
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        debugPrint("Point: $point");
      }
    } else {
      debugPrint('$result.errorMessage');
    }
    return polylineCoordinates;
  }

  void generatePolyLineFromPoints(List<LatLng> polylines) async {
    PolylineId id = const PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylines,
      width: 8,
    );

    setState(() => _polyLines[id] = polyline);
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
  }

  Future<void> getLocations() async {
    debugPrint("GetLocations called");
    List<futa_map_location.Location> locations = [];
    await _db.collection('places').get().then(
          (value) => {
            for (int i = 0; i < value.docs.length; i++)
              locations.add(futa_map_location.Location.fromMap(value.docs[i]))
          },
        );
    // setState(() {
    //   _locations.addAll(locations.map(
    //     (e) => Marker(
    //       markerId: MarkerId(e.name),
    //       position: LatLng(e.latlng!.latitude, e.latlng!.longitude),
    //     ),
    //   ));
    // });
  }
}
