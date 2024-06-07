import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  LatLng? _currentPosition; // Start with null
  late final MapController _mapController;
  bool _isMapInitialized = false;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _requestPermission();
  }

  void _requestPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      print('Location Permission granted');
      // Now you can safely get the current location
      if (_isMapInitialized) {
        _getCurrentLocation();
      }
    } else if (status.isDenied) {
      print('Location Permission denied');
    } else if (status.isPermanentlyDenied) {
      print('Location Permission permanently denied');
    }
  }

  void _getCurrentLocation() async {
    // Use async/await for clarity
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _mapController.move(_currentPosition!, 11.0);
      });
    } catch (e) {
      print("Error getting location: $e");
      // Handle location errors appropriately
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialZoom: 8,
          onMapReady: () {
            setState(() {
              _isMapInitialized = true;
            });
            // Now you can safely get the current location
            _getCurrentLocation();
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          if (_currentPosition != null)
            CircleLayer(
              circles: [
                CircleMarker(
                  point: _currentPosition!,
                  radius: 10,
                  color: Colors.blue.withOpacity(0.5),
                  borderStrokeWidth: 2,
                  borderColor: Colors.blue,
                ),
              ],
            ),
          RichAttributionWidget(
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
              )
            ],
          ),
        ],
      ),
    );
  }
}
