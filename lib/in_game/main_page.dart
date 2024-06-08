import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:the_hunting_game/components/compass/compass.dart';
import 'dart:async';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  LatLng? _currentPosition;
  late final MapController _mapController;
  bool _isMapInitialized = false;
  StreamSubscription<Position>? _positionStreamSubscription;

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
      if (_isMapInitialized && mounted) {
        _getCurrentLocation();
        _startLocationUpdates();
      }
    } else if (status.isDenied) {
      print('Location Permission denied');
    } else if (status.isPermanentlyDenied) {
      print('Location Permission permanently denied');
    }
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      if (mounted) {
        setState(() {
          _currentPosition = LatLng(position.latitude, position.longitude);
          _mapController.move(_currentPosition!, 14);
        });
      }
    } catch (e) {
      if (mounted) {
        print("Error getting location: $e");
      }
    }
  }

  void _startLocationUpdates() {
    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10, // minimum distance to trigger updt
    );

    _positionStreamSubscription =
        Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (Position position) {
        if (mounted) {
          setState(() {
            _currentPosition = LatLng(position.latitude, position.longitude);
          });
        }
      },
      onError: (e) {
        if (mounted) {
          print("Error in location stream: $e");
        }
      },
    );
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
              interactionOptions: const InteractionOptions(
                enableMultiFingerGestureRace: true,
                flags: InteractiveFlag.doubleTapDragZoom |
                       InteractiveFlag.doubleTapZoom |
                       InteractiveFlag.drag |
                       InteractiveFlag.flingAnimation |
                       InteractiveFlag.pinchZoom |
                       InteractiveFlag.scrollWheelZoom|
                       InteractiveFlag.rotate,
              ),
          initialZoom: 8,
          onMapReady: () {
            if (mounted) {
              setState(() {
                _isMapInitialized = true;
              });
              _getCurrentLocation();
              _startLocationUpdates();
            }
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          const MapCompass.cupertino(
            hideIfRotatedNorth: false,
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

