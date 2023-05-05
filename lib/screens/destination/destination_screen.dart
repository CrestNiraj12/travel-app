import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:traveller/models/destination.dart';
import 'package:traveller/utils/current_location.dart';

class DestinationScreen extends StatefulWidget {
  const DestinationScreen({
    required this.destination,
  });

  final Destination destination;

  @override
  _DestinationScreenState createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  late String firstHalf;
  late String secondHalf;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  Position? _currentLocation;

  @override
  void initState() {
    _addCustomMarkerIcon();
    _getCurrentLocation();
    super.initState();
  }

  void _addCustomMarkerIcon() async {
    final icon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), "images/gps.png");
    setState(() {
      markerIcon = icon;
    });
  }

  Future<List<PointLatLng>?> _getPolylinePoints(GeoPoint destination) async {
    PolylinePoints polylinePoints = PolylinePoints();

    if (_currentLocation != null) {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyAWevH32YxcDu0lHWiqvRMQTlWHkNHcZ4k",
        PointLatLng(_currentLocation!.latitude, _currentLocation!.longitude),
        PointLatLng(destination.latitude, destination.longitude),
        travelMode: TravelMode.driving,
      );
      return result.points;
    }

    return null;
  }

  bool flag = true;

  void _getCurrentLocation() async {
    final pos = await getCurrentLocation();
    if (mounted)
      setState(() {
        _currentLocation = pos;
      });
  }

  @override
  Widget build(BuildContext context) {
    final destination = widget.destination;
    final _center = LatLng(
      destination.location.latitude,
      destination.location.longitude,
    );

    if (destination.description.length > 50) {
      firstHalf = destination.description.substring(0, 100);
      secondHalf =
          destination.description.substring(50, destination.description.length);
    } else {
      firstHalf = destination.description;
      secondHalf = "";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(destination.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 220,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                child: Image.network(
                  destination.imageUrl,
                  fit: BoxFit.fill,
                  height: 280,
                  width: double.infinity,
                ),
              ),
            ),
            FutureBuilder<List<PointLatLng>?>(
                future: _getPolylinePoints(destination.location),
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

                  if (snapshot.hasError || !snapshot.hasData)
                    return SizedBox.shrink();

                  final polyLines = snapshot.data;
                  Map<PolylineId, Polyline> polylinesMap = {};
                  List<LatLng> polylineCoordinates = [];

                  if (polyLines != null && polyLines.isNotEmpty) {
                    polyLines.forEach((PointLatLng point) {
                      polylineCoordinates
                          .add(LatLng(point.latitude, point.longitude));
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
                            destination.location.latitude,
                            destination.location.longitude,
                          ),
                        ),
                        if (_currentLocation != null)
                          Marker(
                            markerId: const MarkerId('current'),
                            position: LatLng(
                              _currentLocation!.latitude,
                              _currentLocation!.longitude,
                            ),
                            icon: markerIcon,
                          ),
                      },
                    ),
                  );
                }),
            Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 3, left: 15, right: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Card(
                        child: Container(
                            height: 90,
                            color: Color.fromRGBO(55, 70, 105, 1),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 90,
                                  width: 70,
                                  color: Color.fromRGBO(95, 115, 150, 1),
                                  child: Icon(
                                    Icons.flag,
                                    color: Colors.white,
                                    size: 60,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              "Country :",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 7,
                                            ),
                                            Text(
                                              destination.country,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              "Place :",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 7,
                                            ),
                                            Text(
                                              destination.name,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 15.0, top: 8, left: 15, right: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Card(
                        color: Color.fromRGBO(55, 70, 105, 1),
                        child: Column(
                          children: <Widget>[
                            Container(
                                color: Color.fromRGBO(95, 115, 150, 1),
                                height: 30,
                                width: double.infinity,
                                child: Center(
                                  child: Text(
                                    "Description",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                )),
                            SizedBox(
                              height: 1,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 5.0),
                              color: Color.fromRGBO(55, 70, 105, 1),
                              child: secondHalf.isEmpty
                                  ? new Text(firstHalf)
                                  : new Column(
                                      children: <Widget>[
                                        new Text(
                                          flag
                                              ? (firstHalf + "...")
                                              : (firstHalf + secondHalf),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                        new InkWell(
                                          child: new Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              new Text(
                                                flag
                                                    ? "show more"
                                                    : "show less",
                                                style: new TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          onTap: () {
                                            setState(() {
                                              flag = !flag;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
