import 'package:equatable/equatable.dart';
import 'package:traveller/weather/model/weather.dart';

abstract class WeatherState extends Equatable {
  WeatherState([List prop = const []]) : super();
}

class WeatherEmpty extends WeatherState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class WeatherLoading extends WeatherState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class WeatherLoaded extends WeatherState {
  final Weather weather;

  WeatherLoaded({required this.weather}) : super([weather]);

  @override
  List<Object> get props => throw UnimplementedError();
}

class WeatherError extends WeatherState {
  final int errorCode;

  WeatherError({required this.errorCode}) : super([errorCode]);

  @override
  List<Object> get props => throw UnimplementedError();
}
