import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

Future<bool> handleLocationPermission(BuildContext context) async {
  // Position position = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high);

  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  var messenger = ScaffoldMessenger.of(context);
  if (!serviceEnabled) {
    messenger.showSnackBar(const SnackBar(
      content:
          Text('Location services are disabled. Please enable the services'),
    ));
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      messenger.showSnackBar(const SnackBar(
        content: Text('Location permissions are denied'),
      ));
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    messenger.showSnackBar(const SnackBar(
      content: Text(
          'Location permissions are permanently denied, we cannot request permissions.'),
    ));
    return false;
  }
  return true;
}
