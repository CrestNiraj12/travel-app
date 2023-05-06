import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveller/states/current_location/current_location.provider.dart';

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var a = 0.5 -
      cos((lat2 - lat1) * p) / 2 +
      cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}

String getDistance(WidgetRef ref, GeoPoint destination) {
  final pos = ref.read(currentLocationProvider).data;

  if (pos == null) return 'distance unavailable';

  return calculateDistance(
        pos.latitude,
        pos.longitude,
        destination.latitude,
        destination.longitude,
      ).toStringAsFixed(2) +
      ' km/s away';
}
