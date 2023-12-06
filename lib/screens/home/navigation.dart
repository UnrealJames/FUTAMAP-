import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../theme/colors.dart' as futa_map_colors;
import '../../util/util.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  late double _deviceHeight, _deviceWidth;
  int currentPageIndex = 1;

  String? _currentAddress;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }

  late GoogleMapController mapController;
  final LatLng _center = const LatLng(7.292040, 5.151219);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: _deviceWidth,
      height: _deviceHeight,
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _currentPosition != null
              ? LatLng(_currentPosition!.latitude, _currentPosition!.longitude)
              : _center,
          zoom: 13.0,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('Current Location'),
            position: _currentPosition != null
                ? LatLng(
                    _currentPosition!.latitude, _currentPosition!.longitude)
                : _center,
          ),
        },
      ),
    );
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await handleLocationPermission(context);
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }
}
