import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  const Maps({
    Key? key,
    required this.currentLocation,
    required this.latitude,
    required this.longitude,
  });

  final Position? currentLocation;
  final double latitude;
  final double longitude;

  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    _addCustomMarkerIcon();
    super.initState();
  }

  void _addCustomMarkerIcon() async {
    final icon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), "images/gps.png");
    setState(() {
      markerIcon = icon;
    });
  }

  Future<List<PointLatLng>?> _getPolylinePoints(
      Position? currentLocation, double latitude, double longitude) async {
    PolylinePoints polylinePoints = PolylinePoints();

    if (currentLocation != null) {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyAWevH32YxcDu0lHWiqvRMQTlWHkNHcZ4k",
        PointLatLng(currentLocation.latitude, currentLocation.longitude),
        PointLatLng(latitude, longitude),
        travelMode: TravelMode.driving,
      );
      return result.points;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final _center = LatLng(
      widget.latitude,
      widget.longitude,
    );

    return FutureBuilder<List<PointLatLng>?>(
        future: _getPolylinePoints(
          widget.currentLocation,
          widget.latitude,
          widget.longitude,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 25),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Map loading...',
                      style: TextStyle(
                        fontSize: 8,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (snapshot.hasError || !snapshot.hasData) return SizedBox.shrink();

          final polyLines = snapshot.data;
          Map<PolylineId, Polyline> polylinesMap = {};
          List<LatLng> polylineCoordinates = [];

          if (polyLines != null && polyLines.isNotEmpty) {
            polyLines.forEach((PointLatLng point) {
              polylineCoordinates.add(LatLng(point.latitude, point.longitude));
            });
          }

          final id = PolylineId('route');
          Polyline polyline = Polyline(
            polylineId: id,
            color: Colors.red,
            points: polylineCoordinates,
            width: 3,
          );

          polylinesMap[id] = polyline;

          return SizedBox(
            height: 300,
            child: GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 10,
              ),
              onMapCreated: (GoogleMapController controller) {
                try {
                  _controller.complete(controller);
                } catch (e) {
                  return;
                }
              },
              polylines: Set<Polyline>.of(polylinesMap.values),
              markers: {
                Marker(
                  markerId: const MarkerId('destination'),
                  position: LatLng(
                    widget.latitude,
                    widget.longitude,
                  ),
                ),
                if (widget.currentLocation != null)
                  Marker(
                    markerId: const MarkerId('current'),
                    position: LatLng(
                      widget.currentLocation?.latitude ?? 0,
                      widget.currentLocation?.longitude ?? 0,
                    ),
                    icon: markerIcon,
                  ),
              },
            ),
          );
        });
  }
}
