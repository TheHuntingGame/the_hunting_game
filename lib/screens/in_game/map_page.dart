import 'package:flutter/material.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:the_hunting_game/compass/compass.dart';
import 'package:the_hunting_game/components/user_marker.dart';
import 'dart:async';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng? _currentPosition;
  late final MapController _mapController;
  bool _isMapInitialized = false;
  bool _isCenteredOnUser = true;
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
      distanceFilter: 5, // minimum distance to trigger update
    );

    _positionStreamSubscription =
        Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (Position position) {
        if (mounted) {
          setState(() {
            _currentPosition = LatLng(position.latitude, position.longitude);
            if (_isCenteredOnUser) {
              _mapController.move(_currentPosition!,
                  16); // Keep the map centered if the icon is blue
            } else {
              // Map has been moved by the user, update the icon color
              setState(() {
                _isCenteredOnUser = false;
              });
            }
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

  String _getTileLayerUrl() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode
        ? 'https://basemaps.cartocdn.com/dark_all/{z}/{x}/{y}@2x.png'
        : 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              interactionOptions: const InteractionOptions(
                enableMultiFingerGestureRace: true,
                flags: InteractiveFlag.doubleTapDragZoom |
                    InteractiveFlag.doubleTapZoom |
                    InteractiveFlag.drag |
                    InteractiveFlag.flingAnimation |
                    InteractiveFlag.pinchZoom |
                    InteractiveFlag.scrollWheelZoom |
                    InteractiveFlag.rotate,
              ),
              initialZoom: 8,
              maxZoom: 19,
              minZoom: 5.0,
              onMapReady: () {
                if (mounted) {
                  setState(() {
                    _isMapInitialized = true;
                  });
                  _getCurrentLocation();
                  _startLocationUpdates();
                }
              },
              onPositionChanged: (MapCamera position, bool hasGesture) {
                if (hasGesture) {
                  setState(() {
                    _isCenteredOnUser = false;
                  });
                }
              },
            ),
            children: [
              TileLayer(
                tileProvider: CancellableNetworkTileProvider(),
                urlTemplate: _getTileLayerUrl(),
                tileSize:256,
                keepBuffer:2,
                userAgentPackageName: 'com.example.app',
              ),
              
              const MapCompass.cupertino(
                hideIfRotatedNorth: false,
              ),
              if (_currentPosition != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 24,
                      height: 24,
                      point: _currentPosition!,
                      child: const UserLocationMarker(),
                    ),
                  ],
                ),
              const RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(
                    'OpenStreetMap contributors',
                  )
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 92,
            right: 32,
            child: IconButton(
              icon: Icon(
                Icons.my_location_outlined,
                color: _isCenteredOnUser ? Colors.blue : Colors.grey,
                size: 64,
              ),
              onPressed: () {
                if (_currentPosition != null) {
                  setState(() {
                    _isCenteredOnUser = true;
                  });
                  _mapController.move(
                      _currentPosition!, 16); // Zoom level 16 for closer view
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
