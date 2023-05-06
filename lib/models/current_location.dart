import 'package:geolocator/geolocator.dart';

class CurrentLocation {
  static final CurrentLocation _instance = CurrentLocation._();
  Position? currentPosition;

  CurrentLocation._();

  factory CurrentLocation() {
    return _instance;
  }

  set CurrentPosition(Position? value) {
    this.currentPosition = value;
  }

  Position? get CurrentPosition => this.currentPosition;
}
