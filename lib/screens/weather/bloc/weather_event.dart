import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  WeatherEvent([List props = const []]) : super();
}

class FetchWeather extends WeatherEvent {
  final String? cityName;
  final double? longitude;
  final double? latitude;

  FetchWeather({this.cityName, this.longitude, this.latitude})
      : super([cityName, longitude, latitude]);

  @override
  List<Object> get props => throw UnimplementedError();
}
