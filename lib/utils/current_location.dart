import 'package:geolocator/geolocator.dart';

Future<Position> getCurrentLocation() async {
  final pos = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
  return pos;
}
